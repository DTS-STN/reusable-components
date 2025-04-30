include {
  path = find_in_parent_folders("root.hcl")
}

dependency "resourceGroups" {
  config_path = "../..//resourceGroups" #**NOTE: double slash // is intended **
}

dependency "acr" {
  config_path = "../..//acr"
}

dependency "network" {
  config_path = "../..//network"

}
dependency "privateDns" {
  config_path = "../..//privateDns"
}

dependency "logAnalytics" {
  config_path = "../..//logAnalytics"
}

locals {
  terraform_home = "../../../../modules/"
}

terraform {
  source = "${local.terraform_home}/appService"
}

inputs = {
    application_name = "nginx"
    app_service_sku = "S1"
    image_name = "nginx"
    image_tag = "latest"
    int_image_tag = "int"
    networking_rg_name = dependency.resourceGroups.outputs.networking_rg_name
    private_dns_rg = dependency.resourceGroups.outputs.private_dns_rg
    privatelink_dns_name = dependency.privateDns.outputs.privatelink_dns_name
    privatelink_dns_id = dependency.privateDns.outputs.privatelink_dns_id
    kv_id = dependency.storage.outputs.kv_id
    law_id = dependency.logAnalytics.outputs.law_id
    kv_uri = dependency.storage.outputs.kv_uri
    snet_peps_id = dependency.network.outputs.snet_peps_id
    snet_appservice_id = dependency.network.outputs.snet_appservice_id
    acr_id =  dependency.acr.outputs.acr_id
    email_receivers = [
      {
        name = "",
        email = ""
      },
    ]
}