resource "azurerm_route_table" "main" {
  name                = var.route_table_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  route {
    name                   = "aks_net_fw_route"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = var.firewall_private_ip
  }

  lifecycle {
    ignore_changes = [
      tags,
      route
    ]
  }
}

resource "azurerm_subnet_route_table_association" "subnet_association" {
  subnet_id      = var.subnet_id
  route_table_id = azurerm_route_table.main.id
}