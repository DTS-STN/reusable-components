resource "azurerm_log_analytics_workspace" "log_workspace" {
  name                = "log-workspace-lwhp-${var.environment}"
  location            = var.location
  resource_group_name = var.log_rg_name
  retention_in_days   = var.retention_days
}
