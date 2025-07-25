resource "azurerm_private_endpoint" "appservice_pep" {
  name                = "pep-${var.platform}-${var.application_name}-${var.environment}"
  location            = var.location
  resource_group_name = azurerm_resource_group.appservice_rg.name
  subnet_id           = var.snet_peps_id
  private_service_connection {
    name                           = "con-${var.application_name}-${var.environment}"
    private_connection_resource_id = azurerm_linux_web_app.app_service.id
    is_manual_connection           = false
    subresource_names              = ["sites"]
  }
  private_dns_zone_group {
    name                 = var.privatelink_dns_name
    private_dns_zone_ids = [var.privatelink_dns_id]
  }
}