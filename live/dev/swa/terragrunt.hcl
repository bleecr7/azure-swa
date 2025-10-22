include "root" {
  path = find_in_parent_folders("root.hcl")
}

locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  env_name = local.env_vars.locals.env_name
  # app_branch = local.env_vars.locals.app_branch
  # app_url = local.env_vars.locals.app_url
  # app_token = local.env_vars.locals.app_token
}

terraform {
  source = "../../../catalog/modules//swa"
}

inputs = {
  rg_name      = "${local.env_name}-swa-rg"
  location     = "westeurope"
  swa_name     = "${local.env_name}-swa"
  swa_sku_tier = "Free"
  swa_sku_size = "Free"
  # repository_url = "${local.app_url}"
  # repository_branch = "${local.app_branch}"
  # repository_token = "${local.app_token}"
  tags = {
    Environment = "${local.env_name}"
    ManagedBy   = "Terragrunt"
  }
}