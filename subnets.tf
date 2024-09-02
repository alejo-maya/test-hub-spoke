resource "azurerm_subnet" "hub_subnet" {
#   name                 = "${module.naming.generated_names.enterprise_infrastructure.subnet[1]}-hub"
  name                 = "subnet-hub"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = ["10.1.1.0/24"]
}

resource "azurerm_subnet" "spoke_subnet" {
#   name                 = "${module.naming.generated_names.enterprise_infrastructure.subnet[2]}-spoke"
  name                 = "subnet-spoke"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.spoke.name
  address_prefixes     = ["10.2.1.0/24"]
}

resource "azurerm_subnet" "public_subnet" {
#   name                 = "${module.naming.generated_names.enterprise_infrastructure.subnet[2]}-spoke"
  name                 = "subnet-public"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.public.name
  address_prefixes     = ["10.3.1.0/24"]
}