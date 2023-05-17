terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.56.0"
    }
  }
}

provider "azurerm" {
  features {} 
}

resource "azurerm_resource_group" "tfstate" {
  name = "tfstate"
  location = var.location
}

resource "azurerm_storage_account" "tfstate" {
  name = "scatfstatesa"
  resource_group_name = azurerm_resource_group.tfstate.name
  location = azurerm_resource_group.tfstate.location
  account_tier = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "sca"
  }
}

resource "azurerm_storage_container" "tfstate" {
  name = "tfstate"
  storage_account_name = azurerm_storage_account.tfstate.name
  container_access_type = "private"
}
