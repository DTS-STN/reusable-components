include {
  path = find_in_parent_folders("root.hcl")
}

dependency "resourceGroups" {
  config_path = "..//resourceGroups" #**NOTE: double slash // is intended **
}

locals {
  terraform_home = "../../../modules/"
}

terraform {
  source = "${local.terraform_home}/logAnalytics"
}

inputs  = {
    logs_rg_name = dependency.resourceGroups.outputs.logs_rg_name
    retention_days = 30
}