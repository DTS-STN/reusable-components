locals {
  frontend_private_ip_configuration_name = "frontend_private_ip_configuration"
  ssl_certificate_name                   = "cert-${var.platform}-${var.environment}"
}
resource "azurerm_user_assigned_identity" "appGatewayIdentity" {
  resource_group_name = var.agw_rg_name
  location            = var.location
  name                = "id-appgw-${var.platform}-${var.environment}"
}

resource "azurerm_application_gateway" "application_gw" {
  name                = "agw-${var.platform}-${var.environment}"
  resource_group_name = var.agw_rg_name
  location            = var.location
  zones = var.zones
  sku {
    name     = var.sku_name
    tier     = var.sku_tier
    capacity = 1
  }
  ssl_certificate {
    name     = local.ssl_certificate_name
    data     = var.wildcard_ssl_certificate
    password = var.wildcard_ssl_certificate_password
  }
  gateway_ip_configuration {
    name      = "gateway-ip-config"
    subnet_id = var.application_gateway_subnet_id
  }
  frontend_port {
    name = "Http"
    port = 80
  }  
  frontend_port {
    name = "Https"
    port = 443
  }
  frontend_ip_configuration {
    name                          = local.frontend_private_ip_configuration_name
    private_ip_address            =  var.appgw_private_ip
    private_ip_address_allocation = "Static"
    subnet_id                     = var.application_gateway_subnet_id
  }
  dynamic "backend_address_pool" {
    for_each = var.backend_address_pools
    content {
      name  = backend_address_pool.value.name
      fqdns = backend_address_pool.value.fqdns
    }
  }

  dynamic "backend_http_settings" {
    for_each = var.backend_http_settings
    content {
      name                                = backend_http_settings.value.name
      cookie_based_affinity               = backend_http_settings.value.has_cookie_based_affinity ? "Enabled" : "Disabled"
      affinity_cookie_name                = backend_http_settings.value.affinity_cookie_name
      port                                = backend_http_settings.value.port
      protocol                            = backend_http_settings.value.is_https ? "Https" : "Http"
      request_timeout                     = backend_http_settings.value.request_timeout
      pick_host_name_from_backend_address = backend_http_settings.value.pick_host_name_from_backend_address
      probe_name                          = backend_http_settings.value.probe_name
    }
  }
  dynamic "http_listener" {
    for_each = var.http_listeners
    content {
      name                           = http_listener.value.name
      frontend_ip_configuration_name = local.frontend_private_ip_configuration_name
      frontend_port_name             = http_listener.value.is_https ? "Https" : "Http"
      protocol                       = http_listener.value.is_https ? "Https" : "Http"
      ssl_certificate_name           = http_listener.value.is_https ? local.ssl_certificate_name : null
      host_name                      = http_listener.value.host_name
      require_sni                    = http_listener.value.require_sni
    }
  }

  dynamic "request_routing_rule" {
    for_each = var.request_routing_rules
    content {
      name                       = request_routing_rule.value.name
      rule_type                  = request_routing_rule.value.is_path_based ? "PathBasedRouting" : "Basic"
      http_listener_name         = request_routing_rule.value.http_listener_name
      backend_address_pool_name  = request_routing_rule.value.backend_address_pool_name
      backend_http_settings_name = request_routing_rule.value.backend_http_settings_name
      priority = request_routing_rule.value.priority
    }
  }
  dynamic "probe" {
    for_each = var.probes
    content {
      interval                                  = probe.value.interval
      name                                      = probe.value.name
      pick_host_name_from_backend_http_settings = probe.value.pick_host_name_from_backend_http_settings
      protocol                                  = probe.value.protocol
      path                                      = probe.value.path
      timeout                                   = probe.value.timeout
      unhealthy_threshold                       = probe.value.unhealthy_threshold
      match {
        status_code = probe.value.status_code
      }
    }
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.appGatewayIdentity.id]
  }
}

resource "azurerm_monitor_diagnostic_setting" "agw_diagnostic_settings" {
  name                       = "agw-diag-${var.platform}-${var.environment}"
  target_resource_id         = azurerm_application_gateway.application_gw.id
  log_analytics_workspace_id = var.law_id
  enabled_log {
    category_group = "AllLogs"
  }
  metric {
    category = "AllMetrics"
  }
}