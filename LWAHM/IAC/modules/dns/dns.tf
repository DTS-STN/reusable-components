resource "azurerm_dns_zone" "dns" {
  name                = var.base_domain
  resource_group_name = var.dns_rg
}