resource "azurerm_resource_group" "swa_rg" {
  name     = var.rg_name
  location = var.location
  tags     = var.tags
}