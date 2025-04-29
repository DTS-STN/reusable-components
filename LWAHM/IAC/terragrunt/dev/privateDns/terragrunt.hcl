include {
  path = find_in_parent_folders("root.hcl")
}

dependency "resourceGroups" {
  config_path = "..//resourceGroups" #**NOTE: double slash // is intended **
}

dependency "network" {
  config_path = "..//network" #**NOTE: double slash // is intended **
}

locals {
  terraform_home = "../../../modules/"
}

terraform {
  source = "${local.terraform_home}/privateDns"
}

inputs = {
    private_dns_rg = dependency.resourceGroups.outputs.private_dns_rg
    platform_vnet_id = dependency.network.outputs.platform_vnet_id
    esdc_hub_peered_vnet_id = dependency.network.outputs.esdc_hub_peered_vnet_id
}