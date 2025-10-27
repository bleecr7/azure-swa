output "swa_id" {
  value       = azurerm_static_web_app.swa.id
  description = "The ID of the Static Web App."
}

output "swa_hostname" {
  value       = azurerm_static_web_app.swa.default_host_name
  description = "The default hostname of the Static Web App."
}

output "swa_api_key" {
  value       = azurerm_static_web_app.swa.api_key
  description = "The API key of the Static Web App."
  sensitive = true
}