include {
  path = find_in_parent_folders("root.hcl")
}

locals {
  terraform_home = "../../../modules/"
}

dependency "resourceGroups" {
  config_path = "..//resourceGroups" #**NOTE: double slash // is intended **
}

dependency "privateDns" {
  config_path = "..//privateDns" #**NOTE: double slash // is intended **
}

dependency "network" {
  config_path = "..//network" #**NOTE: double slash // is intended **
}

dependency "logAnalytics" {
  config_path = "..//logAnalytics" #**NOTE: double slash // is intended **
}

terraform {
  source = "${local.terraform_home}/acr"
}

inputs = {
    acr_rg_name = dependency.resourceGroups.outputs.acr_rg_name
    privatelink_dns_id = dependency.privateDns.outputs.privatelink_dns_id
    snet_peps_id = dependency.network.outputs.snet_peps_id
    law_id = dependency.logAnalytics.outputs.law_id
}
