resource "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku
  tags                = var.tags
  retention_in_days   = "30"

  lifecycle {
      ignore_changes = [
          tags
      ]
  }
}

resource "azurerm_log_analytics_solution" "la_solution" {
  solution_name         = "ContainerInsights"
  location              = var.location
  resource_group_name   = var.resource_group_name
  workspace_resource_id = azurerm_log_analytics_workspace.log_analytics_workspace.id
  workspace_name        = azurerm_log_analytics_workspace.log_analytics_workspace.name

  plan {
    product   = "OMSGallery/ContainerInsights"
    publisher = "Microsoft"
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}