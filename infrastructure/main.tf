data "azurerm_client_config" "current" {
}

data "azurerm_subscription" "current" {
}

data "azurerm_dns_zone" "main" {
  name                = var.domain
  resource_group_name = var.dns_rg
}

output "dns_zone_id" {
  value = data.azurerm_dns_zone.main.id
}

locals {
  key_vault_private_dns_zone = "privatelink.vaultcore.azure.net"
  vm_public_ip = "${tostring(module.virtual_machine.public_ip)}"
  fw_public_ip = "${tostring(module.firewall.fw_public_ip)}"

  cert_manager_namespace = "cert-manager"
  cert_manager_service_account = "cert-manager"
}

resource "azurerm_resource_group" "main" {
  name = var.rg_name
  location = var.location
}

module "log_analytics_workspace" {
  source                           = "./modules/log_analytics_workspace"
  name                             = var.log_analytics_workspace_name
  location                         = var.location
  resource_group_name              = azurerm_resource_group.main.name
}

module "hub_vnet" {
  source = "./modules/vnet"
  resource_group_name = azurerm_resource_group.main.name
  location = var.location
  vnet_name = var.hub_vnet
  address_space = var.hub_address_space
  log_analytics_workspace_id   = module.log_analytics_workspace.id
  log_analytics_retention_days = var.log_analytics_retention_days
  
  subnets = [
    {
      name : "AzureFirewallSubnet"
      address_prefixes : var.firewall_subnet_address_prefix
    },

    {
      name : "azureVMSubnet"
      address_prefixes : var.vm_subnet_address_prefix
    }
  ]

  tags = var.tags
}

module "aks_vnet" {
  source = "./modules/vnet"
  resource_group_name = azurerm_resource_group.main.name
  location = var.location
  vnet_name = var.aks_vnet
  address_space = var.aks_address_space
  log_analytics_workspace_id   = module.log_analytics_workspace.id
  log_analytics_retention_days = var.log_analytics_retention_days
  
  subnets = [
    {
      name : "aksNodePoolSubnet"
      address_prefixes : var.aks_subnet_address_prefix
    },

    {
      name : "ingNodePoolSubnet"
      address_prefixes : var.ing_subnet_address_prefix
    }
  ]

  tags = var.tags
}

module "vnet_peering" {
  source = "./modules/vnet_peering"
  vnet_1_name         = var.hub_vnet
  vnet_1_id           = module.hub_vnet.vnet_id
  vnet_1_resource_group_name           = azurerm_resource_group.main.name
  vnet_2_name         = var.aks_vnet
  vnet_2_id           = module.aks_vnet.vnet_id
  vnet_2_resource_group_name           = azurerm_resource_group.main.name
  peering_name_1_to_2 = "${var.hub_vnet}to${var.aks_vnet}"
  peering_name_2_to_1 = "${var.aks_vnet}to${var.hub_vnet}"
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
  ingress_ip                   = var.ingress_ip
  log_analytics_workspace_id   = module.log_analytics_workspace.id
  log_analytics_retention_days = var.log_analytics_retention_days 
}

resource "azurerm_dns_a_record" "main" {
  name                = "*"
  zone_name           = var.domain
  resource_group_name = var.dns_rg
  ttl                 = 300
  records             = [module.firewall.fw_public_ip]
}

module "routetable" {
  source               = "./modules/route_table"
  resource_group_name  = azurerm_resource_group.main.name
  location             = var.location
  route_table_name     = var.route_table_name
  firewall_private_ip  = module.firewall.private_ip_address
  subnet_id            = module.aks_vnet.subnet_ids["aksNodePoolSubnet"]
  tags                 = var.tags
}

