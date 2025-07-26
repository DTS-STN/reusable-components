resource "azurerm_subnet" "peps" {
  name                 = "snet-peps-${var.platform}-${var.environment}"
  resource_group_name  = var.networking_rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.private_endpoints_subnet_cidr]
}
resource "azurerm_subnet_network_security_group_association" "peps_nsg_association" {
  network_security_group_id = azurerm_network_security_group.nsg.id
  subnet_id                 = azurerm_subnet.peps.id
}

resource "azurerm_subnet" "app_service" {
  name                 = "snet-app-service-${var.platform}-${var.environment}"
  resource_group_name  = var.networking_rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  delegation {
    name = "Microsoft.Web/serverFarms"
    service_delegation {
      name = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
  address_prefixes = [var.app_service_subnet_cidr]
}

resource "azurerm_subnet_network_security_group_association" "app_service_nsg_association" {
  network_security_group_id = azurerm_network_security_group.nsg.id
  subnet_id                 = azurerm_subnet.app_service.id
}

resource "azurerm_subnet" "build_agents" {
  name                 = "snet-build-agents-${var.platform}-${var.environment}"
  resource_group_name  = var.networking_rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.build_agents_subnet_cidr]
}
resource "azurerm_subnet_network_security_group_association" "build_agents_nsg_association" {
  network_security_group_id = azurerm_network_security_group.nsg.id
  subnet_id                 = azurerm_subnet.build_agents.id
}
