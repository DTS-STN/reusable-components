resource "azurerm_container_registry" "lwhp_acr" {
  name = "acrlwhp${var.environment}"
  resource_group_name = var.acr_rg_name
  location = var.location
  sku = "Premium"
}

resource "azurerm_private_endpoint" "acr_pep" {
  name                = "pep-acr-lwhp-${var.environment}"
  location            = var.location
  resource_group_name = var.acr_rg_name
  subnet_id           = var.snet_restricted_pep_lwhp_id
  private_service_connection {
    name                           = "con-acr-lwhp-${var.environment}"
    private_connection_resource_id = azurerm_container_registry.lwhp_acr.id
    is_manual_connection           = false
    subresource_names              = ["registry"]
  }
  private_dns_zone_group {
    name                 = "privatelink.azurewebsites.net"
    private_dns_zone_ids = [var.privatelink_dns_id]
  }
}

resource "azurerm_monitor_diagnostic_setting" "agw_diagnostic_settings" {
  name                       = "agw-diagnostic-settings"
  target_resource_id         = azurerm_container_registry.lwhp_acr.id
  log_analytics_workspace_id = var.log_workspace_id
  enabled_log {
    category_group = "AllLogs"
  }
  metric {
    category = "AllMetrics"
  }
}
