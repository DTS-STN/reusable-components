resource "azurerm_log_analytics_workspace" "law" {
  name                = "law-${var.platform}-${var.environment}"
  location            = var.location
  resource_group_name = var.log_rg_name
  retention_in_days   = var.retention_days
}
