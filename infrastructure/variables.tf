variable "rg_name" {
  type = string
  description = "The name of the resource group to deploy resources"
}

variable "location" {
  type = string
  description = "The Azure region to provision resources in"
  default = "UK South"
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

variable "name" {
  description = "Name of the AKS cluster"
  type = string
  default = "scaProjectAKS"
}

variable "kubernetes_version" {
  description = "Specifies the version of Kubernetes to deploy"
  type = string
  default = "1.25.6"
}

variable "dns_prefix" {
  description = "Specifies the DNS prefix to be used when creating the managed cluster"
  type = string
  default = "private-sca-aks"
}

variable "private_cluster_enabled" {
  description = "Specifies whether or not to enable a private cluster"
  type = bool
  default = true
}

variable "automatic_channel_upgrade" {
  description = "Specifies the upgrade channel for the Kubernetes Cluster. Possible values are patch, rapid, and stable."
  default     = "stable"
  type        = string
}

variable "workload_identity_enabled" {
  description = "Specifies whether Azure AD Workload Identity should be enabled for the Cluster."
  type        = bool
  default     = true
}

variable "oidc_issuer_enabled" {
  description = "Enable or Disable the OIDC issuer URL."
  type        = bool
  default     = true
}

variable "open_service_mesh_enabled" {
  description = "Specifies whether Open Service Mesh be enabled"
  type        = bool
  default     = true
}

variable "image_cleaner_enabled" {
  description = "Specifies whether Image Cleaner is enabled."
  type        = bool
  default     = true
}

variable "azure_policy_enabled" {
  description = "Specifies whether the Azure Policy Add-On be enabled"
  type        = bool
  default     = true
}

variable "http_application_routing_enabled" {
  description = "Specifies whether or not HTTP Application Routing be enabled"
  type        = bool
  default     = false
}

variable "default_node_pool_name" {
  description = "Specifies the name of the default node pool"
  default     =  "scaNP"
  type        = string
}

variable "default_node_pool_vm_size" {
  description = "Specifies the vm size of the default node pool"
  default     = "Standard DC2s v2"
  type        = string
}

variable "default_node_pool_enable_auto_scaling" {
  description = "Specifies whether to enable cluster auto-scaler."
  type          = bool
  default       = true
}

variable "default_node_pool_max_pods" {
  description = "Specifies the maximum number of pods that can run on each node."
  type          = number
  default       = 50
}

variable "default_node_pool_max_count" {
  description = "Specifies the maximum number of nodes which should exist within this Node Pool. Valid values are between 0 and 1000 and must be greater than or equal to min_count."
  type          = number
  default       = 10
}

variable "default_node_pool_min_count" {
  description = "Specifies the minimum number of nodes which should exist within this Node Pool. Valid values are between 0 and 1000 and must be less than or equal to max_count."
  type          = number
  default       = 3
}

variable "default_node_pool_node_count" {
  description = "Specifies the initial number of nodes which should exist within this Node Pool. Valid values are between 0 and 1000 and must be a value in the range min_count - max_count."
  type          = number
  default       = 3
}

variable "default_node_pool_os_disk_type" {
  description = "Specifies the type of disk which should be used for the Operating System."
  type          = string
  default       = "Ephemeral"
}

variable "admin_username" {
  description = "Specifies the Admin Username for the AKS cluster worker nodes."
  type        = string
  default     = "scaadmin"
}

variable "ssh_public_key" {
  description = "Specifies the SSH public key used to access the cluster."
  type        = string
}

variable "network_dns_service_ip" {
  description = "Specifies the DNS service IP of the network plugin"
  default     = "10.2.0.10"
  type        = string
}

variable "network_service_cidr" {
  description = "Specifies the service CIDR of the network plugin"
  default     = "10.2.0.0/24"
  type        = string
}

variable "network_plugin" {
  description = "Specifies the network plugin of the AKS cluster"
  default     = "azure"
  type        = string
}

variable "outbound_type" {
  description = "Specifies the outbound (egress) routing method which should be used for this Kubernetes Cluster."
  type        = string
  default     = "userDefinedRouting"
}

variable "bastion_name" {
  description = "Specifies the name of the bastion host"
  type = string
  default = "scaBastion"
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
    offer     = "UbuntuServer"
    sku       = "20.04-LTS" 
    version   = "latest"
  }
}

variable "vm_name" {
  description = "Specifies the name of the virtual machine"
  type = string
  default = "scaVM"
}

