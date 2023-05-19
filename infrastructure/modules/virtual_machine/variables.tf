variable "name" {
  description = "Specifies the name of the virtual machine"
  type = string
  default = "scaVM"
}

variable "resource_group_name" {
  description = "The name of the resource group to provision the VM"
  type = string
}

variable "dns_resource_group_name" {
  description = "The name of the resource group to connect the private link to"
  type = string
}

variable "location" {
  description = "The Azure region to provision the VM"
  type = string
}

variable "tags" {
  description = "Tags to label resources"
  type = map
  default = {}
}

variable "subnet_id" {
  description = "Specifies the VM subnet ID"
  type = string
}

variable "vm_user" {
  description = "Specifies the admin user of the VM"
  type = string
  default = "scaadmin"
}

variable "ssh_public_key" {
  description = "Specifies the SSH public key used to access the VM."
  type        = string
}

variable "os_disk_size" {
  description = "Specifies the size of the VM operating system"
  type = string
  default = "Standard_B2s"
}

variable "os_disk_image" {
  description = "Specifies the os disk image of the virtual machine"
  type        = map(string)
  default     = {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "20.04.202305150"

  }
}

variable vnet_id {
  description = "Specifies the ID of the VNET where jumpbox VM will be installed"
  type        = string
}

variable dns_zone_name {
  description = "Private DNS Zone name to link jumpbox's vnet to"
  type        = string
}