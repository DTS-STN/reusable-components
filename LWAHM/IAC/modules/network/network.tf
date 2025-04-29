resource "azurerm_virtual_network" "esdc_hub_peered_vnet" {
  name                = "vnet-${var.platform}-esdc-hub-link-${var.environment}"
  resource_group_name = var.networking_rg_name
  location            = var.location
  address_space       = [var.appgw_vnet_address_space]
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${var.platform}-${var.environment}"
  resource_group_name = var.networking_rg_name
  location            = var.location
  address_space       = ["11.0.0.0/24", "11.0.1.0/24"]
}

resource "azurerm_virtual_network_peering" "peer_hub_to_platform" {
  name                      = "peer-hub-to-${var.platform}"
  resource_group_name       = var.networking_rg_name
  virtual_network_name      = azurerm_virtual_network.esdc_hub_peered_vnet.name
  remote_virtual_network_id = azurerm_virtual_network.vnet.id
}
resource "azurerm_virtual_network_peering" "peer_platform_to_hub" {
  name                      = "peer-${var.platform}-to-hub"
  resource_group_name       = var.networking_rg_name
  virtual_network_name      = azurerm_virtual_network.vnet.name
  remote_virtual_network_id = azurerm_virtual_network.esdc_hub_peered_vnet.id
}

resource "azurerm_route_table" "route_table_perimeter_firewall" {
  name                = "rt-${var.platform}-${var.environment}"
  resource_group_name = var.networking_rg_name
  location            = var.location
  route = [{
    name                   = "RouteAllToCentral1FirewallEgressLbVip"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = var.next_hop_ip
  }]
}

resource "azurerm_subnet" "snet_esdc_hub_peered_gateway" {
  name                 = "snet-esdc-hub-peered-gateway"
  resource_group_name  = var.networking_rg_name
  virtual_network_name = azurerm_virtual_network.esdc_hub_peered_vnet.name
  address_prefixes     = [var.appgw_vnet_address_space]
}

resource "azurerm_subnet_route_table_association" "rt_association_esdc_hub" {
  subnet_id      = azurerm_subnet.snet_esdc_hub_peered_gateway.id
  route_table_id = azurerm_route_table.route_table_perimeter_firewall.id
}
