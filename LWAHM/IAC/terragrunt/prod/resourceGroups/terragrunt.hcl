include {
  path = find_in_parent_folders()
}

locals {
  terraform_home = "../../../modules/"
}

terraform {
  source = "${local.terraform_home}/resourceGroups"
}
