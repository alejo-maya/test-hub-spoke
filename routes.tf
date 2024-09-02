
resource "azurerm_route_table" "route_table" {
  name                = "route-table"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_route" "route" {
  name                   = "route-to-firewall"
  resource_group_name    = azurerm_resource_group.rg.name
  route_table_name       = azurerm_route_table.route_table.name
  address_prefix         = "0.0.0.0/0"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = azurerm_firewall.main.ip_configuration.0.private_ip_address
}

resource "azurerm_subnet_route_table_association" "hub_association" {
  subnet_id      = azurerm_subnet.hub_subnet.id
  route_table_id = azurerm_route_table.route_table.id
}

resource "azurerm_subnet_route_table_association" "spoke_association" {
  subnet_id      = azurerm_subnet.spoke_subnet.id
  route_table_id = azurerm_route_table.route_table.id
}
