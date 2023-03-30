resource "azurerm_resource_group" "container_app_rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_log_analytics_workspace" "container_app_law" {
  name                = var.log_analytics_workspace_name
  location            = azurerm_resource_group.container_app_rg.location
  resource_group_name = azurerm_resource_group.container_app_rg.name
  sku                 = var.log_analytics_workspace_sku
  retention_in_days   = var.log_analytics_workspace_retention_in_days
}

resource "azurerm_container_app_environment" "container_app_env" {
  name                       = var.environment_name
  location                   = azurerm_resource_group.container_app_rg.location
  resource_group_name        = azurerm_resource_group.container_app_rg.name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.container_app_law.id
}

resource "azurerm_container_app" "container_app" {
  name                         = var.app_name
  container_app_environment_id = azurerm_container_app_environment.container_app_env.id
  resource_group_name          = azurerm_resource_group.container_app_rg.name
  revision_mode                = var.revision_mode


  template {
    container {
      name   = var.container_name
      image  = var.container_image
      cpu    = var.container_cpu
      memory = var.container_memory
    }
  }

  lifecycle {
    ignore_changes = [secret, identity, template[0].container[0].env]
  }
}

# There is a known limitation here that if multiple links are created, there might be an error during exeuction
# Potential fix can be found here: https://stackoverflow.com/questions/70049758/terraform-for-each-one-by-one
resource "azapi_resource" "storage_blob" {
  for_each = { for account in var.storage_accounts : account.name => account }

  type      = "Microsoft.ServiceLinker/linkers@2022-11-01-preview"
  name      = each.value.name 
  parent_id = azurerm_container_app.container_app.id

  body = jsonencode({
    properties = {
      clientType = "java"
      targetService = {
        type = "AzureResource"
        id = azurerm_storage_account.this[each.key].id
      }
      authInfo = {
        authType = "systemAssignedIdentity"
        roles = []
      }
      scope = "container-dev-storage-account-app"
      configurationInfo = {
        customizedKeys = {}
        daprProperties = {
          version = ""
          componentType = ""
          metadata = []
          scopes = []
        }
      }
    }
  })

  depends_on = [azurerm_container_app.container_app, azurerm_storage_account.this]
}

resource "azurerm_storage_account" "this" {
  for_each = { for account in var.storage_accounts : account.name => account }

  name                     = each.value.name
  resource_group_name      = azurerm_resource_group.container_app_rg.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "dev"
  }
}

output "storage_account_ids" {
  value = { for account in var.storage_accounts : account.name => azurerm_storage_account.this[account.name].id }
}