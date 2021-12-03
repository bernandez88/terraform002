locals {
    tenant_id = "bfd0a800-51a2-461b-8bde-2a92f7e4e722"

    subscription_id = "cb53beb9-f0be-4eba-a431-394910fce01f"
    applicationname = lookup(var.tags, "applicationname", "appservice")

    resource_group_name_logic = format("rg_%s_%s_%s", substr(lower(replace(local.applicationname, " ", "")), 0, 15), var.location, random_string.suffix.result)
    resource_group_name   = var.resource_group_name != "" ? var.resource_group_name : local.resource_group_name_logic

    app_service_name_logic = substr(format("appservice$s%s", substr(lower(replace(local.applicationname, " ","")), 0, 15),random_string.suffix.result), 0, 24)
    app_service_name = var.app_service_name != "" ? var.app_service_name : local.app_service_name_logic

    storage_account_name = "shareda1b2c3d4sa"
    storage_account_resource_group_name = "shared_rg"
    
    diagnostics_storage_account_name = "diagnosticsa1b2c3d4sa"
    diagnostics_storage_account_resource_group_name ="shared_rg"    
}