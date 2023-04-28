module "acr" {
  source = "../../../modules/acr"

  resource_group_name = "rg-dev-aca-shared"
  acr_name            = "devacrshared1"
  location            = "switzerlandnorth"
  acr_admin_enabled   = true
}