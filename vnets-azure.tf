# This will create a single vnet.  You can change the name by updating the variables in variables.tf


variable "vnetName" {
    type = string
    default = "ALZ-VNET"
  
}
# this is your vnet variables.  The default is 10.0.0.0, make sure to update subnets to match the vnets!!!
variable "vnetAddrspace" {
    type = tuple([ string ])
    default = ["10.0.0.0/16"]
}

variable "GatewaySnetAddrespace" {
    type = tuple(string)
    default = ["10.0.1.0/24"]
}

variable "mgmtSnetAddrspace" {
    type = tuple([ string ])
    default = ["10.0.2.0/16"]
}

variable "DEVAddrspace" {
    type = tuple([ string ])
    default = ["10.0.3.0/16"]
}

variable "UATAddrspace" {
    type = tuple([ string ])
    default = ["10.0.4.0/16"]
}

variable "PRODAddrspace" {
    type = tuple([ string ])
    default = ["10.0.5.0/16"]
}





#######################################
# Definition of your actual vnet
#######################################

resource "azurerm_virtual_network" "ALZ-VNET" {
  name                = var.vnetName
  address_space       = var.vnetAddrspace
  location            = azurerm_resource_group.ALZ-ResourceGroup.location
  resource_group_name = azurerm_resource_group.ALZ-ResourceGroup.name
}

resource "azurerm_subnet" "GatewaySubnet" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.ALZ-ResourceGroup.name
  virtual_network_name = azurerm_virtual_network.ALZ-VNET.name
  address_prefixes     = var.GatewaySnetAddrespace

}

resource "azurerm_subnet" "MGMT-Subnet" {
  name                 = "MGMT-Subnet"
  resource_group_name  = azurerm_resource_group.ALZ-ResourceGroup.name
  virtual_network_name = azurerm_virtual_network.ALZ-VNET.name
  address_prefixes     = var.mgmtSnetAddrspace

}
resource "azurerm_subnet" "PROD-Subnet" {
  name                 = "PROD-Subnet"
  resource_group_name  = azurerm_resource_group.ALZ-ResourceGroup.name
  virtual_network_name = azurerm_virtual_network.ALZ-VNET.name
  address_prefixes     = var.PRODAddrspace
}
resource "azurerm_subnet" "DEV-Subnet" {
  name                 = "DEV-Subnet"
  resource_group_name  = azurerm_resource_group.ALZ-ResourceGroup.name
  virtual_network_name = azurerm_virtual_network.ALZ-VNET.name
  address_prefixes     = var.DEVAddrspace

}
resource "azurerm_subnet" "UAT-Subnet" {
  name                 = "UAT-Subnet"
  resource_group_name  = azurerm_resource_group.ALZ-ResourceGroup.name
  virtual_network_name = azurerm_virtual_network.ALZ-VNET.name
  address_prefixes     = var.UATAddrspace

}
