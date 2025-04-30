locals {
  memory_threshold = 80
  cpu_threshold = 80
  response_time_threshold = 2
}

resource "azurerm_monitor_action_group" "ag_appservice" {
  name                = "ag-${var.application_name}-${var.environment}"
  resource_group_name = azurerm_resource_group.appservice_rg.name
  short_name          = "ag-${var.application_name}"

  dynamic "email_receiver" {
    for_each = var.email_receivers
    content {
      name          = "Send to ${email_receiver.value.name}"
      email_address = email_receiver.value.email
    }
  }
}
# LETS
resource "azurerm_monitor_metric_alert" "alert_rule_latency" {
  name                = "latency-alert"
  resource_group_name = azurerm_resource_group.appservice_rg.name
  scopes              = [azurerm_linux_web_app.app_service.id]
  description         = "AVG Response Time has reached or exceeeded ${local.response_time_threshold} seconds, investigate below."

  criteria {
    metric_namespace = "Microsoft.Web/sites"
    metric_name      = "HttpResponseTime"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = local.response_time_threshold
  }

  action {
    action_group_id = azurerm_monitor_action_group.ag_appservice.id
  }
}
resource "azurerm_monitor_metric_alert" "alert_rule_errors" {
  name                = "errors-alert"
  resource_group_name = azurerm_resource_group.appservice_rg.name
  scopes              = [azurerm_linux_web_app.app_service.id]
  description         = "Server Error(s) received, investigate below."

  criteria {
    metric_namespace = "Microsoft.Web/sites"
    metric_name      = "Http5xx"
    aggregation      = "Count"
    operator         = "GreaterThan"
    threshold        = 0
  }

  action {
    action_group_id = azurerm_monitor_action_group.ag_appservice.id
  }
}
resource "azurerm_monitor_metric_alert" "alert_rule_cpu_saturation" {
  name                = "cpu-saturation-alert"
  resource_group_name = azurerm_resource_group.appservice_rg.name
  scopes              = [azurerm_service_plan.appservice_plan.id]
  description         = "AVG CPU Saturation has reached or exceeeded ${local.cpu_threshold}%, investigate below."
  criteria {
    metric_namespace = "Microsoft.Web/serverfarms"
    metric_name      = "CpuPercentage"
    aggregation      = "Average"
    operator         = "GreaterThanOrEqual"
    threshold        = local.cpu_threshold
  }
  action {
    action_group_id = azurerm_monitor_action_group.ag_appservice.id
  }
}

resource "azurerm_monitor_metric_alert" "alert_rule_memory_saturation" {
  name                = "memory-saturation-alert"
  resource_group_name = azurerm_resource_group.appservice_rg.name
  scopes              = [azurerm_service_plan.appservice_plan.id]
  description         = "AVG Memory Saturation has reached or exceeeded ${local.memory_threshold}%, investigate below."
  criteria {
    metric_namespace = "Microsoft.Web/serverfarms"
    metric_name      = "MemoryPercentage"
    aggregation      = "Average"
    operator         = "GreaterThanOrEqual"
    threshold        = local.memory_threshold
  }

  action {
    action_group_id = azurerm_monitor_action_group.ag_appservice.id
  }
}

  
