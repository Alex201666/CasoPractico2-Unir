// Declaro la variable del grupo de recursos
variable "resource_group_name" {
  description = "Nombre del grupo de recursos"
  default     = "alexdevops-resource-group"
}

// Declaro la variable para la ubicación de la zona de Azure
variable "location" {
  description = "Región de Azure"
  default     = "West Europe"
}

// Declaro la variable para el nombre del Container Registry que lo llamo alexitodevopsacrcp2 un poco largo pero me indicaba que ya estaba usandose un nombre más corto
variable "acr_name" {
  description = "Nombre del Azure Container Registry"
  default     = "alexitodevopsacrcp2"
}

