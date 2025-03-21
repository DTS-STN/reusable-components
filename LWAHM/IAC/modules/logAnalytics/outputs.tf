output "app_id" {
  value = azurerm_application_insights.insights.app_id
}

output "log_workspace_id" {
  value = azurerm_log_analytics_workspace.log_workspace.id
}
