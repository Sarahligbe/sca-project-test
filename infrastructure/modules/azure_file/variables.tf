variable "resource_group_name" {
  description = "The name of the resource group to deploy the storage account"
  type = string
}

variable "location" {
  description = "The Azure region to deploy the storage account"
  type = string
}

variable "tags" {
  description = "Tags to label resources"
  type = map
  default = {}
}

variable "name" {
  description = "Specifies the name of the storage account"
  type = string
  default = "scapvcsa"
}

variable "vnet_id" {
  description = "The Aks virtual network id"
  type = string
}