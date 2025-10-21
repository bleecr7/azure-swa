variable "rg_name" {
  description = "The name of the Resource Group"
  type        = string
}

variable "location" {
  description = "The Azure region where the Resource Group will be created"
  type        = string
  default = "uksouth"
}

variable "tags" {
  description = "A map of tags to assign to the resource group"
  type        = map(string)
  default     = {}
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

# variable "repository_branch" {
#   description = "The branch of the repository to deploy"
#   type        = string
#   default     = "main"
# }

# variable "repository_url" {
#   description = "The URL of the repository containing the Static Web App source code"
#   type        = string
# }

# variable "repository_token" {
#   description = "The token used to access the repository if it's private"
#   type        = string
# }