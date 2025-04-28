include {
  path = find_in_parent_folders("root.hcl")
}

dependency "resourceGroups" {
  config_path = "../..//resourceGroups" #**NOTE: double slash // is intended **
}

dependency "storage" {
  config_path = "../..//storage" #**NOTE: double slash // is intended **
}

dependency "acr" {
  config_path = "../..//acr"
}

dependency "appInsights" {
  config_path = "../..//appInsights"
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
    networking_rg_name = dependency.resourceGroups.outputs.networking_rg_name
    private_dns_rg = dependency.resourceGroups.outputs.private_dns_rg
    privatelink_dns_name = dependency.privateDns.outputs.privatelink_dns_name
    privatelink_dns_id = dependency.privateDns.outputs.privatelink_dns_id
    lwhp_vnet_name = dependency.network.outputs.lwhp_vnet_name
    kv_id = dependency.storage.outputs.kv_id
    log_workspace_id = dependency.logAnalytics.outputs.log_workspace_id
    kv_uri = dependency.storage.outputs.kv_uri
    snet_pep_lwhp_id = dependency.network.outputs.snet_pep_lwhp_id
    acr_id =  dependency.acr.outputs.acr_id
    email_receiver = [
      {
        name = "Marcus Blais",
        email = "marcus.blais@hrsdc-rhdcc.gc.ca"
      },
      {
        name = "Adam Andrews",
        email = "adam.andrews@hrsdc-rhdcc.gc.ca"
      }
    ]
}