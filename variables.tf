variable "subscription_name" {
    type        = string
    default     = "PortalSV"
    description = "Subscription Name for deployment"
}

variable "app_service_name" {
    type        = string
    default     = ""
    description = "(Optional) Resource group contents. Keep it blank for the naming logic to pick"
}

variable "location" {
  type      =  string
  default = "eastus"
  description = "INFO: This will be Azure Region where resources will be created. Type: string. Example: southcentralus, eastus, westus"
}

variable "enabled" {
  type = bool
  default = true
  description = "INFO: Is the App Service enabled?"
}

variable "always_on" {
    type = bool
    default = false
    description = "INFO: Should the App Service be loaded all times?"
}

variable "tags"{
    type        = map
    description = "A map of the tags to use on the resources that are deployed with this module."
    default     = {
        applicationname     = "AF-PaaS-Managed-App-Services",
        environment         = "nonprod",
        owner               = "Strati-AF-PaaS",
        apm                 = "43926262",
        notificationdistlist = "Strati-AF-PaaS-Dev@email.wal-mart.com",
        trproductid          = "2187"
    }
}