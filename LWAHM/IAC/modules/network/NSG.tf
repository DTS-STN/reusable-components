resource "azurerm_network_security_group" "nsg" {
  name                = "nsg-${var.platform}-${var.environment}"
  location            = var.location
  resource_group_name = var.networking_rg_name
}

resource "azurerm_network_security_rule" "AllowDevOpsInbound" {
  name = "AllowDevOpsInbound"
  resource_group_name = var.networking_rg_name
  network_security_group_name = azurerm_network_security_group.nsg.name
  direction = "Inbound"
  priority = 100
  protocol = "*"
  access = "Allow"
  source_port_range = "*"
  destination_port_range = "*"
  source_address_prefix = "52.228.82.0/24"
  destination_address_prefix = "VirtualNetwork"
}

resource "azurerm_network_security_rule" "AllowIMDSOutbound" {
  name = "AllowIMDSOutbound"
  resource_group_name = var.networking_rg_name
  network_security_group_name = azurerm_network_security_group.nsg.name
  direction = "Outbound"
  priority = 102
  protocol = "*"
  access = "Allow"
  source_address_prefix = "VirtualNetwork"
  source_port_range = "*"
  destination_address_prefix = "169.254.169.254" 
  destination_port_range = 80 
}
