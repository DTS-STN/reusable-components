locals {
  varfile = "lwahm-dev.json"
  vardata = jsondecode(file(local.varfile))
}

inputs =  merge(jsondecode(
    file("${find_in_parent_folders("lwahm-dev.json", local.varfile)}"),
  ))

generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider "azurerm" {
    subscription_id = var.subscription_id
    tenant_id = var.tenant_id
    client_id = var.client_id
    client_secret = var.client_secret
    resource_provider_registrations = "none"
    features {
      resource_group {
        prevent_deletion_if_contains_resources = false
      }
    }
}
terraform {
  backend "azurerm" {}
}
EOF
}

# REMOTE STATE
remote_state {
    backend = "azurerm"
    config = {
        key = "${path_relative_to_include()}/terraform.tfstate"
        subscription_id = local.vardata.subscription_id
        resource_group_name = local.vardata.tf_resource_group_name
        storage_account_name = local.vardata.tf_storage_account_name
        container_name = local.vardata.remote_state_container_name
    }
}