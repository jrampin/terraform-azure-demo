resource "azurerm_linux_virtual_machine" "vm-1" {
  name                = "${var.project_name}-vm-1"
  location            = var.location
  resource_group_name = azurerm_resource_group.default.name
  admin_username      = "demo"
  size                = "Standard_A1_v2"
  network_interface_ids = [
    azurerm_network_interface.nic-1.id
  ]

  //  # this is a demo instance, so we can delete all data on termination
  //  delete_os_disk_on_termination    = true
  //  delete_data_disks_on_termination = true

  admin_ssh_key {
    username   = "demo"
    public_key = file("~/.ssh/azure_vm_key.pub")
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  os_disk {
    name                 = "${var.project_name}-disk1"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  tags = {
    name        = "${var.project_name}-vm-1"
    environment = var.environment
  }
}

resource "azurerm_network_interface" "nic-1" {
  name                = "${var.project_name}-nic-1"
  location            = var.location
  resource_group_name = azurerm_resource_group.default.name
  #network_security_group_id = azurerm_network_security_group.allow-ssh.id

  ip_configuration {
    name                          = "${var.project_name}-nic-1"
    subnet_id                     = azurerm_subnet.subnet-1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip-1.id
  }

  tags = {
    name        = "${var.project_name}-nic-1"
    environment = var.environment
  }
}

resource "azurerm_public_ip" "pip-1" {
  name                = "${var.project_name}-pip-1"
  location            = var.location
  resource_group_name = azurerm_resource_group.default.name
  allocation_method   = "Dynamic"

  tags = {
    name        = "${var.project_name}-pip-1"
    environment = var.environment
  }
}