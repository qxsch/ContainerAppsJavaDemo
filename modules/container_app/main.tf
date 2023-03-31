resource "azurerm_resource_group" "container_app_rg" {
  name     = coalesce(var.resource_group_name, local.default_resource_group_name)
  location = var.location
}

resource "azurerm_log_analytics_workspace" "container_app_law" {
  name                = coalesce(var.log_analytics_workspace_name, local.default_log_analytics_workspace_name)
  location            = azurerm_resource_group.container_app_rg.location
  resource_group_name = azurerm_resource_group.container_app_rg.name
  sku                 = var.log_analytics_workspace_sku
  retention_in_days   = var.log_analytics_workspace_retention_in_days
}

resource "azurerm_container_app_environment" "container_app_env" {
  name                       = coalesce(var.environment_name, local.default_environment_name)
  location                   = azurerm_resource_group.container_app_rg.location
  resource_group_name        = azurerm_resource_group.container_app_rg.name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.container_app_law.id
}

resource "azurerm_container_app" "container_app" {
  name                         = coalesce(var.container_app_name, local.default_container_app_name)
  container_app_environment_id = azurerm_container_app_environment.container_app_env.id
  resource_group_name          = azurerm_resource_group.container_app_rg.name
  revision_mode                = var.revision_mode

  dapr {
    app_id = coalesce(var.container_app_name, local.default_container_app_name)
    app_port = var.container_port
  }

  ingress { 
    external_enabled = var.container_ingress_external_enabled
    target_port = var.container_port
    traffic_weight {
      percentage = 100
    }
  }

  identity {
    type = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.container_app_identity.id]
  }
  
  registry {
    server   = data.azurerm_container_registry.acr.login_server
    identity = azurerm_user_assigned_identity.container_app_identity.id
  }

  template {
    container {
      name             = coalesce(var.container_name, local.default_container_name)
      image            = coalesce(var.container_image, local.default_container_image)
      cpu              = var.container_cpu
      memory           = var.container_memory
    }
      min_replicas     = var.min_replicas
      max_replicas     = var.max_replicas
  }

  lifecycle {
    ignore_changes = [secret, template[0].container[0].env, ingress[0].traffic_weight]
  }
}

# There is a known limitation here that if multiple links are created, there might be an error during exeuction
# Potential fix can be found here: https://stackoverflow.com/questions/70049758/terraform-for-each-one-by-one
resource "azapi_resource" "storage_blob" {
  for_each = { for account in var.linked_storage_accounts : account.name => account }

  type      = "Microsoft.ServiceLinker/linkers@2022-11-01-preview"
  name      = each.value.name 
  parent_id = azurerm_container_app.container_app.id

  body = jsonencode({
    properties = {
      clientType = "java"
      targetService = {
        type = "AzureResource"
        id = azurerm_storage_account.linked[each.key].id
      }
      authInfo = {
        authType = "userAssignedIdentity"
        clientId = azurerm_user_assigned_identity.container_app_identity.client_id
        subscriptionId = data.azurerm_subscription.current.subscription_id
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

  depends_on = [azurerm_container_app.container_app, azurerm_storage_account.linked, azurerm_storage_account.dapr, azurerm_role_assignment.acr_pull, azurerm_user_assigned_identity.container_app_identity]
}

resource "azurerm_storage_account" "linked" {
  for_each = { for account in var.linked_storage_accounts : account.name => account }

  name                     = each.value.name
  resource_group_name      = azurerm_resource_group.container_app_rg.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "dev"
  }
}

resource "azurerm_storage_account" "dapr" {
  for_each = { for account in var.dapr_storage_accounts : account.name => account }

  name                     = each.value.name
  resource_group_name      = azurerm_resource_group.container_app_rg.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "dev"
  }
}

resource "azurerm_storage_container" "default" {
  for_each              = azurerm_storage_account.dapr
  name                  = "default"
  storage_account_name  = each.value.name
  container_access_type = "private"

  depends_on = [azurerm_storage_account.dapr]
}

resource "azurerm_container_app_environment_dapr_component" "dapr_component" {
  for_each                     = {for component in var.dapr_storage_accounts: component.name => component}

  name                         = each.key
  container_app_environment_id = azurerm_container_app_environment.container_app_env.id
  component_type               = "state.azure.blobstorage"
  version                      = "v1"
  ignore_errors                = false
  init_timeout                 = "5s"
  scopes                       = [coalesce(var.container_app_name, local.default_container_app_name)]

  metadata {
      name                     = "accountName" 
      value                    = azurerm_storage_account.dapr[each.key].name
  }

  metadata {
      name                     = "containerName" 
      value                    = "default"
  }

  metadata {
      name                     = "accountKey"
      secret_name              = "storageaccountkey"  
  }

  secret {
      name                     = "storageaccountkey"
      value                    = azurerm_storage_account.dapr[each.key].primary_access_key
  }

  depends_on = [azurerm_container_app_environment.container_app_env, azurerm_storage_account.dapr, azurerm_storage_container.default]
}
                                     
# These are the resources that require "Owner" rights - We may need to refactor these in the future.
resource "azurerm_role_assignment" "acr_pull" {
  principal_id = azurerm_user_assigned_identity.container_app_identity.principal_id
  role_definition_name = "AcrPull"
  scope          = data.azurerm_container_registry.acr.id
}

resource "azurerm_user_assigned_identity" "container_app_identity" {
  name                = coalesce(var.user_assigned_identity_name, local.default_user_assigned_identity_name)
  resource_group_name = azurerm_resource_group.container_app_rg.name
  location            = azurerm_resource_group.container_app_rg.location
}