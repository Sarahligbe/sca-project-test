variable "resource_group_name" {
  description = "Specifies the resource group name of the virtual networks"
  type        = string
}

variable "hub_vnet_name" {
  description = "Specifies the name of the hub virtual network"
  type        = string
}

variable "hub_vnet_id" {
  description = "Specifies the vnet ID of the hub virtual network"
  type        = string
}

variable "aks_vnet_name" {
  description = "Specifies the name of the second virtual network"
  type        = string
}

variable "aks_vnet_id" {
  description = "Specifies the vnet ID of the aks virtual network"
  type        = string
}

variable "peering_name_hub" {
  description = "(Optional) Specifies the name of the hub to spoke virtual network peering"
  type        = string
  default     = "hubtospoke"
}

variable "peering_name_aks" {
  description = "(Optional) Specifies the name of the spoke to hub virtual network peering"
  type        = string
  default     = "spoketohub"
}