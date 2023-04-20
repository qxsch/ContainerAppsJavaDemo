module "container_app" {
  source = "../../../modules/container_app"

  app_name                            = "storage-account-app"
  environment                         = "dev"
  container_cpu                       = "1"
  container_memory                    = "2Gi"

  container_ingress_external_enabled  = "true"
  container_registry_name             = "devacrshared1"
  container_registry_rg               = "rg-dev-aca-shared"

  linked_storage_accounts = [
    {
      name                = "acstrgaccountlinked001"
    }
  ]

   dapr_storage_accounts = [
    {
      name                = "acastrgaccountdapr001"
    }
  ]

}
