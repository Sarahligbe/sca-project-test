resource "azurerm_storage_account" "storage_account" {
  name                      = var.name
  resource_group_name       = var.resource_group_name
  location                  = var.location
  account_tier              = "Premium"
  account_replication_type  = "LRS"
  account_kind              = "FileStorage"
  enable_https_traffic_only = true
  tags                      = var.tags
  # We are enabling the firewall only allowing traffic from our PC's public IP.
  network_rules {
    default_action             = "Deny"
    virtual_network_subnet_ids = []
  }
}

resource "azurerm_private_dns_zone" "private_sa_dns" {
  name                = "privatelink.file.core.windows.net"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "sa_link" {
  name                  = "aksvolumelink"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.private_sa_dns.name
  virtual_network_id    = var.vnet_id
}