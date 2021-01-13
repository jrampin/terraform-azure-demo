resource "azurerm_resource_group" "default" {
  location = var.location
  name     = "${var.project_name}-rg"
  tags = {
    name        = "${var.project_name}-rg"
    environment = var.environment
  }
}