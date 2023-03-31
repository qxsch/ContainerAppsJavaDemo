<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 2.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azapi"></a> [azapi](#provider\_azapi) | n/a |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 2.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azapi_resource.storage_blob](https://registry.terraform.io/providers/azure/azapi/latest/docs/resources/resource) | resource |
| [azurerm_container_app.container_app](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_app) | resource |
| [azurerm_container_app_environment.container_app_env](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_app_environment) | resource |
| [azurerm_container_app_environment_dapr_component.dapr_component](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_app_environment_dapr_component) | resource |
| [azurerm_log_analytics_workspace.container_app_law](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace) | resource |
| [azurerm_resource_group.container_app_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.acr_pull](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_storage_account.dapr](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_account.linked](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_container.default](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_user_assigned_identity.container_app_identity](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |
| [azurerm_container_registry.acr](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/container_registry) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | Name of the app | `string` | n/a | yes |
| <a name="input_container_app_name"></a> [container\_app\_name](#input\_container\_app\_name) | Name of the container app | `string` | `""` | no |
| <a name="input_container_cpu"></a> [container\_cpu](#input\_container\_cpu) | Container CPU requirements | `string` | n/a | yes |
| <a name="input_container_image"></a> [container\_image](#input\_container\_image) | Container image | `string` | `""` | no |
| <a name="input_container_ingress_external_enabled"></a> [container\_ingress\_external\_enabled](#input\_container\_ingress\_external\_enabled) | Enable external ingress for the container app | `bool` | `false` | no |
| <a name="input_container_memory"></a> [container\_memory](#input\_container\_memory) | Container memory requirements | `string` | n/a | yes |
| <a name="input_container_name"></a> [container\_name](#input\_container\_name) | Name of the container | `string` | `""` | no |
| <a name="input_container_port"></a> [container\_port](#input\_container\_port) | The port to expose on the container | `number` | `8080` | no |
| <a name="input_container_registry_name"></a> [container\_registry\_name](#input\_container\_registry\_name) | The name of the Azure Container Registry | `string` | n/a | yes |
| <a name="input_container_registry_rg"></a> [container\_registry\_rg](#input\_container\_registry\_rg) | The name of the Azure Container Registry | `string` | n/a | yes |
| <a name="input_container_tag"></a> [container\_tag](#input\_container\_tag) | The tag of the container image | `string` | `"latest"` | no |
| <a name="input_dapr_storage_accounts"></a> [dapr\_storage\_accounts](#input\_dapr\_storage\_accounts) | n/a | <pre>list(object({<br>    name                = string<br>  }))</pre> | `[]` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Type of environment (i.e. dev, test, prod) | `string` | `""` | no |
| <a name="input_environment_name"></a> [environment\_name](#input\_environment\_name) | Name of the container app environment | `string` | `""` | no |
| <a name="input_linked_storage_accounts"></a> [linked\_storage\_accounts](#input\_linked\_storage\_accounts) | n/a | <pre>list(object({<br>    name                = string<br>  }))</pre> | `[]` | no |
| <a name="input_location"></a> [location](#input\_location) | Azure location of the resource group | `string` | `"switzerlandnorth"` | no |
| <a name="input_log_analytics_workspace_name"></a> [log\_analytics\_workspace\_name](#input\_log\_analytics\_workspace\_name) | Name of the log analytics workspace | `string` | `""` | no |
| <a name="input_log_analytics_workspace_retention_in_days"></a> [log\_analytics\_workspace\_retention\_in\_days](#input\_log\_analytics\_workspace\_retention\_in\_days) | Retention in days for the log analytics workspace | `number` | `30` | no |
| <a name="input_log_analytics_workspace_sku"></a> [log\_analytics\_workspace\_sku](#input\_log\_analytics\_workspace\_sku) | SKU of the log analytics workspace | `string` | `"PerGB2018"` | no |
| <a name="input_max_replicas"></a> [max\_replicas](#input\_max\_replicas) | Maximum number of replicas | `number` | `1` | no |
| <a name="input_min_replicas"></a> [min\_replicas](#input\_min\_replicas) | Minimum number of replicas | `number` | `1` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the resource group | `string` | `""` | no |
| <a name="input_revision_mode"></a> [revision\_mode](#input\_revision\_mode) | Revision mode for the container app | `string` | `"Single"` | no |
| <a name="input_user_assigned_identity_name"></a> [user\_assigned\_identity\_name](#input\_user\_assigned\_identity\_name) | Name of the user assigned identity | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dapr_storage_account_ids"></a> [dapr\_storage\_account\_ids](#output\_dapr\_storage\_account\_ids) | n/a |
| <a name="output_linked_storage_account_ids"></a> [linked\_storage\_account\_ids](#output\_linked\_storage\_account\_ids) | n/a |
<!-- END_TF_DOCS -->