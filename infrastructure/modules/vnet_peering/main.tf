resource "azurerm_virtual_network_peering" "from-hub" {
  name                      = var.peering_name_hub
  hub_resource_group_name       = var.resource_group_name
  virtual_network_name      = var.hub_vnet_name
  remote_virtual_network_id = var.aks_vnet_id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

resource "azurerm_virtual_network_peering" "to-hub" {
  name                      = var.peering_name_aks
  aks_resource_group_name       = var.resource_group_name
  virtual_network_name      = var.aks_vnet_name
  remote_virtual_network_id = var.hub_vnet_id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}