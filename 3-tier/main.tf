terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.30.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "my_rg" {
  name     = "my_app_rg"
  location = "West Europe"
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "my_vnet" {
  name                = "my_app_network"
  resource_group_name = azurerm_resource_group.my_rg.name
  location            = azurerm_resource_group.my_rg.location
  address_space       = ["10.0.0.0/16"]
}

module "tier1" {
  source = "./3-Tier-Application/Tier1"
  resource_group_name = azurerm_resource_group.my_rg.name
  location = azurerm_resource_group.my_rg.location
  
}
  
module "tier2" {
  source = "./3-Tier-Application/Tier2"
  resource_group_name = azurerm_resource_group.my_rg.name
  location = azurerm_resource_group.my_rg.location
  
}

module "tier3" {
  source = "./3-Tier-Application/Tier3"
  resource_group_name = azurerm_resource_group.my_rg.name
  location = azurerm_resource_group.my_rg.location
  
}
