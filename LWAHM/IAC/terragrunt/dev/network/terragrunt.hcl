include {
  path = find_in_parent_folders("root.hcl")
}

locals {
  terraform_home = "../../../modules/"
}

dependency "resourceGroups" {
  config_path = "..//resourceGroups" #**NOTE: double slash // is intended **
}

terraform {
  source = "${local.terraform_home}/network"
}

inputs = {
    networking_rg_name = dependency.resourceGroups.outputs.networking_rg_name
    appgw_vnet_address_space = "10.0.0.0/16"
}
