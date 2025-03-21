include {
  path = find_in_parent_folders()
}

dependency "resourceGroups" {
  config_path = "..//resourceGroups" #**NOTE: double slash // is intended **
}

locals {
  terraform_home = "../../../modules/"
}

terraform {
  source = "${local.terraform_home}/dns"
}

inputs = {
    dns_rg = dependency.resourceGroups.outputs.dns_rg
}