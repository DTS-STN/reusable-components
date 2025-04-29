variable "environment" {
  type    = string
  default = "dev"
}
variable "location" {
  type    = string
  default = "Canada Central"
}
variable "base_domain" {
  type    = string
  default = ""
}
variable "subscription_id" {
  type = string
}
variable "tenant_id" {
  type = string
}
variable "client_id" {
  type = string
}
variable "client_secret" {
  type = string
}
variable "networking_rg_name" {
  type    = string
  default = ""
}
variable "app_service_sku" {
  type    = string
  default = "I1"
}
variable "log_rg" {
  type    = string
  default = ""
}
variable "insights_id" {
  type    = string
  default = ""
}
variable "kv_id" {
  type = string
}
variable "appgw_log_retention_days" {
  type    = string
  default = 30
}
variable "agw_rg_name" {
  type    = string
  default = ""
}
variable "sku_name" {
  type    = string
  default = ""
}
variable "sku_tier" {
  type    = string
  default = ""
}
variable "application_gateway_subnet_id" {
  type = string
}
variable "appgw_private_ip" {
  type = string
}
variable "environment_domain_name" {
  type = string
}
variable "backend_address_pools" {
  type = list(object({
    name = string
    # ip_addresses = list(string)
    fqdns = list(string)
  }))
}
variable "backend_http_settings" {
  type = list(object({
    name                                = string
    has_cookie_based_affinity           = bool
    affinity_cookie_name                = string
    port                                = number
    is_https                            = bool
    request_timeout                     = number
    pick_host_name_from_backend_address = bool
    probe_name                          = string
  }))
}
variable "probes" {
  type = list(object({
    interval                                  = number
    name                                      = string
    path                                      = string
    pick_host_name_from_backend_http_settings = bool
    protocol                                  = string
    timeout                                   = number
    unhealthy_threshold                       = number
    status_code                               = list(string)
  }))
  default = []
}
variable "http_listeners" {
  type = list(object({
    name        = string
    host_name   = string
    require_sni = bool
    is_https    = bool
  }))
}
variable "request_routing_rules" {
  type = list(object({
    name                       = string
    is_path_based              = bool
    http_listener_name         = string
    backend_address_pool_name  = string
    backend_http_settings_name = string
    priority                   = number
  }))
}
variable "redirect_configurations" {
  type = list(object({
    name                 = string
    redirect_type        = string
    target_listener_name = string
    target_url           = string
    include_path         = bool
    include_query_string = bool
  }))
  default = []
}
variable "wildcard_ssl_certificate" {
  type = string
}
variable "wildcard_ssl_certificate_password" {
  type = string
}
variable "law_id" {
  type = string
}
variable "platform"{
  type = string
}