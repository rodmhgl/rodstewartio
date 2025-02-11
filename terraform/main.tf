resource "azurerm_resource_group" "this" {
  name     = "rg-${var.static_web_app_name}"
  location = var.location
}

module "static_web_app" {
  source = "./modules/static_web_app"

  resource_group_name          = azurerm_resource_group.this.name
  location                     = azurerm_resource_group.this.location
}

moved {
  from = data.azurerm_dns_zone.custom_domain
  to   = module.static_web_app.data.azurerm_dns_zone.custom_domain
}

# data "azurerm_dns_zone" "custom_domain" {
#   name                = var.dns_zone_name
#   resource_group_name = var.dns_zone_resource_group_name
# }

moved {
  from = azurerm_dns_cname_record.this
  to   = module.static_web_app.azurerm_dns_cname_record.this
}

# resource "azurerm_dns_cname_record" "this" {
#   name                = var.cname_record
#   zone_name           = data.azurerm_dns_zone.custom_domain.name
#   resource_group_name = data.azurerm_dns_zone.custom_domain.resource_group_name
#   ttl                 = 300
#   target_resource_id  = azurerm_static_web_app.this.id
# }

moved {
  from = azurerm_static_web_app_custom_domain.this
  to   = module.static_web_app.azurerm_static_web_app_custom_domain.this
}

# resource "azurerm_static_web_app_custom_domain" "this" {
#   static_web_app_id = azurerm_static_web_app.this.id
#   domain_name       = trimsuffix(azurerm_dns_cname_record.this.fqdn, ".")
#   validation_type   = "cname-delegation"
# }
#endregion