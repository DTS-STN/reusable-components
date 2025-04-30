resource "azurerm_container_registry" "acr" {
  name = "acr${var.platform}${var.environment}"
  resource_group_name = var.acr_rg_name
  location = var.location
  sku = "Premium"
}

resource "azurerm_private_endpoint" "acr_pep" {
  name                = "pep-acr-${var.platform}-${var.environment}"
  location            = var.location
  resource_group_name = var.acr_rg_name
  subnet_id           = var.snet_peps_id
  private_service_connection {
    name                           = "con-acr-${var.platform}-${var.environment}"
    private_connection_resource_id = azurerm_container_registry.acr.id
    is_manual_connection           = false
    subresource_names              = ["registry"]
  }
  private_dns_zone_group {
    name                 = var.privatelink_dns_name
    private_dns_zone_ids = [var.privatelink_dns_id]
  }
}

resource "azurerm_monitor_diagnostic_setting" "agw_diagnostic_settings" {
  name                       = "agw-diagnostic-settings"
  target_resource_id         = azurerm_container_registry.acr.id
  log_analytics_workspace_id = var.law_id
  enabled_log {
    category_group = "AllLogs"
  }
  metric {
    category = "AllMetrics"
  }
}
