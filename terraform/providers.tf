terraform {
  required_version = "~> 1.10.0"
  required_providers {
    github = {
      source  = "integrations/github"
      version = "6.5.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.18.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "tfstatelab"
    container_name       = "tfstate"
    key                  = "prod/rodstewartio.tfstate"
  }
}

provider "github" {}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}
