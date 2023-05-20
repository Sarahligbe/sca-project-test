output "vm_identity_principal_id" {
  value       = azurerm_user_assigned_identity.vm_identity.principal_id
  description = "Specifies the principal id of the managed identity of the AKS cluster."
}

output "public_ip" {
  value = azurerm_linux_virtual_machine.main.public_ip_address
  description = "Specifies the public IP assigned to the VM"
}