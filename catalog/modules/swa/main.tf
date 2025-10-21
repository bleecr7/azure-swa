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
#   repository_url = var.repository_url
#   repository_branch = var.repository_branch
#   repository_token = var.repository_token
  tags = var.tags
}