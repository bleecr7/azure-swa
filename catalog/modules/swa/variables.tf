variable "env_name" {
  description = "The environment name (e.g., dev, prod)"
  type        = string
}

variable "rg_name" {
  description = "The name of the Resource Group"
  type        = string
}

variable "location" {
  description = "The Azure region where the Resource Group will be created"
  type        = string
  default = "uksouth"
}

variable "swa_name" {
  description = "The name of the Static Web App"
  type        = string
}

variable "swa_sku_tier" {
  description = "The SKU tier of the Static Web App"
  type        = string
  default     = "Free"
}

variable "swa_sku_size" {
  description = "The SKU size of the Static Web App"
  type        = string
  default     = "Free"
}

variable "key_vault_id" {
  description = "The ID of the Key Vault to store secrets"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the resource group"
  type        = map(string)
  default     = {}
}