provider "azurerm" {
    features {}
    version                     = "~>2.84.0"
    tenant_id                   = local.tenant_id
    subscription_id             = local.subscription_id
    skip_provider_registration  = true
}