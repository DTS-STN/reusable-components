resource "azurerm_network_interface" "bastion-nic" {
  name                = "bastion-nic"
  location            = var.location
  resource_group_name = var.build_agents_rg_name
  
  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.snet_build_agents_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "bastion-vm" {
  name                = "vm-bastion-${var.platform}-${var.environment}"
  resource_group_name = var.build_agents_rg_name
  location            = var.location
  size                = "Standard_DS1_v2"
  admin_username      = "adminuser"
  admin_password      = var.build_agents_admin_pass
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.bastion-nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }
}