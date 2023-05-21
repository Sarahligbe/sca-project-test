output "resource_id" {
  value = azurerm_storage_account.storage_account.id
  description = "Specifies the resource id of the storage account."
}

output "private_dns_id" {
  value = azurerm_private_dns_zone.private_sa_dns.id
  description = "Specifies the resource id of the dns zone."
}
