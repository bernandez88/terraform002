data "azurerm_storage_account" "storage_account" {
    name                = local.storage_account_name
    resource_group_name = local.storage_account_resource_group_name
}

data "azurerm_storage_account" "diagnostics_storage_account" {
    name                = local.diagnostics_storage_account_name
    resource_group_name = local.diagnostics_storage_account_resource_group_name
}
