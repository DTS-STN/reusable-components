resource "azurerm_private_dns_zone" "privatelink_dns" {
  name                = "privatelink.azurewebsites.net"
  resource_group_name = var.private_dns_rg
}

resource "azurerm_private_dns_zone_virtual_network_link" "privatelink_dns_esdc_hub_peered_vnet_link" {
  name                  = "vnet-link-esdc-hub-${var.environment}"
  resource_group_name   = var.private_dns_rg
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_dns.name
  virtual_network_id    = var.esdc_hub_peered_vnet_id
}

resource "azurerm_private_dns_zone_virtual_network_link" "privatelink_dns_lwhp_vnet_link" {
  name                  = "vnet-link-lwhp-${var.environment}"
  resource_group_name   = var.private_dns_rg
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_dns.name
  virtual_network_id    = var.lwhp_vnet_id
}

