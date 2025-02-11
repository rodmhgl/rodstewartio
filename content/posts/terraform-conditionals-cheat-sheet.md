---
date: '2025-02-11T06:56:10Z'
draft: true
title: 'Terraform Conditionals Cheat Sheet'
tags:
  - cheat sheet
  - terraform
  - conditionals
---

## Conditionals in Terraform

Just a quick cheat sheet to use when writing conditionals in Terraform. In my role, I write a lot of Terraform but can go a few weeks in between. It's handy to have a quick reference to look back at. As AI coding companions improve, this will likely become less useful.

### Basic Conditions using Ternary Operator

Format is:

```text
condition ? true_result : false_result
```

### Basic Ternary Example

Prod key vaults should use the Premium SKU, all others should use Standard SKU.

```hcl
locals {
  key_vault_sku = var.environment == "prod" ? "premium" : "standard"
}
```

### Replace Invalid Values

In the example below, the user is given the option to supply a `diagnostic_setting_name`. If they elect not to, we will set the value to a dynamic expression `${var.app_name}-diag`. This is a useful workaround to not being able to use calculated values in your variable defaults. 

```hcl
variable "diagnostic_setting_name" {
  description = "Name of the diagnostic setting"
  type        = string
  default     = ""
}

locals {
  diag_setting_name = var.diagnostic_setting_name != "" ? var.diagnostic_setting_name : "${var.app_name}-diag"
}
```

### Nested Conditions

Nested conditionals are possible:

```text
condition ? true_result : second_condition ? second_true_result : second_false_result : false_result
```

#### Nested Conditionals Example

| Environment | High CPU Workload? | Instance Size |
|-------------|--------------------|---------------|
| prod        | true               | c5.xlarge     |
| prod        | false              | t3.large      |
| non-prod    | N/A                | t3.small      |

```hcl
locals {
  instance_type = (
    var.environment == "prod" ? (
      var.high_cpu_workload ? "c5.xlarge" : "t3.large"
    ) : "t3.small"
  )
}
```

## Conditional Creation

### Count

> Count resources use zero-based indexing.

Create a redis cache only for Prod environments. 

```hcl
resource "azurerm_redis_cache" "cache" {
  count = var.environment == "prod" ? 1 : 0
  
  name                = "cache-${var.environment}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku_name            = "Standard"
}
```

If `high_availability` is `true`, deploy 3 VMs, otherwise deploy a single instance.

```hcl
resource "azurerm_virtual_machine" "vm" {
  count = var.high_availability ? 3 : 1
  
  name                  = "vm-${count.index}"
  resource_group_name   = azurerm_resource_group.rg.name
  location              = azurerm_resource_group.rg.location
  vm_size               = "Standard_B1s"
}
```

### For_Each

Below, we configure environment settings in independent maps, `local.prod_settings` and `local.dev_settings`.

We then use a conditional to assign the appropriate settings to `active_settings`. 

Once in our Redis resource, we check for the presence of a cache key and create the cache with appropriate settings if found.

```hcl
locals {
  prod_settings = {
    cache   = { sku = "Premium", capacity = 2 }
    storage = { tier = "Premium_LRS", replication = true }
  }
  
  dev_settings = {
    storage = { tier = "Standard_LRS", replication = false }
  }
  
  active_settings = var.environment == "prod" ? local.prod_settings : local.dev_settings
}

resource "azurerm_redis_cache" "cache" {
  for_each = contains(keys(local.active_settings), "cache") ? toset(["enabled"]) : toset([])
  
  name                = "cache-${var.environment}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku_name            = local.active_settings.cache.sku
  capacity            = local.active_settings.cache.capacity
}
```

## Conditionals as Filters

### Filter Example

`admin_group_members` will be a map consisting only of Admin users from var.users

```hcl
locals {
  users = {
    rstewart = {
      user_type = "Admin"
    }
    jdoe = {
      user_type = "User"
    }
  }

  admin_group_members = { 
    for k, v in var.users :
      k => v if v.user_type == "Admin"
  }
}
```
