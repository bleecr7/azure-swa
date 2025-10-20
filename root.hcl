locals {
  #   Load environment variables
  region                       = "${get_env("region", "uksouth")}"
  subscription_id              = "${get_env("subscription_id")}"
  client_id                    = "${get_env("client_id")}"
  client_secret                = "${get_env("client_secret")}"
  tenant_id                    = "${get_env("tenant_id")}"
  tfstate_rg_name              = "${get_env("tfstate_rg_name")}"
  tfstate_storage_account_name = "${get_env("tfstate_storage_account_name")}"
  tf_state_container_name      = "${get_env("tfstate_container_name")}"
}

# Generate Azure provider configuration
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<EOF
    terraform {
        required_providers {
            azurerm = {
            source  = "hashicorp/azurerm"
            version = "~> 4.0"
            }

            random = {
            source  = "hashicorp/random"
            version = "~> 3.0"
            }

            tfe = {
            source  = "hashicorp/tfe"
            version = "~> 0.30"
            }
        }
    }
    provider "azurerm" {
        features {}
    }
    EOF
}

# Configure the remote backend
remote_state {
  backend = "azurerm"
  config = {
    subscription_id      = "${local.subscription_id}"
    key                  = "${path_relative_to_include()}/terraform.tfstate"
    resource_group_name  = "${local.tfstate_rg_name}"
    storage_account_name = "${local.tfstate_storage_account_name}"
    container_name       = "${local.tf_state_container_name}"
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
}

#  Configure root level variables
inputs = {
    region = local.region
}
