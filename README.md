# azure-swa

Infrastructure as Code for deploying Azure Static Web App infrastructure using Terragrunt and Terraform. This is used to host my [personal website](https://brandonlee.cloud) written in React.

[![Terragrunt Dev Plan](https://github.com/bleecr7/azure-swa/actions/workflows/terragrunt-dev-plan.yml/badge.svg)](https://github.com/bleecr7/azure-swa/actions/workflows/terragrunt-dev-plan.yml)
[![Terragrunt Prod Plan](https://github.com/bleecr7/azure-swa/actions/workflows/terragrunt-prod-plan.yml/badge.svg)](https://github.com/bleecr7/azure-swa/actions/workflows/terragrunt-prod-plan.yml)
[![Terragrunt Build Workflow](https://github.com/bleecr7/azure-swa/actions/workflows/terragrunt-dev-build.yml/badge.svg)](https://github.com/bleecr7/azure-swa/actions/workflows/terragrunt-dev-build.yml)

## Architecture

### Directory Structure

- **`catalog/modules/`** - Reusable Terraform modules
  - `swa/` - Azure Static Web App module with custom domain and DNS integration
  - `tfe-data/` - Terraform Enterprise data module for retrieving remote state information
  
- **`live/`** - Environment-specific Terragrunt configurations
  - `dev/` - Development environment configuration
  - `prod/` - Production environment configuration

### Technology Stack

- **Terraform** (v1.13.4) - Infrastructure provisioning
- **Terragrunt** (v0.91.1) - Terraform wrapper for DRY configurations
- **Azure** - Cloud provider
  - Azure Static Web App (SWA)
  - Azure Resource Groups
  - Azure Key Vault (for secret storage)
- **Cloudflare** - DNS management and domain configuration

### Infrastructure Components

The SWA module provisions:

- **Azure Static Web App** with configurable SKU tier and size
- **Resource Group** for organizing Azure resources
- **Custom Domains** with DNS validation via Cloudflare
- **API Key Storage** in Azure Key Vault
- **DNS Records** (CNAME and TXT validation) through Cloudflare integration
- Support for both subdomain and apex domain routing

### Environment Configuration

Each environment (`dev`, `prod`) has:

- `env.hcl` - Environment-specific locals (environment name, domain settings)
- `terragrunt.hcl` - Module source and input variables for that environment
- Dependencies managed through Terragrunt's dependency blocks

### Prerequisites

- Azure CLI (v2.67.0)
- Terraform (v1.13.4)
- Terragrunt (v0.91.1)
- Cloudflare API token and account email
- Azure subscription with appropriate permissions
- Terraform Enterprise/Cloud workspace for remote state retrieval
