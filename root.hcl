locals {
  #   Load environment variables
  region                       = "${get_env("region", "uksouth")}"
  subscription_id              = "${get_env("ARM_SUBSCRIPTION_ID")}"
  client_id                    = "${get_env("ARM_CLIENT_ID")}"
  tenant_id                    = "${get_env("ARM_TENANT_ID")}"
  tfstate_rg_name              = "${get_env("TF_VAR_TFSTATE_RG_NAME")}"
  tfstate_storage_account_name = "${get_env("TF_VAR_TFSTATE_STORAGE_ACCOUNT_NAME")}"
  tf_state_container_name      = "${get_env("TF_VAR_TFSTATE_CONTAINER_NAME")}"
  cloudflare_email              = "${get_env("CLOUDFLARE_EMAIL")}"
  cloudflare_api_token         = "${get_env("CLOUDFLARE_API_TOKEN")}"
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
            version = "~> 0.70"
            }

            cloudflare = {
            source  = "cloudflare/cloudflare"
            version = "~> 5.0"
            }
        }
    }
    provider "azurerm" {
        features {}
    }
    provider "cloudflare" {
      api_token = "${local.cloudflare_api_token}"
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
