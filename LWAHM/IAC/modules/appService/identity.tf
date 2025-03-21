resource "azurerm_user_assigned_identity" "user_managed_identity" {
  location            = var.location
  name                = "id-${var.application_name}-${var.environment}"
  resource_group_name = azurerm_resource_group.appservice_rg.name
}
resource "azurerm_role_assignment" "acr-assignment" {
  scope              = var.acr_id
  role_definition_name = "AcrPush"
  principal_id       = azurerm_user_assigned_identity.user_managed_identity.principal_id
}