output "remote_state_data" {
  value = {
    dns_zone = data.tfe_outputs.remote_state.values.dns_info
    key_vault_info  = data.tfe_outputs.remote_state.values.key_vault_info
    storage_account_info = data.tfe_outputs.remote_state.values.storage_account_info
    tfstate_storage_container_info = data.tfe_outputs.remote_state.values.tfstate_storage_container_info
  }
  sensitive = true
}