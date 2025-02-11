variable "subscription_id" {
  type        = string
  description = "The Azure Subscription ID to use for the Static Web App."
  default     = "fac4f989-bd54-4dcd-91c1-c5da1f3ccf86"
}

variable "static_web_app_name" {
  type        = string
  description = "The name which should be used for this Static Web App. Changing this forces a new Static Web App to be created."
  default     = "rodstewartio"
}

variable "location" {
  type        = string
  description = "The Azure Region where the Static Web App should exist. Changing this forces a new Static Web App to be created."
  default     = "eastus2"
}

variable "sku" {
  type        = string
  description = "Specifies the SKU size/tier of the Static Web App. Possible values are Free or Standard. Defaults to Free."
  default     = "Free"
}

variable "github_repository_name" {
  type        = string
  description = "The github repository name."
  default     = "rodstewartio"
}

variable "dns_zone_resource_group_name" {
  type        = string
  description = "The name of the resource group where the DNS zone is located."
  default     = "rg-azurelaboratory-external-dns"
}

variable "dns_zone_name" {
  type        = string
  description = "The name of the DNS zone to use for the custom domain."
  default     = "rodstewart.io"
}

variable "cname_record" {
  type        = string
  description = "The CNAME record to create in the DNS zone."
  default     = "lab"
}
