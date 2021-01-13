resource "azurerm_virtual_network" "vnet-1" {
  name                = "${var.project_name}-vnet-1"
  location            = var.location
  resource_group_name = azurerm_resource_group.default.name
  address_space       = ["10.0.0.0/16"]

  tags = {
    name        = "${var.project_name}-vnet-1"
    environment = var.environment
  }
}

resource "azurerm_subnet" "subnet-1" {
  name                 = "${var.project_name}-subnet-1"
  resource_group_name  = azurerm_resource_group.default.name
  virtual_network_name = azurerm_virtual_network.vnet-1.name
  address_prefixes     = ["10.0.0.0/24"]
}

resource "azurerm_network_security_group" "allow-ssh" {
  name                = "${var.project_name}-allow-ssh"
  location            = var.location
  resource_group_name = azurerm_resource_group.default.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.ssh-source-address
    destination_address_prefix = "*"
  }

  tags = {
    name        = "${var.project_name}-allow-ssh"
    environment = var.environment
  }
}