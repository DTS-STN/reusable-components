include {
  path = find_in_parent_folders()
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

terraform {
  source = "${local.terraform_home}/storage"
}

inputs = {
    log_rg_name = dependency.resourceGroups.outputs.log_rg_name
    depot_rg_name = dependency.resourceGroups.outputs.depot_rg_name
    privatelink_dns_id = dependency.privateDns.outputs.privatelink_dns_id
    snet_restricted_pep_lwhp_id = dependency.network.outputs.snet_restricted_pep_lwhp_id
}
