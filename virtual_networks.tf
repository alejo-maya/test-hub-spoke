resource "azurerm_virtual_network" "hub" {
#   name                = "${module.naming.generated_names.enterprise_infrastructure.virtual_network[1]}-hub"
  name                = "vnet-hub"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.1.0.0/16"]
}

resource "azurerm_virtual_network" "spoke" {
#   name                = "${module.naming.generated_names.enterprise_infrastructure.virtual_network[2]}-spoke"
  name                = "vnet-spoke"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.2.0.0/16"]
}

resource "azurerm_virtual_network" "public" {
#   name                = "${module.naming.generated_names.enterprise_infrastructure.virtual_network[2]}-spoke"
  name                = "vnet-public"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.3.0.0/16"]
}