# resource "azurerm_private_endpoint" "hub-vm-private-endpoint" {
#   name                = "hub-vm-private-endpoint"
#   location            = var.location
#   resource_group_name = azurerm_resource_group.rg.name
#   subnet_id           = azurerm_subnet.hub_subnet.id  

#   private_service_connection {
#     name                           = "hub-connection"
#     private_connection_resource_id = azurerm_network_interface.hub_vm_nic.id
#     # subresource_names              = ["blob"]  # Depende del recurso, por ejemplo "sqlServer", "blob", "file", etc.
#     is_manual_connection           = false
#   }

#   depends_on = [azurerm_private_dns_zone_virtual_network_link.hub_vnet_link]
# }

# resource "azurerm_private_endpoint" "spoke-vm-private-endpoint" {
#   name                = "spoke-vm-private-endpoint"
#   location            = var.location
#   resource_group_name = azurerm_resource_group.rg.name
#   subnet_id           = azurerm_subnet.spoke_subnet.id  

#   private_service_connection {
#     name                           = "spoke-connection"
#     private_connection_resource_id = azurerm_network_interface.spoke_vm_nic.id
#     # subresource_names              = ["blob"]  # Depende del recurso, por ejemplo "sqlServer", "blob", "file", etc.
#     is_manual_connection           = false
#   }

#   depends_on = [azurerm_private_dns_zone_virtual_network_link.spoke_vnet_link]
# }
