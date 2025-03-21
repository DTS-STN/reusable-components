output gateway_ip_configuration {
    value = azurerm_application_gateway.application_gw.gateway_ip_configuration[0].id
}