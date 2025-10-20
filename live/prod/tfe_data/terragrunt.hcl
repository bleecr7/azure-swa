include "root" {
  path = find_in_parent_folders("root.hcl")
}

locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  env_name = local.env_vars.locals.env_name
}

terraform {
  source = "../../../catalog/modules//tfe-data"
}

inputs = {
  remote_state_org_name       = "brandon-lee-private-org"
  remote_state_workspace_name = "core-services"
}