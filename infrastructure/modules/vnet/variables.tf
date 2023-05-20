variable "vnet_name" {
  description = "The name of the virtual network"
  type = string
}

variable "address_space" {
  description = "virtual network address space"
  type = list(string)
}

variable "location" {
  description = "The Azure region to provision the Vnet"
  type = string
}

variable "resource_group_name" {
  description = "The name of the resource group to provision the Vnet"
  type = string
}

variable "tags" {
  description = "Tags to label resources"
  type = map
  default = {}
}

variable subnets {
  description = "Subnets configuration"
  type = list(object({
    name             = string
    address_prefixes = list(string)
  }))
}

variable "log_analytics_workspace_id" {
  description = "Specifies the log analytics workspace id"
  type        = string
}

variable "log_analytics_retention_days" {
  description = "Specifies the number of days of the retention policy"
  type        = number
  default     = 7
}