resource "azurerm_resource_group" "networking_rg" {
  name     = "rg-${var.hosting_model}-networking-${var.environment}"
  location = var.location
}
resource "azurerm_resource_group" "agw_shared_rg" {
  name = "rg-${var.hosting_model}-agw-${var.environment}"
  location = var.location
}
resource "azurerm_resource_group" "private_dns_rg" {
  name = "rg-${var.hosting_model}-private-dns-${var.environment}"
  location = var.location
}
resource "azurerm_resource_group" "depot_rg" {
  name = "rg-${var.hosting_model}-depot-${var.environment}"
  location = var.location
}
resource "azurerm_resource_group" "acr_rg" {
  name = "rg-${var.hosting_model}-acr-${var.environment}"
  location = var.location
}
resource "azurerm_resource_group" "build_agents_rg"{
  name = "rg-${var.hosting_model}-build-agents-${var.environment}"
  location = var.location
}
resource "azurerm_resource_group" "dashbords_rg" {
  name = "rg-${var.hosting_model}-dashboards-${var.environment}"
  location = var.location
}
resource "azurerm_resource_group" "log_rg" {
  name = "rg-${var.hosting_model}-logs-${var.environment}"
  location = var.location
}