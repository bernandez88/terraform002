terraform {
    required_providers {
        azurerm = {
        source = "hashicorp/azurerm"
        version = "~> 2.65"
        }
    }
    backend "remote" {
        organization = "t001"
        workspaces {
            name = "terraform002"
        }
    }   
}

provider "azurerm" {
  features {}
}

resource "random_string" "suffix" {
  length      = 5
  lower       = true
  number      = true
  min_numeric = 1
  upper       = false
  special     = false
}

resource "azurerm_resource_group" "resource_group" {
  name      = local.resource_group_name
  location  = var.location
  tags      = var.tags
}

resource "azure_storage_share" "storage_share" {
  name                  = local.app_service_name
  storage_account_name  = data.azurerm_storage_account.storage_account.name
}

resource "azurerm_app_service_plan" "service_plan" {
  name                = "api-appserviceplan-pro"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "app_service" {
  name                = local.app_service_name
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  app_service_plan_id = azurerm_app_service_plan.service_plan.id

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }
}

# resource "azurerm_private_endpoint" "private_endpoint" {
#   name                = "${local.app_service_name}-endpoint"
#   location            = azurerm_resource_group.resource_group.location
#   resource_group_name = azurerm_resource_group.resource_group.name
#   tags                = azurerm_resource_group.resource_group.tags
#   subnet_id           = local.subnet_id

#   private_service_connection {
#     is_manual_connection            = false
#     name                            = "${local.app_service_name}-connection"
#     private_connection_resource_id  = azurerm_app_service_standard.app_service.id
#     subresource_names               = ["sites"]
#   }
# }

resource "azurerm_monitor_diagnostic_setting" "_diagnostic_settings" {
  name                = "${local.app_service_name}-diagnostic"
  target_resource_id  = azurerm_app_service.app_service.id
  storage_account_id  = data.azurerm_storage_account.diagnostics_storage_account.id

  log {
    category = "AppServiceAppLogs"
    enabled = true

    retention_policy {
      enabled = true
      days    = 60
    }
  }

  lifecycle {
    ignore_changes = [
      metric
    ]
  }
}

resource "azurerm_application_insights" "application_insights" {
  name                = "${local.app_service_name}-insights"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  application_type    = "web"
  tags                = azurerm_resource_group.resource_group.tags
}