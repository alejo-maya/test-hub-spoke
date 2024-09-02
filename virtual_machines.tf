resource "azurerm_public_ip" "public_ip" {
  name                = "public-ip"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "public_vm_nic" {
  name                = "nic-public-vm"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.public_subnet.id  # Puedes poner aquí la subred que prefieras
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }
}

resource "azurerm_network_security_group" "public_vm_nsg" {
  name                = "nsg-public-vm"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "allow_ssh"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = 22
    source_address_prefix      = "0.0.0.0/0"  # Puedes restringir esto a tu IP si prefieres
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface_security_group_association" "public_vm_nsg_assoc" {
  network_interface_id      = azurerm_network_interface.public_vm_nic.id
  network_security_group_id = azurerm_network_security_group.public_vm_nsg.id
}


resource "azurerm_network_interface" "hub_vm_nic" {
#   name                = "${module.naming.generated_names.enterprise_infrastructure.network_interface[0]}-hub-vm"
  name                = "nic-hub-vm"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.hub_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "spoke_vm_nic" {
#   name                = "${module.naming.generated_names.enterprise_infrastructure.network_interface[1]}-spoke-vm"
  name                = "nic-spoke-vm"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.spoke_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "public_vm" {
  name                  = "vmpublic"
  location              = var.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.public_vm_nic.id]
  vm_size               = "Standard_B1ms"

  storage_os_disk {
    name              = "osdiskpublicvm"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "publicvm"
    admin_username = "adminuser"
    admin_password = "Password1234!"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}


resource "azurerm_virtual_machine" "hub_vm" {
#   name                  = "${module.naming.generated_names.enterprise_infrastructure.virtual_machine[0]}hub"
  name                  = "vmhub"
  location              = var.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.hub_vm_nic.id]
  vm_size               = "Standard_B1ms"

  storage_os_disk {
    name              = "osdiskhub"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "hubvm"
    admin_username = "adminuser"
    admin_password = "Password1234!"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}

resource "azurerm_virtual_machine" "spoke_vm" {
#   name                  = "${module.naming.generated_names.enterprise_infrastructure.virtual_machine[1]}spoke"
  name                  = "vmspoke"
  location              = var.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.spoke_vm_nic.id]
  vm_size               = "Standard_B1ms"

  storage_os_disk {
    name              = "osdiskspoke"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "spokevm"
    admin_username = "adminuser"
    admin_password = "Password1234!"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}