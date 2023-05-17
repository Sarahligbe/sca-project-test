variable "rg_name" {
  type = string
  description = "The name of the resource group to deploy resources"
}

variable "location" {
  type = string
  description = "The Azure region to provision resources in"
  default = "West Europe"
}

variable "hub_vnet" {
  description = "Specifies the name of the hub virtual network"
  default = "hub_vnet"
  type = string
}

variable "tags" {
  description = "Specifies the tags to label resources"
  type = map
  default = {}
}

variable "hub_address_space" {
  description = "Specifies the address space for the hub virtual network"
  default = ["10.0.0.0/16"]
  type = list(string)
}

variable "firewall_subnet_address_prefix" {
  description = "Specifies the address prefix of the firewall subnet"
  default = ["10.0.0.0/24"]
  type = list(string)
}

variable "bastion_subnet_address_prefix" {
  description = "Specifies the address prefix of the bastion subnet"
  default = ["10.0.1.0/24"]
  type = list(string)
}

variable "aks_vnet" {
  description = "Specifies the name of the spoke virtual network where the aks is hosted"
  default = "aks_vnet"
  type = string
}

variable "aks_address_space" {
  description = "Specifies the address space for the aks virtual network"
  default = ["10.1.0.0/16"]
  type = list(string)
}

variable "aks_subnet_address_prefix" {
  description = "Specifies the address prefix of the firewall subnet"
  default = ["10.1.0.0/20"]
  type = list(string)
}

variable "vm_subnet_address_prefix" {
  description = "Specifies the address prefix of the bastion subnet"
  default = ["10.1.32.0/20"]
  type = list(string)
}

variable "public_ip_name" {
  description = "Specifies the name of the firewall's public IP"
  type = string
  default = "sca-fw-ip"
}

variable "fw_name" {
  description = "Specifies the name of the firewall"
  type = string
}

variable "fw_sku_name" {
  description = "Specifies the SKU name of the firewall"
  type = string
  default = "AZFW_VNet"
}

variable "fw_sku_tier" {
  description = "Specifies the SKU tier of the firewall"
  type = string
  default = "Standard"
}

variable "fw_threat_intel_mode" {
  description = "Specifies the operation mode for threat intelligence-based filtering"
  type = string
  default = "Alert"
}

variable "zones" {
  description = "Specifies the availability zones in the region"
  type = list(string)
  default = [ "1", "2", "3" ]
}