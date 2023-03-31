locals {
  default_resource_group_name                 = "rg-${var.environment}-${var.app_name}"
  default_log_analytics_workspace_name        = "la-${var.environment}-${var.app_name}"
  default_environment_name                    = "env-${var.environment}-${var.app_name}"
  default_container_app_name                  = "app-${var.environment}-${var.app_name}"
  default_container_name                      = "container-${var.environment}-${var.app_name}"
  default_container_image                     = "${var.container_registry_name}.azurecr.io/${var.app_name}:${var.container_tag}"
  default_user_assigned_identity_name         = "app-${var.environment}-${var.app_name}"
}
