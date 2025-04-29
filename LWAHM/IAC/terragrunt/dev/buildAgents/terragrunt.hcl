include {
  path = find_in_parent_folders("root.hcl")
}

dependency "resourceGroups" {
  config_path = "..//resourceGroups" #**NOTE: double slash // is intended **
}

dependency "network" {
  config_path = "..//network" #**NOTE: double slash // is intended **
}

dependency "privateDns" {
  config_path = "..//privateDns"
}
locals {
  terraform_home = "../../../modules/"
}

terraform {
  source = "${local.terraform_home}/buildAgents"
}

inputs  = {
  networking_rg_name = dependency.resourceGroups.outputs.networking_rg_name
  build_agents_rg_name = dependency.resourceGroups.outputs.build_agents_rg_name
  snet_build_agents_id = dependency.network.outputs.snet_build_agents_id
  privatelink_dns_id = dependency.privateDns.outputs.privatelink_dns_id
}