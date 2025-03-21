output "networking_rg_id" {
  value       = azurerm_resource_group.networking_rg.id
  description = "DTS Dev Networking RG ID "
}
output "networking_rg_name" {
  value       = azurerm_resource_group.networking_rg.name
  description = "DTS Dev Networking RG Name "
}
output "dns_rg" {
  value       = azurerm_resource_group.dns_rg.name
  description = "DTS DNS DEV RG NAME"
}
output "agw_shared_rg_id" {
  value       = azurerm_resource_group.agw_shared_rg.id
  description = "DTS APPGW DEV RG ID" 
}
output "agw_shared_rg_name" {
  value       = azurerm_resource_group.agw_shared_rg.name
  description = "DTS APPGW DEV RG NAME"
}
output "log_rg_name" {
  value = azurerm_resource_group.log_rg.name
}
output "log_rg_id" {
  value = azurerm_resource_group.log_rg.id
}
output "private_dns_rg" {
  value = azurerm_resource_group.private_dns_rg.name
}
output "depot_rg_name" {
  value = azurerm_resource_group.depot_rg.name
}
output "acr_rg_name" {
  value = azurerm_resource_group.acr_rg.name
}
output "build_agents_rg_name" {
  value = azurerm_resource_group.build_agents_rg.name
}
output "dashboards_rg_id" {
  value = azurerm_resource_group.dashbords_rg.id
}