module "aks_cluster" {
  source                                   = "./modules/aks"
  name                                     = var.aks_cluster_name
  location                                 = var.location
  resource_group_name                      = azurerm_resource_group.main.name
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
  network_dns_service_ip                   = var.network_dns_service_ip
  network_plugin                           = var.network_plugin
  log_analytics_workspace_id               = module.log_analytics_workspace.id
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

#User identity for cert-manager dns01 solver
resource "azurerm_user_assigned_identity" "cert-manager" {
  location            = azurerm_resource_group.main.location
  name                = "cert-manager"
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_role_assignment" "dns_contributor" {
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "DNS Zone Contributor"
  principal_id         = azurerm_user_assigned_identity.cert-manager.principal_id
  skip_service_principal_aad_check = true
}

resource "azurerm_federated_identity_credential" "cert-manager" {
  name                = "cert-manager"
  resource_group_name = azurerm_resource_group.main.name
  audience            = ["api://AzureADTokenExchange"]
  issuer              = module.aks_cluster.oidc_issuer_url
  parent_id           = azurerm_user_assigned_identity.cert-manager.id
  subject             = "system:serviceaccount:${local.cert_manager_namespace}:${local.cert_manager_service_account}"
}

module "virtual_machine" {
  source                              = "./modules/virtual_machine"
  name                                = var.vm_name
  location                            = var.location
  vm_user                             = var.admin_username
  ssh_public_key                      = var.ssh_public_key
  os_disk_size                        = var.os_disk_size
  os_disk_image                       = var.os_disk_image
  resource_group_name                 = azurerm_resource_group.main.name
  subnet_id                           = module.hub_vnet.subnet_ids["azureVMSubnet"]
  tags                                = var.tags
  vnet_id                             = module.hub_vnet.vnet_id
  dns_zone_name                       = join(".", slice(split(".", module.aks_cluster.private_fqdn), 1, length(split(".", module.aks_cluster.private_fqdn))))
  dns_resource_group_name             = module.aks_cluster.node_resource_group
}

resource "azurerm_role_assignment" "aks_cluster_user" {
  scope                = azurerm_resource_group.main.id
  role_definition_name = "Azure Kubernetes Service Cluster User Role"
  principal_id         = module.virtual_machine.vm_identity_principal_id
  skip_service_principal_aad_check = true
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
  name = local.key_vault_private_dns_zone
  resource_group_name = azurerm_resource_group.main.name
  tags                = var.tags

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_private_dns_zone_virtual_network_link" "key_vault" {
  for_each = {
    (module.hub_vnet.vnet_name) = (module.hub_vnet.vnet_id)
    (module.aks_vnet.vnet_name) = (module.aks_vnet.vnet_id)
  }

  name                  = "link_to_${lower(basename(each.key))}"
  resource_group_name   = azurerm_resource_group.main.name
  private_dns_zone_name = local.key_vault_private_dns_zone
  virtual_network_id    = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${azurerm_resource_group.main.name}/providers/Microsoft.Network/virtualNetworks/${each.key}"

  lifecycle {
    ignore_changes = [
      tags
    ]
  }

  depends_on = [azurerm_private_dns_zone.key_vault]
}

resource "azurerm_private_endpoint" "key_vault" {
  name                = "${title(module.key_vault.name)}PrivateEndpoint"
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  subnet_id           = module.hub_vnet.subnet_ids["azureVMSubnet"]
  tags                = var.tags

  private_service_connection {
    name                           = "kvPrivateEndpointConnection"
    private_connection_resource_id = module.key_vault.id
    is_manual_connection           = false
    subresource_names              = ["vault"]
  }

  private_dns_zone_group {
    name                 = "KeyVaultPrivateDnsZoneGroup"
    private_dns_zone_ids = [azurerm_private_dns_zone.key_vault.id]
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}



resource "null_resource" "copy_vm_ip" {
  triggers = {
    public_ip = "${local.vm_public_ip}"
    fw_public_ip = "${local.fw_public_ip}"
  }

#On resource creation
  provisioner "local-exec" {
    command = "echo '${self.triggers.public_ip}' > ../infrastructure-addons/host-inventory" 
  }

#On resource destruction
  provisioner "local-exec" {
    when = destroy
    command = "truncate -s 0 ../infrastructure-addons/host-inventory"
  }

  depends_on = [module.virtual_machine]
}

