resource "azurerm_resource_group" "appservice_rg" {
  name     = "rg-${var.platform}-${var.application_name}-${var.environment}"
  location = var.location
}
resource "azurerm_service_plan" "appservice_plan" {
  name                = "asp-${var.platform}-${var.application_name}-${var.environment}"
  resource_group_name = azurerm_resource_group.appservice_rg.name
  location            = var.location
  os_type             = "Linux"
  sku_name            = var.app_service_sku
}
resource "azurerm_linux_web_app" "app_service" {
  name                            = "as-${var.platform}-${var.application_name}-${var.environment}"
  resource_group_name             = azurerm_resource_group.appservice_rg.name
  location                        = var.location
  service_plan_id                 = azurerm_service_plan.appservice_plan.id
  public_network_access_enabled   = false
  client_certificate_enabled      = false
  https_only                      = true
  virtual_network_subnet_id = var.snet_app_service_id
  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.user_managed_identity.id]
  }
  site_config {
    vnet_route_all_enabled = true
    container_registry_use_managed_identity       = true
    container_registry_managed_identity_client_id = azurerm_user_assigned_identity.user_managed_identity.client_id
    application_stack {
      docker_registry_url = "https://acr${var.platform}${var.environment}.azurecr.io"
      docker_image_name   = "${var.image_name}:${var.image_tag}"
    }
  }
}
resource "azurerm_linux_web_app_slot" "app_service_int_slot" {
  name                            = "int-slot"
  app_service_id                  = azurerm_linux_web_app.app_service.id
  public_network_access_enabled   = false
  client_certificate_enabled      = false
  https_only                      = true
  virtual_network_subnet_id = var.snet_app_service_id
  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.user_managed_identity.id]
  }
  site_config {
    vnet_route_all_enabled = true
    container_registry_use_managed_identity       = true
    container_registry_managed_identity_client_id = azurerm_user_assigned_identity.user_managed_identity.client_id
    application_stack {
      docker_registry_url = "https://acr${var.platform}${var.environment}.azurecr.io"
      docker_image_name   = "${var.image_name}:${var.int_image_tag}"
    }
  }
}

resource "azurerm_app_service_slot_virtual_network_swift_connection" "vnet_integration_int_slot" {
  slot_name      = azurerm_linux_web_app_slot.app_service_int_slot.name
  app_service_id = azurerm_linux_web_app.app_service.id
  subnet_id      = var.snet_app_service_id
}


resource "azurerm_monitor_diagnostic_setting" "appservice_diagnostic_settings" {
  name                       = "${var.application_name}-diag-${var.environment}"
  target_resource_id         = azurerm_linux_web_app.app_service.id
  log_analytics_workspace_id = var.law_id
  enabled_log {
    category_group = "AllLogs"
  }
  enabled_metric {
    category = "AllMetrics"
  }
}
