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

terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "scatfstatesa"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}