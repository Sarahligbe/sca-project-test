variable "vnet_1_resource_group_name" {
  description = "Specifies the resource group name of the virtual networks"
  type        = string
}

variable "vnet_2_resource_group_name" {
  description = "Specifies the resource group name of the virtual networks"
  type        = string
}


variable "vnet_1_name" {
  description = "Specifies the name of the hub virtual network"
  type        = string
}

variable "vnet_1_id" {
  description = "Specifies the vnet ID of the hub virtual network"
  type        = string
}

variable "vnet_2_name" {
  description = "Specifies the name of the second virtual network"
  type        = string
}

variable "vnet_2_id" {
  description = "Specifies the vnet ID of the aks virtual network"
  type        = string
}

variable "peering_name_1_to_2" {
  description = "(Optional) Specifies the name of the hub to spoke virtual network peering"
  type        = string
  default     = "hubtospoke"
}

variable "peering_name_2_to_1" {
  description = "(Optional) Specifies the name of the spoke to hub virtual network peering"
  type        = string
  default     = "spoketohub"
}
