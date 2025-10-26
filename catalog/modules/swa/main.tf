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

  lifecycle {
    ignore_changes = [
      repository_branch,
      repository_url,
      repository_token
    ]
  }
}

resource "azurerm_static_web_app_custom_domain" "swa_custom_domain" {
  static_web_app_id = azurerm_static_web_app.swa.id
  domain_name       = var.cloudflare_zone_name
  validation_type   = "dns-txt-token"
}

resource "azurerm_key_vault_secret" "swa_api_key" {
  name         = "${var.env_name}-swa-api-key"
  value        = azurerm_static_web_app.swa.api_key
  key_vault_id = var.key_vault_id
}

resource "cloudflare_dns_record" "cname_swa" {
  content = azurerm_static_web_app.swa.default_host_name
  name    = "dev"
  proxied = true
  tags    = []
  ttl     = 1
  type    = "CNAME"
  zone_id = var.cloudflare_zone_id
  settings = {
    flatten_cname = false
  }
}

resource "cloudflare_dns_record" "txt_validation_swa" {
  depends_on = [ azurerm_static_web_app_custom_domain.swa_custom_domain ]
  content = azurerm_static_web_app_custom_domain.swa_custom_domain.validation_token
  name    = "@"
  proxied = false
  tags    = []
  ttl     = 1
  type    = "TXT"
  zone_id = var.cloudflare_zone_id
  settings = {}

  lifecycle {
    ignore_changes = [ content ]
  }
}