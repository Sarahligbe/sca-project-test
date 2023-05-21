variable "resource_group_name" {
  description = "Specifies the resource group name"
  type = string
}

variable "location" {
  description = "Specifies the location of the log analytics workspace"
  type = string
}

variable "name" {
  description = "Specifies the name of the log analytics workspace"
  type = string
}

variable "sku" {
  description = "Specifies the sku of the log analytics workspace"
  type = string
  default = "PerGB2018"
}

variable "tags" {
  description = "Specifies the tags of the log analytics workspace"
  type        = map
  default     = {}
}

variable "solution_plan_map" {
  description = "Specifies the map structure containing the list of solutions to be enabled."
  type        = map(any)
  default     = {}
}