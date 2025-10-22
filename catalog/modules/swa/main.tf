resource "azurerm_resource_group" "swa_rg" {
  name     = var.rg_name
  location = var.location
  tags     = var.tags
}

resource "azurerm_static_web_app" "swa" {
  name                = var.swa_name
  resource_group_name = azurerm_resource_group.swa_rg.name
  location            = azurerm_resource_group.swa_rg.location
  sku_tier = var.swa_sku_tier
  sku_size = var.swa_sku_size
  tags = var.tags
}

resource "azurerm_key_vault_secret" "swa_api_key" {
  name         = "${var.env_name}-swa-api-key"
  value        = azurerm_static_web_app.swa.api_key
  key_vault_id = var.key_vault_id
}