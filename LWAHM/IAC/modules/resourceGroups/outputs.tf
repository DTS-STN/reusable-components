output "networking_rg_name" {
  value       = azurerm_resource_group.networking_rg.name
}
output "agw_rg_name" {
  value       = azurerm_resource_group.agw_rg.name
}
output "log_rg_name" {
  value = azurerm_resource_group.log_rg.name
}
output "private_dns_rg" {
  value = azurerm_resource_group.private_dns_rg.name
}
output "acr_rg_name" {
  value = azurerm_resource_group.acr_rg.name
}
output "build_agents_rg_name" {
  value = azurerm_resource_group.build_agents_rg.name
}