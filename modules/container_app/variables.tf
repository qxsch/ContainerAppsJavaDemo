variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure location of the resource group"
  type        = string
}

variable "log_analytics_workspace_name" {
  description = "Name of the log analytics workspace"
  type        = string
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
}

variable "app_name" {
  description = "Name of the container app"
  type        = string
}

variable "revision_mode" {
  description = "Revision mode for the container app"
  type        = string
  default     = "Single"
}

variable "container_name" {
  description = "Name of the container"
  type        = string
}

variable "container_image" {
  description = "Container image"
  type        = string
}

variable "container_cpu" {
  description = "Container CPU requirements"
  type        = string
}

variable "container_memory" {
  description = "Container memory requirements"
  type        = string
}