variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = ""
}

variable "location" {
  description = "Azure location of the resource group"
  type        = string
  default     = "switzerlandnorth"
}

variable "log_analytics_workspace_name" {
  description = "Name of the log analytics workspace"
  type        = string
  default     = ""
}

variable "log_analytics_workspace_sku" {
  description = "SKU of the log analytics workspace"
  type        = string
  default     = "PerGB2018"
}

variable "log_analytics_workspace_retention_in_days" {
  description = "Retention in days for the log analytics workspace"
  type        = number
  default     = 30
}

variable "environment_name" {
  description = "Name of the container app environment"
  type        = string
  default     = ""
}

variable "environment" {
  description = "Type of environment (i.e. dev, test, prod)"
  type        = string
  default     = ""
}

variable "app_name" {
  description = "Name of the app"
  type        = string
}

variable "container_app_name" {
  description = "Name of the container app"
  type        = string
  default     = ""
}

variable "revision_mode" {
  description = "Revision mode for the container app"
  type        = string
  default     = "Single"
}

variable "container_name" {
  description = "Name of the container"
  type        = string
  default     = ""
}

variable "container_image" {
  description = "Container image"
  type        = string
  default     = ""
}

variable "container_cpu" {
  description = "Container CPU requirements"
  type        = string
}

variable "container_memory" {
  description = "Container memory requirements"
  type        = string
}

variable "linked_storage_accounts" {
  type = list(object({
    name                = string
  }))
  default = []
}

variable "dapr_storage_accounts" {
  type = list(object({
    name                = string
  }))
  default = []
}

variable "container_registry_name" {
  description = "The name of the Azure Container Registry"
  type        = string
}

variable "container_registry_rg" {
  description = "The name of the Azure Container Registry"
  type        = string
}

variable "container_port" {
  description = "The port to expose on the container"
  type        = number
  default     = 8080
}

variable "container_tag" {
  description = "The tag of the container image"
  type        = string
  default     = "latest"
}

variable "container_ingress_external_enabled" {
  description = "Enable external ingress for the container app"
  type        = bool
  default     = false
}

variable "user_assigned_identity_name" {
  description = "Name of the user assigned identity"
  type        = string
  default     = ""
}

variable "min_replicas" {
  description = "Minimum number of replicas"
  type        = number
  default     = 0
}

variable "max_replicas" {
  description = "Maximum number of replicas"
  type        = number
  default     = 1
}

variable "enable_http_autoscaling" {
  description = "Enable HTTP autoscaling"
  type        = bool
  default     = true
}