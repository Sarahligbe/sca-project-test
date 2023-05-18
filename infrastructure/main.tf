data "azurerm_client_config" "current" {
}

locals {
  key_vault_private_dns_zone = "privatelink.vaultcore.azure.net"
}

resource "azurerm_resource_group" "main" {
  name = var.rg_name
  location = var.location
}

module "hub_vnet" {
  source = "./modules/vnet"
  resource_group_name = azurerm_resource_group.main
  location = var.location
  vnet_name = var.hub_vnet
  address_space = var.hub_address_space
  
  subnet = [
    {
      name : "AzureFirewallSubnet"
      address_prefixes : var.firewall_subnet_address_prefix
    },

    {
      name : "AzureBastionSubnet"
      address_prefixes : var.bastion_subnet_address_prefix
    }
  ]

  tags = var.tags
}

module "aks_vnet" {
  source = "./modules/vnet"
  resource_group_name = azurerm_resource_group.main
  location = var.location
  vnet_name = var.aks_vnet
  address_space = var.aks_address_space
  
  subnet = [
    {
      name : "aksNodePoolSubnet"
      address_prefixes : var.aks_subnet_address_prefix
    },

    {
      name : "azureVMSubnet"
      address_prefixes : var.vm_subnet_address_prefix
    }
  ]

  tags = var.tags
}

module "vnet_peering" {
  source = "./modules/vnet_peering"
  hub_vnet_name         = var.hub_vnet
  hub_vnet_id           = module.hub_vnet.vnet_id
  hub_resource_group_name           = azurerm_resource_group.main.name
  aks_vnet_name         = var.aks_vnet
  aks_vnet_id           = module.aks_vnet.vnet_id
  aks_resource_group_name           = azurerm_resource_group.main.name
  peering_name_hub = "${var.hub_vnet_name}to${var.aks_vnet_name}"
  peering_name_spoke = "${var.aks_vnet_name}to${var.hub_vnet_name}"
}

module "firewall" {
  source                       = "./modules/firewall"
  fw_name                      = var.fw_name
  resource_group_name          = azurerm_resource_group.main.name
  zones                        = var.zones
  threat_intel_mode            = var.fw_threat_intel_mode
  location                     = var.location
  sku_name                     = var.fw_sku_name 
  sku_tier                     = var.fw_sku_tier
  public_ip_name               = var.public_ip_name
  subnet_id                    = module.hub_vnet.subnet_ids["AzureFirewallSubnet"]
  tags                         = var.tags
}

module "routetable" {
  source               = "./modules/route_table"
  resource_group_name  = azurerm_resource_group.main.name
  location             = var.location
  route_table_name     = var.route_table_name
  route_name           = var.route_name
  firewall_private_ip  = module.firewall.private_ip_address
  subnet_id = module.aks_vnet.subnet_ids["aksNodePoolSubnet"]
}

module "aks_cluster" {
  source                                   = "./modules/aks"
  name                                     = var.aks_cluster_name
  location                                 = var.location
  resource_group_name                      = azurerm_resource_group.main.name
  resource_group_id                        = azurerm_resource_group.main.id
  kubernetes_version                       = var.kubernetes_version
  dns_prefix                               = var.dns_prefix
  private_cluster_enabled                  = true
  automatic_channel_upgrade                = var.automatic_channel_upgrade
  default_node_pool_name                   = var.default_node_pool_name
  default_node_pool_vm_size                = var.default_node_pool_vm_size
  vnet_subnet_id                           = module.aks_vnet.subnet_ids["aksNodePoolSubnet"]
  default_node_pool_availability_zones     = var.zones
  default_node_pool_enable_auto_scaling    = var.default_node_pool_enable_auto_scaling
  default_node_pool_max_pods               = var.default_node_pool_max_pods
  default_node_pool_max_count              = var.default_node_pool_max_count
  default_node_pool_min_count              = var.default_node_pool_min_count
  default_node_pool_node_count             = var.default_node_pool_node_count
  default_node_pool_os_disk_type           = var.default_node_pool_os_disk_type
  network_dns_service_ip                   = var.network_dns_service_ip
  network_plugin                           = var.network_plugin
  outbound_type                            = "userDefinedRouting"
  network_service_cidr                     = var.network_service_cidr
  admin_username                           = var.admin_username
  ssh_public_key                           = var.ssh_public_key
  workload_identity_enabled                = var.workload_identity_enabled
  oidc_issuer_enabled                      = var.oidc_issuer_enabled
  open_service_mesh_enabled                = var.open_service_mesh_enabled
  image_cleaner_enabled                    = var.image_cleaner_enabled
  azure_policy_enabled                     = var.azure_policy_enabled
  http_application_routing_enabled         = var.http_application_routing_enabled
  tags                                     = var.tags

  depends_on                               = [module.routetable]
}

resource "azurerm_role_assignment" "network_contributor" {
  scope                = azurerm_resource_group.main.id
  role_definition_name = "Network Contributor"
  principal_id         = module.aks_cluster.aks_identity_principal_id
  skip_service_principal_aad_check = true
}

module "bastion_host" {
  source                       = "./modules/bastion_host"
  bastion_name                 = var.bastion_host_name
  location                     = var.location
  resource_group_name          = azurerm_resource_group.main.name
  subnet_id                    = module.hub_vnet.subnet_ids["AzureBastionSubnet"]
}

module "virtual_machine" {
  source                              = "./modules/virtual_machine"
  name                                = var.vm_name
  size                                = var.vm_size
  location                            = var.location
  vm_user                             = var.admin_username
  ssh_public_key                      = var.ssh_public_key
  os_disk_size                        = var.os_disk_size
  os_disk_image                       = var.vm_os_disk_image
  resource_group_name                 = azurerm_resource_group.main.name
  subnet_id                           = module.aks_vnet.subnet_ids["azureVMSubnet"]
  os_disk_storage_account_type        = var.vm_os_disk_storage_account_type
  tags                                = var.tags
}

module "key_vault" {
  source                          = "./modules/key_vault"
  name                            = var.key_vault_name
  location                        = var.location
  resource_group_name             = azurerm_resource_group.main.name
  tenant_id                       = data.azurerm_client_config.current.tenant_id
  sku_name                        = var.key_vault_sku_name
  soft_delete_retention_days      = var.key_vault_soft_delete_retention_days
  bypass                          = var.key_vault_bypass
  default_action                  = var.key_vault_default_action

  tags                            = var.tags
}

resource "azurerm_private_dns_zone" "key_vault" {
  name = var.key_vault_private_dns_zone_name
  resorce_group_name = azurerm_resource_group.main.name
  tags                = var.tags

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_private_dns_zone_virtual_network_link" "key_vault" {
  for_each = {
    module.hub_vnet.vnet_name = module.hub_vnet.vnet_id
    module.aks_vnet.vnet_name = module.aks_vnet.vnet_id
  }

  name                  = "link_to_${lower(basename(each.key))}"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.key_vault.name
  virtual_network_id    = each.value

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}