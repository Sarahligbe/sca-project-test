output "object" {
  value = azurerm_bastion_host.bastion_host
  description = "Contains the bastion host resource"

  depends_on = [azurerm_bastion_host.bastion_host]
}

output "name" {
  value = azurerm_bastion_host.bastion_host.*.name
  description = "Specifies the name of the bastion host"

  depends_on = [azurerm_bastion_host.bastion_host]
}

output "id" {
  value = azurerm_bastion_host.bastion_host.*.id
  description = "Specifies the resource id of the bastion host"

  depends_on = [azurerm_bastion_host.bastion_host]
}