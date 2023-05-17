variable "route_table_name" {
  description = "Specifies the name of the route table"
  type = string
}

variable "location" {
  description = "Specifies the Azure region in which the route table will be deployed"
  type = string
}

variable "resource_group_name" {
  description = "Specifies the name of the resource group"
  type = string
}

variable "tags" {
  description = "Specifies the tags to label the route table"
  type = map
}

variable "firewall_private_ip" {
  description = "Specifies the private IP of the firewall"
  type = string
}

variable "subnet_id" {
  description = "Specifies the AKS subnet ID"
  type = string
}