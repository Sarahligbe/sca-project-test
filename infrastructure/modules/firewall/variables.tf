variable "public_ip_name" {
  description = "Specifies the name of the firewall's public IP"
  type = string
  default = "sca-fw-ip"
}

variable "resource_group_name" {
  description = "Specifies the resource group"
  type = string
}

variable "location" {
  description = "Specifies the Azure region where the firewall is provisioned"
  type = string
}

variable "zones" {
  description = "Specifies the availability zones in the region"
  type = list(string)
  default = [ "1", "2", "3" ]
}

variable "tags" {
  description = "Specifies the tags to label the firewall"
  type = map
}

variable "fw_name" {
  description = "Specifies the name of the firewall"
  type = string
}

variable "sku_name" {
  description = "Specifies the SKU name of the firewall"
  type = string
  default = "AZFW_VNet"
}

variable "sku_tier" {
  description = "Specifies the SKU tier of the firewall"
  type = string
  default = "Standard"
}

variable "threat_intel_mode" {
  description = "Specifies the operation mode for threat intelligence-based filtering"
  type = string
  default = "Alert"
}

variable "subnet_id" {
  description = "References the subnet ID associated with the IP config"
  type = string
}