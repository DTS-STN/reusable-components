output "domain_verification_id" {
    value = azurerm_linux_web_app.app_service.custom_domain_verification_id
    sensitive = true
}
output "default_hostname" {
    value = azurerm_linux_web_app.app_service.default_hostname
}
output "int_slot_hostname" {
    value = azurerm_linux_web_app_slot.app_service_int_slot.default_hostname
}
output "app_service_id" {
    value = azurerm_linux_web_app.app_service.id
}
