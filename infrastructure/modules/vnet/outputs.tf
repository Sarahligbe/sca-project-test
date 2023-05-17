output vnet_id {
  description = "Specifies the vnet id of the virtual network"
  value       = azurerm_virtual_network.vnet.id
}

output subnet_ids {
 description = "Contains a map of the subnet ids of the subnets"
  value       = { for subnet in azurerm_subnet.subnet : subnet.name => subnet.id }
}