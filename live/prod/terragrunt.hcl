include "root" {
  path = find_in_parent_folders("root.hcl")
}

locals {
  env_vars = read_terragrunt_config("env.hcl")

  env_name = local.env_vars.locals.env_name
}

terraform {
  source = "../../catalog/modules//swa"
}

inputs = {
    rg_name  = "${local.env_name}-resource-group"
    location = "uksouth"
    tags = {
      Environment = "${local.env_name}"
      ManagedBy   = "Terragrunt"
    }
}