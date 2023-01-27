provider "azurerm" {
  version = "=2.33.0"
  features {}
}

resource "azurerm_resource_group" "test" {
  name     = "test-rg"
  location = "East US"
}

resource "azurerm_resource_group" "prod" {
  name     = "prod-rg"
  location = "West US"
}

resource "azurerm_container_registry" "test" {
  name                = "testacr"
  resource_group_name = azurerm_resource_group.test.name
  location            = azurerm_resource_group.test.location
  sku                 = "Standard"
}

resource "azurerm_container_registry" "prod" {
  name                = "prodacr"
  resource_group_name = azurerm_resource_group.prod.name
  location            = azurerm_resource_group.prod.location
  sku                 = "Standard"
}

resource "azurerm_container_group" "test" {
  name                = "test-container-group"
  resource_group_name = azurerm_resource_group.test.name
  location            = azurerm_resource_group.test.location
  os_type             = "Linux"
  ip_address_type     = "Public"

  container {
    name   = "mycontainer"
    image  = "${azurerm_container_registry.test.login_server}/myimage:latest"
    ports {
      port = 8000
    }
  }
}

resource "azurerm_container_group" "prod" {
  name                = "prod-container-group"
  resource_group_name = azurerm_resource_group.prod.name
  location            = azurerm_resource_group.prod.location
  os_type             = "Linux"
  ip_address_type     = "Public"

  container {
    name   = "mycontainer"
    image  = "${azurerm_container_registry.prod.login_server}/myimage:latest"
    ports {
    port = 8000
        }
    }
}