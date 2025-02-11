output "default_host_name" {
  description = "The default hostname of the Static Web App."
  value       = module.static_web_app.default_host_name
  # value       = "https://${azurerm_static_web_app.this.default_host_name}"
}

output "cname" {
  description = "The cname of the Static Web App."
  value       = module.static_web_app.cname
  # value       = "https://${azurerm_dns_cname_record.this.fqdn}"
}
