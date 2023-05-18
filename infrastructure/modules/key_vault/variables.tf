variable "resource_group_name" {
  description = "The name of the resource group to deploy the key vault"
  type = string
}

variable "location" {
  description = "The Azure region to deploy the key vault"
  type = string
}

variable "tags" {
  description = "Tags to label resources"
  type = map
  default = {}
}

variable "name" {
  description = "Specifies the name of the key vault"
  type = string
  default = "scaKV"
}

variable "sku_name" {
  description = "Specifies the Name of the SKU used for this Key Vault"
  type        = string
  default     = "standard"
}

variable "tenant_id" {
  description = "Specifies the Azure Active Directory tenant ID that should be used for authenticating requests to the key vault."
  type        = string
}

variable "soft_delete_retention_days" {
  description = "Specifies the number of days that items should be retained for once soft-deleted. This value can be between 7 and 90 (the default) days."
  type        = number
  default     = 30
}

variable "bypass" { 
  description = "Specifies which traffic can bypass the network rules. Possible values are AzureServices and None."
  type        = string
  default     = "AzureServices" 
}

variable "default_action" { 
  description = "Specifies the Default Action to use when no rules match from ip_rules / virtual_network_subnet_ids. Possible values are Allow and Deny."
  type        = string
  default     = "Allow" 
}
