output "application_gateway_subnet_id" {
    value = azurerm_subnet.snet_esdc_hub_peered_gateway.id
}
output "platform_vnet_id" {
  value = azurerm_virtual_network.vnet.id
}
output "snet_peps_id" {
  value = azurerm_subnet.peps.id
}
output "snet_app_service_id" {
 value = azurerm_subnet.app_service.id 
}
output "snet_build_agents_id" {
  value = azurerm_subnet.build_agents.id
}
output "esdc_hub_peered_vnet_id" {
  value = azurerm_virtual_network.esdc_hub_peered_vnet.id
}
output "platform_vnet_name" {
  value = azurerm_virtual_network.vnet.name
}