resource "azurerm_resource_group" "networking_rg" {
  name     = "rg-${var.platform}-networking-${var.environment}"
  location = var.location
}
resource "azurerm_resource_group" "agw_rg" {
  name = "rg-${var.platform}-agw-${var.environment}"
  location = var.location
}
resource "azurerm_resource_group" "private_dns_rg" {
  name = "rg-${var.platform}-private-dns-${var.environment}"
  location = var.location
}
resource "azurerm_resource_group" "acr_rg" {
  name = "rg-${var.platform}-acr-${var.environment}"
  location = var.location
}
resource "azurerm_resource_group" "build_agents_rg"{
  name = "rg-${var.platform}-build-agents-${var.environment}"
  location = var.location
}
resource "azurerm_resource_group" "log_rg" {
  name = "rg-${var.platform}-logs-${var.environment}"
  location = var.location
}