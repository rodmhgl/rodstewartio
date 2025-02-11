<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.10.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 4.18.0 |
| <a name="requirement_github"></a> [github](#requirement\_github) | 6.5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 4.18.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_static_web_app"></a> [static\_web\_app](#module\_static\_web\_app) | ./modules/static_web_app | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/4.18.0/docs/resources/resource_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cname_record"></a> [cname\_record](#input\_cname\_record) | The CNAME record to create in the DNS zone. | `string` | `"lab"` | no |
| <a name="input_dns_zone_name"></a> [dns\_zone\_name](#input\_dns\_zone\_name) | The name of the DNS zone to use for the custom domain. | `string` | `"rodstewart.io"` | no |
| <a name="input_dns_zone_resource_group_name"></a> [dns\_zone\_resource\_group\_name](#input\_dns\_zone\_resource\_group\_name) | The name of the resource group where the DNS zone is located. | `string` | `"rg-azurelaboratory-external-dns"` | no |
| <a name="input_github_repository_name"></a> [github\_repository\_name](#input\_github\_repository\_name) | The github repository name. | `string` | `"rodstewartio"` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure Region where the Static Web App should exist. Changing this forces a new Static Web App to be created. | `string` | `"eastus2"` | no |
| <a name="input_sku"></a> [sku](#input\_sku) | Specifies the SKU size/tier of the Static Web App. Possible values are Free or Standard. Defaults to Free. | `string` | `"Free"` | no |
| <a name="input_static_web_app_name"></a> [static\_web\_app\_name](#input\_static\_web\_app\_name) | The name which should be used for this Static Web App. Changing this forces a new Static Web App to be created. | `string` | `"rodstewartio"` | no |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | The Azure Subscription ID to use for the Static Web App. | `string` | `"fac4f989-bd54-4dcd-91c1-c5da1f3ccf86"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cname"></a> [cname](#output\_cname) | The cname of the Static Web App. |
| <a name="output_default_host_name"></a> [default\_host\_name](#output\_default\_host\_name) | The default hostname of the Static Web App. |
<!-- END_TF_DOCS -->