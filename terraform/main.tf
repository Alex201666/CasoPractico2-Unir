// Con esta configuración inicial añado el proveedor Azure
provider "azurerm" {
  features {}
}

// Creo el grupo de recursos en Azure
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

// Con esto estoy ya creado el Container Registry que se indica en la práctica y como se puede ver en todo el código apunto a las variables donde son llamadas
resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Basic"
  admin_enabled       = true // Justo en esta linea habilitamos la autenticación
}

