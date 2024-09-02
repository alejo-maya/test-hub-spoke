
resource "azurerm_public_ip" "firewall_ip" {
  name                = "firewall-public-ip"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_subnet" "firewall_subnet" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = ["10.1.3.0/24"]
}

resource "azurerm_firewall" "main" {
  name                = "firewall"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"

  ip_configuration {
    name                 = "configuration"
    public_ip_address_id = azurerm_public_ip.firewall_ip.id
    subnet_id            = azurerm_subnet.firewall_subnet.id
  }
}


resource "azurerm_firewall_network_rule_collection" "example" {
  name                = "firewall-rule-collection"
  azure_firewall_name = azurerm_firewall.main.name
  resource_group_name = azurerm_resource_group.rg.name
  priority            = 100
  action              = "Allow"

  rule {
    name                  = "Allow-HTTP-HTTPS"
    protocols             = ["TCP"]
    source_addresses      = ["*"]
    destination_addresses = ["*"]
    destination_ports     = ["80", "443"]
  }
}
