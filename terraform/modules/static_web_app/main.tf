#region Static Web App
resource "azurerm_user_assigned_identity" "this" {
  count = var.sku != "Free" ? 1 : 0 # Free tier doesn't support identities

  name                = "${var.static_web_app_name}-uai"
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_static_web_app" "this" {
  name                               = var.static_web_app_name
  location                           = var.location
  resource_group_name                = var.resource_group_name
  configuration_file_changes_enabled = true
  preview_environments_enabled       = true
  public_network_access_enabled      = true
  sku_tier                           = var.sku
  sku_size                           = var.sku

  dynamic "identity" {
    for_each = var.sku != "Free" ? [1] : [] # No identities on Free tier
    content {
      type         = "UserAssigned"
      identity_ids = [azurerm_user_assigned_identity.this[0].id]
    }
  }

  lifecycle {
    # GHA updates repository_branch/repository_url, but not repository_token.
    # We cannot update repository_branch/repository_url without 
    # updating repository_token due to provider restrictions,
    # so we will ignore them to avoid drift
    ignore_changes = [
      repository_branch,
      repository_url,
      repository_token
    ]
  }

}

resource "github_actions_secret" "api_key" {
  repository      = var.github_repository_name
  secret_name     = "AZURE_STATIC_WEB_APPS_API_TOKEN"
  plaintext_value = azurerm_static_web_app.this.api_key
}
#endregion

#region Custom Domain
data "azurerm_dns_zone" "custom_domain" {
  name                = var.dns_zone_name
  resource_group_name = var.dns_zone_resource_group_name
}

resource "azurerm_dns_cname_record" "this" {
  name                = var.cname_record
  zone_name           = data.azurerm_dns_zone.custom_domain.name
  resource_group_name = data.azurerm_dns_zone.custom_domain.resource_group_name
  ttl                 = 300
  target_resource_id  = azurerm_static_web_app.this.id
}

resource "azurerm_static_web_app_custom_domain" "this" {
  static_web_app_id = azurerm_static_web_app.this.id
  domain_name       = trimsuffix(azurerm_dns_cname_record.this.fqdn, ".")
  validation_type   = "cname-delegation"
}
#endregion
