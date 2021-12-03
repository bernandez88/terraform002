output "resource_group_name" {
    value = azurerm_resource_group.resource_group.name
}

output "app_service_name" {
    value = azurerm_app_service.app_service.name
}

output "app_service_id" {
    value = azurerm_app_service.app_service.id
}