resource "azurerm_private_dns_zone" "vms_dns_zone" {
  name                = "techtitans.local"  # Nombre de tu dominio privado
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "hub_vnet_link" {
  name                  = "hub-vnet-link"
  resource_group_name   = azurerm_resource_group.rg.name
  private_dns_zone_name = azurerm_private_dns_zone.vms_dns_zone.name
  virtual_network_id    = azurerm_virtual_network.hub.id

  depends_on = [azurerm_virtual_network_peering.hub_to_spoke]
}

resource "azurerm_private_dns_zone_virtual_network_link" "spoke_vnet_link" {
  name                  = "spoke-vnet-link"
  resource_group_name   = azurerm_resource_group.rg.name
  private_dns_zone_name = azurerm_private_dns_zone.vms_dns_zone.name
  virtual_network_id    = azurerm_virtual_network.spoke.id

  depends_on = [azurerm_virtual_network_peering.spoke_to_hub]
}

resource "azurerm_private_dns_zone_virtual_network_link" "public_vnet_link" {
  name                  = "public-vnet-link"
  resource_group_name   = azurerm_resource_group.rg.name
  private_dns_zone_name = azurerm_private_dns_zone.vms_dns_zone.name
  virtual_network_id    = azurerm_virtual_network.public.id

  depends_on = [azurerm_virtual_network_peering.public_to_hub]
}

resource "azurerm_private_dns_a_record" "vm_hub_record" {
  name                = "hubvm"
  resource_group_name = azurerm_resource_group.rg.name
  zone_name           = azurerm_private_dns_zone.vms_dns_zone.name
  ttl                 = 300
  records             = [azurerm_network_interface.hub_vm_nic.private_ip_address]
}

resource "azurerm_private_dns_a_record" "vm_spoke_record" {
  name                = "spokevm"
  resource_group_name = azurerm_resource_group.rg.name
  zone_name           = azurerm_private_dns_zone.vms_dns_zone.name
  ttl                 = 300
  records             = [azurerm_network_interface.spoke_vm_nic.private_ip_address]
}
