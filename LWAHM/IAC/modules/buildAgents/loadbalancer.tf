resource "azurerm_lb" "build_agents_lb" {
  name                = "lb-build-agents-${var.platform}-${var.environment}"
  location            = var.location
  resource_group_name = var.build_agents_rg_name

  frontend_ip_configuration {
    name                 = "feip-build-agents-${var.environment}"
    private_ip_address_allocation = "Dynamic"
    private_ip_address_version = "IPv4"
    subnet_id = var.snet_build_agents_id
  }
}

resource "azurerm_lb_backend_address_pool" "build_agents_backend_address_pool" {
    loadbalancer_id = azurerm_lb.build_agents_lb.id
    name = "beap-build-agents-${var.environment}"
    
}

resource "azurerm_lb_rule" "LB_rule" {
  name = "lb-rule-build-agents-${var.environment}"
  frontend_port = 80
  frontend_ip_configuration_name = "feip-build-agents-${var.environment}"
  protocol = "Tcp"
  loadbalancer_id = azurerm_lb.build_agents_lb.id
  backend_address_pool_ids = [azurerm_lb_backend_address_pool.build_agents_backend_address_pool.id]
  backend_port = 8080
}

resource "azurerm_lb_nat_pool" "build_agents_nat_pool" {
  resource_group_name            = var.build_agents_rg_name
  loadbalancer_id                = azurerm_lb.build_agents_lb.id
  name                           = "nat-pool-build-agents-${var.environment}"
  protocol                       = "Tcp"
  frontend_port_start            = 500
  frontend_port_end              = 503
  backend_port                   = 443
  frontend_ip_configuration_name = "feip-build-agents-${var.environment}"
}

resource "azurerm_lb_probe" "build_agents_health_probe" {
  loadbalancer_id = azurerm_lb.build_agents_lb.id
  name            = "probe-build-agents-${var.environment}"
  port            = 80
}