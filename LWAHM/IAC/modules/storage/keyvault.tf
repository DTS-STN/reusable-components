data "azurerm_client_config" "client_config" {
}
resource "azurerm_key_vault" "environment_keyvault" {
  name                        = "kv-lwhp-depot-${var.environment}"
  location                    = var.location
  resource_group_name         = var.depot_rg_name
  enabled_for_disk_encryption = true
  tenant_id                   = var.tenant_id
  soft_delete_retention_days  = 90
  purge_protection_enabled    = false
  enable_rbac_authorization   = true
  sku_name = "standard"
}
resource "azurerm_role_assignment" "tf_read_environment_keyvault" {
  scope = azurerm_key_vault.environment_keyvault.id
  role_definition_name = "Key Vault Secrets User"
  principal_id = data.azurerm_client_config.client_config.client_id
  skip_service_principal_aad_check = true
}
resource "azurerm_key_vault_secret" "wildcard_certificate" {
  name         = "wildcard-ssl-certificate-${var.environment_domain_name}-${var.environment}"
  value        = var.wildcard_ssl_certificate
  key_vault_id = azurerm_key_vault.environment_keyvault.id
}
resource "azurerm_key_vault_secret" "wildcard_certificate_password" {
  name         = "wildcard-ssl-certificate-secret-${var.environment_domain_name}-${var.environment}"
  value        = var.wildcard_ssl_certificate_password
  key_vault_id = azurerm_key_vault.environment_keyvault.id
}
resource "azurerm_private_endpoint" "kv_pep" {
  name                = "pep-kv-lwhp-${var.environment}"
  location            = var.location
  resource_group_name = var.depot_rg_name
  subnet_id           = var.snet_restricted_pep_lwhp_id
  private_service_connection {
    name                           = "con-kv-lwhp-${var.environment}"
    private_connection_resource_id = azurerm_key_vault.environment_keyvault.id
    is_manual_connection           = false
    subresource_names              = ["vault"]
  }
  private_dns_zone_group {
    name                 = "privatelink.azurewebsites.net"
    private_dns_zone_ids = [var.privatelink_dns_id]
  }
}