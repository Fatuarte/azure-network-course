resource azurerm_resource_group "rg-hub" {
  name     = "rg-hub"
  location = "westeurope"
}

resource "azurerm_virtual_network" "vnet-hub" {
  name                = "vnet-hub"
  resource_group_name = azurerm_resource_group.rg-hub.name
  location            = azurerm_resource_group.rg-hub.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet-nva" {
  name                                      = "subnet-nva"
  resource_group_name                       = azurerm_virtual_network.vnet-hub.resource_group_name
  virtual_network_name                      = azurerm_virtual_network.vnet-hub.name
  address_prefixes                          = ["10.0.0.0/24"]
  private_endpoint_network_policies_enabled = false
}

resource "azurerm_subnet" "subnet_bastion" {
  name                 = "AzureBastionSubnet"
  virtual_network_name = azurerm_virtual_network.vnet-hub.name
  resource_group_name  = azurerm_virtual_network.vnet-hub.resource_group_name
  address_prefixes     = ["10.0.1.0/27"]
}