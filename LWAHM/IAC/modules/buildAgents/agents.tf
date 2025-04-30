resource "azurerm_linux_virtual_machine_scale_set" "build_agents_vmss" {
  name                = "build-agents-vmss-${var.platform}-${var.environment}"
  resource_group_name = var.build_agents_rg_name
  location            = var.location
  sku                 = "Standard_DS1_v2"
  instances           = 1
  admin_username      = "adminuser"
  single_placement_group = false
  overprovision = false
  upgrade_mode = "Manual"
  custom_data = base64encode(file("cloud-init.txt")
  )
  admin_password = var.build_agents_admin_pass
  disable_password_authentication = false
  identity {
    type = "SystemAssigned"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadOnly"
    diff_disk_settings {
    option = "Local"
  }

  }
  network_interface {
    name    = "nic-build-agents-${var.platform}-${var.environment}"
    primary = true

    ip_configuration {
      name      = "feip-build-agents-${var.environment}"
      primary   = true
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.build_agents_backend_address_pool.id]
      subnet_id = var.snet_build_agents_id
      load_balancer_inbound_nat_rules_ids = [azurerm_lb_nat_pool.build_agents_nat_pool.id]
      public_ip_address {
        name = "PIP-build-agents-${var.platform}-${var.environment}"
        domain_name_label = "${var.platform}-build-agent-${var.environment}"
      }
    }
  }
}
