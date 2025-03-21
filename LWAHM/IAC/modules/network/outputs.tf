output "application_gateway_subnet_id" {
    value = azurerm_subnet.snet_esdc_hub_peered_gateway.id
}
output "lwhp_vnet_id" {
  value = azurerm_virtual_network.vnet.id
}
output "snet_pep_lwhp_id" {
  value = azurerm_subnet.pep_lwhp.id
}
output "snet_app_service_id" {
 value = azurerm_subnet.app_service_lwhp.id 
}
output "snet_restricted_pep_lwhp_id" {
  value = azurerm_subnet.restricted_pep_lwhp.id
}
output "snet_build_agents_id" {
  value = azurerm_subnet.build_agents.id
}
output "esdc_hub_peered_vnet_id" {
  value = azurerm_virtual_network.esdc_hub_peered_vnet.id
}
output "lwhp_vnet_name" {
  value = azurerm_virtual_network.vnet.name
}