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
    staging_image_tag = "staging"
    networking_rg_name = dependency.resourceGroups.outputs.networking_rg_name
    private_dns_rg = dependency.resourceGroups.outputs.private_dns_rg
    privatelink_dns_name = dependency.privateDns.outputs.privatelink_dns_name
    privatelink_dns_id = dependency.privateDns.outputs.privatelink_dns_id
    platform_vnet_name = dependency.network.outputs.platform_vnet_name
    law_id = dependency.logAnalytics.outputs.law_id
    snet_peps_id = dependency.network.outputs.snet_peps_id
    snet_app_service_id = dependency.network.outputs.snet_app_service_id
    acr_id =  dependency.acr.outputs.acr_id
    email_receivers = []
}