# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  #resource_provider_registrations = "none" # This is only required when the User, Service Principal, or Identity running Terraform lacks the permissions to register Azure Resource Providers.
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "rg" {
  name     = "ContosoResourceGroup"
  location = "East US"
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "core_service_vnet" {
  name                = "CoreServicesVnet"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = ["10.20.0.0/16"]
}

# Subnet 1
resource "azurerm_subnet" "gateway_subnet" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.core_service_vnet.name
  address_prefixes     = ["10.20.0.0/27"]
}

# Subnet 2
resource "azurerm_subnet" "shared_services_subnet" {
  name                 = "SharedServicesSubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.core_service_vnet.name
  address_prefixes     = ["10.20.10.0/24"]
}

# Subnet 3
resource "azurerm_subnet" "database_subnet" {
  name                 = "DatabaseSubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.core_service_vnet.name
  address_prefixes     = ["10.20.20.0/24"]
}

# Subnet 4
resource "azurerm_subnet" "public_web_service_subnet" {
  name                 = "PublicWebServiceSubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.core_service_vnet.name
  address_prefixes     = ["10.20.30.0/24"]
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "manufaturing_vnet" {
  name                = "ManufacturingVnet"
  resource_group_name = azurerm_resource_group.rg.name
  location            = "West US"
  address_space       = ["10.30.0.0/16"]
}

# Subnet 1
resource "azurerm_subnet" "manufacturing_system_subnet" {
  name                 = "ManufacturingSystemSubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.manufaturing_vnet.name
  address_prefixes     = ["10.30.10.0/24"]
}

# Subnet 2
resource "azurerm_subnet" "sensor_subnet_1" {
  name                 = "SharedServicesSubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.manufaturing_vnet.name
  address_prefixes     = ["10.30.20.0/24"]
}

# Subnet 3
resource "azurerm_subnet" "sensor_subnet_2" {
  name                 = "SharedServicesSubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.manufaturing_vnet.name
  address_prefixes     = ["10.30.21.0/24"]
}

# Subnet 4
resource "azurerm_subnet" "sensor_subnet_3" {
  name                 = "SharedServicesSubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.manufaturing_vnet.name
  address_prefixes     = ["10.30.22.0/24"]
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "research_vnet" {
  name                = "ResearchVnet"
  resource_group_name = azurerm_resource_group.rg.name
  location            = "Central US"
  address_space       = ["10.40.0.0/16"]
}

# Subnet 1
resource "azurerm_subnet" "research_system_subnet" {
  name                 = "ResearchSystemSubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.research_vnet.name
  address_prefixes     = ["10.40.0.0/24"]
}