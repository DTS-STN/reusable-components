include {
  path = find_in_parent_folders("root.hcl")
}

dependency "resourceGroups" {
  config_path = "..//resourceGroups" #**NOTE: double slash // is intended **
}

dependency "logAnalytics" {
  config_path = "..//logAnalytics" #**NOTE: double slash // is intended **
}

dependency "network" {
  config_path = "..//network" #**NOTE: double slash // is intended **
}

dependency "nginx" {
  config_path = "../nginx/appservice" #**NOTE: double slash // is intended **
}

locals {
  terraform_home = "../../../modules/"
}

terraform {
  source = "${local.terraform_home}/appgw"
}

inputs  = {
    agw_rg_name = dependency.resourceGroups.outputs.agw_rg_name
    sku_name = "Standard_v2"
    sku_tier = "Standard_v2"
    application_gateway_subnet_id = dependency.network.outputs.application_gateway_subnet_id
    kv_id = dependency.storage.outputs.kv_id
    law_id = dependency.logAnalytics.outputs.law_id
    backend_address_pools = [
      {
        name = "pool-nginx",
        fqdns = [dependency.nginx.outputs.default_hostname]
      },
      ]
    backend_http_settings = [
      {
        name = "http-settings-nginx"
        has_cookie_based_affinity = false
        affinity_cookie_name = "ApplicationGatewayAffinity"
        port = 443
        is_https = true
        request_timeout = 30
        pick_host_name_from_backend_address = true
        probe_name = "nginx-probe"
      },
    ]
    http_listeners = [
      {
        name                           = "http-listener-nginx"
        host_name                      = "CHANGEME"
        require_sni                    = false
        is_https                       = false
      }
      {
        name                           = "https-listener-nginx"
        host_name                      = "CHANGEME"
        require_sni                    = false
        is_https                       = true
      },
    ]
    request_routing_rules = [{
      name                        = "public-https-to-nginx"
      is_path_based               = false
      http_listener_name          = "https-listener-nginx"
      backend_address_pool_name   = "pool-nginx"
      backend_http_settings_name  = "http-settings-nginx"
      priority                    = 100
      redirect_configuration_name = ""
      url_path_map_name = ""
    },
    ]
    probes = [{
      interval = 30
      name = "nginx-probe"
      protocol = "Https"
      pick_host_name_from_backend_http_settings = true
      path = "/"
      timeout = "30"
      unhealthy_threshold = "3"
      status_code = ["200-399"]
  },
  ]
}