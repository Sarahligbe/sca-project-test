variable "bastion_name" {
  description = "Specifies the name of the bastion host"
  type = string
  default = "scaBastion"
}

variable "resource_group_name" {
  description = "The name of the resource group to deploy the bastion host"
  type = string
}

variable "location" {
  description = "The Azure region to deploy the bastion host"
  type = string
}

variable "tags" {
  description = "Tags to label resources"
  type = map
  default = {}
}

variable "subnet_id" {
  description = "Specifies the bastion subnet ID"
  type = string
}