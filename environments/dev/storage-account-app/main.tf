module "container_app" {
  source = "../../../modules/container_app"

  app_name                            = "storage-account-app"
  environment                         = "dev"
  container_cpu                       = "0.25"
  container_memory                    = "0.5Gi"

  container_ingress_external_enabled  = "true"
  container_registry_name             = "devacrshared1"
  container_registry_rg               = "rg-dev-aca-shared"

  storage_accounts = [
    {
      name                = "pocacademodevstorage1"
    }
  ]
}