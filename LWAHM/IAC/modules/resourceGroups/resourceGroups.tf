resource "azurerm_resource_group" "networking_rg" {
  name     = "rg-lwhp-networking-${var.environment}"
  location = var.location
}
resource "azurerm_resource_group" "dns_rg" {
  name = "rg-lwhp-dns-${var.environment}"
  location = var.location
}
resource "azurerm_resource_group" "agw_shared_rg" {
  name = "rg-lwhp-agw-${var.environment}"
  location = var.location
}
resource "azurerm_resource_group" "private_dns_rg" {
  name = "rg-lwhp-private-dns-${var.environment}"
  location = var.location
}
resource "azurerm_resource_group" "depot_rg" {
  name = "rg-lwhp-depot-${var.environment}"
  location = var.location
}
resource "azurerm_resource_group" "acr_rg" {
  name = "rg-lwhp-acr-${var.environment}"
  location = var.location
}
resource "azurerm_resource_group" "build_agents_rg"{
  name = "rg-lwhp-build-agents-${var.environment}"
  location = var.location
}
resource "azurerm_resource_group" "dashbords_rg" {
  name = "rg-lwhp-dashboards-${var.environment}"
  location = var.location
}
resource "azurerm_resource_group" "log_rg" {
  name = "rg-lwhp-logs-${var.environment}"
  location = var.location
}