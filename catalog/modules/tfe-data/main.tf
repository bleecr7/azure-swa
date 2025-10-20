data "tfe_outputs" "remote_state" {
  organization = var.remote_state_org_name
  workspace    = var.remote_state_workspace_name
}