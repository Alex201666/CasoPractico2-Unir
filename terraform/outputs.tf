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

// Nombre de la subred para AKS
output "aks_subnet_name" {
  description = "Nombre de la subred para AKS"
  value       = azurerm_subnet.aks_subnet.name
}

// Nombre del AKS
output "aks_name" {
  description = "Nombre del Azure Kubernetes Service"
  value       = azurerm_kubernetes_cluster.aks.name
}

// URL de la API del AKS
output "aks_kube_config" {
  description = "URL de la API del Azure Kubernetes Service"
  value       = azurerm_kubernetes_cluster.aks.kube_config[0].host
  sensitive = true
}
