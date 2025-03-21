output "kv_id" {
value = azurerm_key_vault.environment_keyvault.id
}

output "kv_uri" {
    value = azurerm_key_vault.environment_keyvault.vault_uri
}

output "wildcard_certificate_id" {
  value = azurerm_key_vault_secret.wildcard_certificate.id
}