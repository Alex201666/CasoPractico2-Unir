// Nombre del grupo de recursos
output "resource_group_name" {
  description = "Nombre del grupo de recursos"
  value       = azurerm_resource_group.rg.name
}

// Ubicación del grupo de recursos
output "resource_group_location" {
  description = "Ubicación del grupo de recursos"
  value       = azurerm_resource_group.rg.location
}

// Nombre del Azure Container Registry (ACR)
output "acr_name" {
  description = "Nombre del Azure Container Registry"
  value       = azurerm_container_registry.acr.name
}

// URL de inicio de sesión del ACR (usada para autenticarse)
output "acr_login_server" {
  description = "URL de inicio de sesión del Azure Container Registry"
  value       = azurerm_container_registry.acr.login_server
}

// Nombre de la máquina virtual
output "vm_name" {
  description = "Nombre de la máquina virtual"
  value       = azurerm_linux_virtual_machine.vm.name
}

// IP pública de la máquina virtual
output "vm_public_ip" {
  description = "IP pública de la máquina virtual"
  value       = azurerm_public_ip.public_ip.ip_address
}

// Nombre de la red virtual
output "vnet_name" {
  description = "Nombre de la red virtual"
  value       = azurerm_virtual_network.vnet.name
}

// Nombre de la subred
output "subnet_name" {
  description = "Nombre de la subred"
  value       = azurerm_subnet.subnet.name
}
