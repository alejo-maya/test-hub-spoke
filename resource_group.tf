resource "azurerm_resource_group" "rg" {
  name     = "sw-tt-amaya-private-networking-test-001"
  location = var.location
}
