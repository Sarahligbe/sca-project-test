output "private_ip_address" {
  description = "Specifies the private IP address of the firewall."
  value = azurerm_firewall.main.ip_configuration[0].private_ip_address
}

output "fw_public_ip" {
  description = "Specifies the public IP address of the firewall."
  value = azurerm_public_ip.public_ip.ip_address
}