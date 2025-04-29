resource "azurerm_portal_dashboard" "apm_dash" {
    name = "dashboard-${var.application_name}--${var.platform}-${var.environment}"
    resource_group_name = azurerm_resource_group.appservice_rg.name
    location = var.location
    dashboard_properties = templatefile("dash.tpl",
    {
      subscription_id = var.subscription_id,
      resource_group_name = azurerm_resource_group.appservice_rg.name,
      resource_id = azurerm_linux_web_app.app_service.id
  })
}