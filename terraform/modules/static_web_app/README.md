<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |
| <a name="provider_github"></a> [github](#provider\_github) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_dns_cname_record.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_cname_record) | resource |
| [azurerm_static_web_app.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/static_web_app) | resource |
| [azurerm_static_web_app_custom_domain.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/static_web_app_custom_domain) | resource |
| [azurerm_user_assigned_identity.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |
| [github_actions_secret.api_key](https://registry.terraform.io/providers/hashicorp/github/latest/docs/resources/actions_secret) | resource |
| [azurerm_dns_zone.custom_domain](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/dns_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cname_record"></a> [cname\_record](#input\_cname\_record) | The CNAME record to create in the DNS zone. | `string` | `"lab"` | no |
| <a name="input_dns_zone_name"></a> [dns\_zone\_name](#input\_dns\_zone\_name) | The name of the DNS zone to use for the custom domain. | `string` | `"rodstewart.io"` | no |
| <a name="input_dns_zone_resource_group_name"></a> [dns\_zone\_resource\_group\_name](#input\_dns\_zone\_resource\_group\_name) | The name of the resource group where the DNS zone is located. | `string` | `"rg-azurelaboratory-external-dns"` | no |
| <a name="input_github_repository_name"></a> [github\_repository\_name](#input\_github\_repository\_name) | The GitHub repository name. | `string` | `"rodstewartio"` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure Region where the Static Web App should be created. Changing this forces a new Static Web App to be created. | `string` | `"eastus2"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which the Static Web App should be created. | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input\_sku) | Specifies the SKU size/tier of the Static Web App. Possible values are Free or Standard. Defaults to Free. | `string` | `"Free"` | no |
| <a name="input_static_web_app_name"></a> [static\_web\_app\_name](#input\_static\_web\_app\_name) | The name which should be used for this Static Web App. Changing this forces a new Static Web App to be created. | `string` | `"rodstewartio"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cname"></a> [cname](#output\_cname) | The cname of the Static Web App. |
| <a name="output_default_host_name"></a> [default\_host\_name](#output\_default\_host\_name) | The default hostname of the Static Web App. |
<!-- END_TF_DOCS -->