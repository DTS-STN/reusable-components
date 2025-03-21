resource "azurerm_subnet" "pep_lwhp" {
  name                 = "snet-pep-lwhp-${var.environment}"
  resource_group_name  = var.networking_rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["11.0.0.0/25"]
}
resource "azurerm_subnet_network_security_group_association" "snet_pep_nsg_association" {
  network_security_group_id = azurerm_network_security_group.nsg.id
  subnet_id                 = azurerm_subnet.pep_lwhp.id
}

resource "azurerm_subnet" "app_service_lwhp" {
  name                 = "snet-app-service-lwhp-${var.environment}"
  resource_group_name  = var.networking_rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  delegation {
    name = "Microsoft.Web/serverFarms"
    service_delegation {
      name = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
  address_prefixes = ["11.0.1.0/24"]
}
resource "azurerm_subnet_network_security_group_association" "snet_app_service_nsg_association" {
  network_security_group_id = azurerm_network_security_group.nsg.id
  subnet_id                 = azurerm_subnet.app_service_lwhp.id
}

resource "azurerm_subnet" "restricted_pep_lwhp" {
  name                 = "snet-restricted-pep-lwhp-${var.environment}"
  resource_group_name  = var.networking_rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["11.0.0.128/26"]
}
resource "azurerm_subnet_network_security_group_association" "restricted_pep_nsg_association" {
  network_security_group_id = azurerm_network_security_group.nsg.id
  subnet_id                 = azurerm_subnet.restricted_pep_lwhp.id
}

resource "azurerm_subnet" "build_agents" {
  name                 = "snet-build-agents-lwhp-${var.environment}"
  resource_group_name  = var.networking_rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["11.0.0.192/26"]
}
resource "azurerm_subnet_network_security_group_association" "snet_build_agents_nsg_association" {
  network_security_group_id = azurerm_network_security_group.nsg.id
  subnet_id                 = azurerm_subnet.build_agents.id
}
