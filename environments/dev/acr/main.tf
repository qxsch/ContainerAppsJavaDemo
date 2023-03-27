module "acr" {
  source = "../../modules/acr"

  resource_group_name = "dev-aca-resources"
  location            = "switzerlandnorth"
  acr_name            = "devcontainerregistry1"
}