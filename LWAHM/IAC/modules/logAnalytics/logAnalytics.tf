resource "azurerm_log_analytics_workspace" "log_workspace" {
  name                = "log-workspace-lwhp-${var.environment}"
  location            = var.location
  resource_group_name = var.log_rg_name
  retention_in_days   = var.retention_days
}
resource "azurerm_application_insights" "insights" {
  name                = "appi-workspace-lwhp-${var.environment}"
  location            = var.location
  resource_group_name = var.log_rg_name
  workspace_id        = azurerm_log_analytics_workspace.log_workspace.id
  application_type    = "Node.JS"
}
moved {
  from = azurerm_log_analytics_workspace.appi_workspace
  to   = azurerm_log_analytics_workspace.log_workspace
}
