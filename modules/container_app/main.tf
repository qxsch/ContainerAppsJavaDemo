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
}