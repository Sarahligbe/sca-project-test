variable "resource_group_name" {
  description = "The name of the resource group to provision the AKS cluster"
  type = string
}

variable "location" {
  description = "The Azure region to provision the AKS cluster"
  type = string
}

variable "tags" {
  description = "Tags to label resources"
  type = map
  default = {}
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

variable "default_node_pool_availability_zones" {
  description = "Specifies the availability zones of the default node pool"
  default     = ["1", "2", "3"]
  type        = list(string)
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
