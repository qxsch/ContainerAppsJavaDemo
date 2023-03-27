module "container_app" {
  source = "../../../modules/container_app"

  resource_group_name                 = "rg-dev-storage-account-app"
  location                            = "switzerlandnorth"
  log_analytics_workspace_name        = "la-dev-storage-account-app"
  log_analytics_workspace_sku         = "PerGB2018"
  log_analytics_workspace_retention_in_days = 30
  environment_name                    = "env-dev-storage-account-app"
  app_name                            = "app-dev-storage-account-app"
  revision_mode                       = "Single"
  container_name                      = "container-dev-storage-account-app"
  container_image                     = "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest"
  container_cpu                       = "0.25"
  container_memory                    = "0.5Gi"
}
