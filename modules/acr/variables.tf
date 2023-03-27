variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure location of the resource group"
  type        = string
}

variable "acr_name" {
  description = "Name of the Azure Container Registry"
  type        = string
}

variable "acr_sku" {
  description = "SKU of the Azure Container Registry"
  type        = string
  default     = "Premium"
}

variable "acr_admin_enabled" {
  description = "Whether the admin account is enabled for the Azure Container Registry"
  type        = bool
  default     = false
}

variable "acr_georeplications" {
  description = "A list of georeplication locations for the Azure Container Registry"
  type = list(object({
    location                = string
    zone_redundancy_enabled = bool
    tags                    = map(string)
  }))
  default = []
}
