terraform {
  required_version = "~>1.9.1"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.88"
    }
  }
}

data "azurerm_client_config" "current" {
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
}