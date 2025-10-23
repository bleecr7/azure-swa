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

dependency "tfe_data" {
  config_path = "../tfe_data"

  mock_outputs_allowed_terraform_commands = ["validate"]
  mock_outputs = {
    dns_info = {
      domain_name = "mock.domain.name"
      resource_group_name = "mock-dns-rg"
    }
    key_vault_info = {
      id  = "/mock/key/vault/id"
      key_vault_name = "mock-key-vault-name"
    }
  }
}

terraform {
  source = "../../../catalog/modules//swa"
}

inputs = {
  env_name    = local.env_name
  rg_name      = "${local.env_name}-swa-rg"
  location     = "westeurope"
  swa_name     = "${local.env_name}-swa"
  swa_sku_tier = "Free"
  swa_sku_size = "Free"
  key_vault_id = dependency.tfe_data.outputs.remote_state_data.key_vault_info.id
  dns_zone_name = dependency.tfe_data.outputs.remote_state_data.dns_info.domain_name
  dns_rg_name = dependency.tfe_data.outputs.remote_state_data.dns_info.rg_name
  tags = {
    Environment = "${local.env_name}"
    ManagedBy   = "Terragrunt"
  }
}