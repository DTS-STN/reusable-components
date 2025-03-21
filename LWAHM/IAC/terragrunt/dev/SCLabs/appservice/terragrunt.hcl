include {
  path = find_in_parent_folders()
}

dependency "resourceGroups" {
  config_path = "../..//resourceGroups" #**NOTE: double slash // is intended **
}

dependency "storage" {
  config_path = "../..//storage" #**NOTE: double slash // is intended **
}

dependency "logAnalytics" {
  config_path = "../..//logAnalytics"
}

dependency "acr" {
  config_path = "../..//acr"
}

dependency "dns" {
  config_path = "../..//dns"
}

dependency "network" {
  config_path = "../..//network"

}

dependency "privateDns" {
  config_path = "../..//privateDns"
}

locals {
  terraform_home = "../../../../modules/"
}

terraform {
  source = "${local.terraform_home}/appService"
}

inputs = {
    application_name = "sclabs"
    app_service_sku = "S1"
    image_name = "servicecanadalabs"
    image_tag = "release-candidate"
    int_image_tag = "int"
    uat_image_tag = "uat"
    networking_rg_name = dependency.resourceGroups.outputs.networking_rg_name
    private_dns_rg = dependency.resourceGroups.outputs.private_dns_rg
    privatelink_dns_name = dependency.privateDns.outputs.privatelink_dns_name
    privatelink_dns_id = dependency.privateDns.outputs.privatelink_dns_id
    lwhp_vnet_name = dependency.network.outputs.lwhp_vnet_name
    kv_id = dependency.storage.outputs.kv_id
    log_workspace_id = dependency.logAnalytics.outputs.log_workspace_id
    kv_uri = dependency.storage.outputs.kv_uri
    dns_name = dependency.dns.outputs.dns_name
    dns_rg = dependency.resourceGroups.outputs.dns_rg
    dns_id = dependency.dns.outputs.dns_id
    snet_pep_lwhp_id = dependency.network.outputs.snet_pep_lwhp_id
    snet_app_service_id = dependency.network.outputs.snet_app_service_id
    acr_id =  dependency.acr.outputs.acr_id
    email_receiver = []
}