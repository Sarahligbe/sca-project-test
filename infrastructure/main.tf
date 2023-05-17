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
      name : "azureBastionSubnet"
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