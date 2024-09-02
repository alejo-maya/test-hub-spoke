resource "azurerm_virtual_network_peering" "hub_to_spoke" {
  name                         = "peer_${azurerm_virtual_network.hub.name}_to_${azurerm_virtual_network.spoke.name}"
  resource_group_name          = azurerm_resource_group.rg.name
  virtual_network_name         = azurerm_virtual_network.hub.name
  remote_virtual_network_id    = azurerm_virtual_network.spoke.id
  allow_forwarded_traffic      = true
  allow_gateway_transit        = false
  allow_virtual_network_access = true
}

resource "azurerm_virtual_network_peering" "spoke_to_hub" {
  name                         = "peer_${azurerm_virtual_network.spoke.name}_to_${azurerm_virtual_network.hub.name}"
  resource_group_name          = azurerm_resource_group.rg.name
  virtual_network_name         = azurerm_virtual_network.spoke.name
  remote_virtual_network_id    = azurerm_virtual_network.hub.id
  allow_forwarded_traffic      = true
  allow_gateway_transit        = false
  allow_virtual_network_access = true
}

resource "azurerm_virtual_network_peering" "public_to_hub" {
  name                         = "peer_${azurerm_virtual_network.public.name}_to_${azurerm_virtual_network.hub.name}"
  resource_group_name          = azurerm_resource_group.rg.name
  virtual_network_name         = azurerm_virtual_network.public.name
  remote_virtual_network_id    = azurerm_virtual_network.hub.id
  allow_forwarded_traffic      = true
  allow_gateway_transit        = false
  allow_virtual_network_access = true
}

resource "azurerm_virtual_network_peering" "hub_to_public" {
  name                         = "peer_${azurerm_virtual_network.hub.name}_to_${azurerm_virtual_network.public.name}"
  resource_group_name          = azurerm_resource_group.rg.name
  virtual_network_name         = azurerm_virtual_network.hub.name
  remote_virtual_network_id    = azurerm_virtual_network.public.id
  allow_forwarded_traffic      = true
  allow_gateway_transit        = false
  allow_virtual_network_access = true
}