// Para poder proseguir con la creación de las máquinas virtuales es imprescindible generar una red virtual en Azure para que puedan comunicarse la infraestructura y no se mezclen con otras redes virtuales
resource "azurerm_virtual_network" "vnet" {
  name                = "alexdevops-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

// Creo una subred dentro de la red virtual para que facilitemos así de manera más fácil el tráfico de red
resource "azurerm_subnet" "subnet" {
  name                 = "alexdevops-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

// Aquí ya definimos la IP Pública donde será accesible desde Internet
resource "azurerm_public_ip" "public_ip" {
  name                = "alexdevops-public-ip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
}

// Añadimos la interfaz de red para la máquina virtual sino es imposible que funcione, es imprescindible para conectar una máquina virtual a una red en Azure
resource "azurerm_network_interface" "nic" {
  name                = "alexdevops-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }
}

// Ahora si que pasamos con la creación de una de las máquinas virtuales, hemos elegido ubuntu 18.04 en esta parte
resource "azurerm_linux_virtual_machine" "vm" {
  name                = "alexdevops-vm"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_B1ms" // Tamaño de la VM, tiene 1 vcpu, 2 GiB RAM vale 17,52$/mes

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  computer_name  = "alexdevops-vm1"
  admin_username = "admincp2" // Usuario administrador

  admin_ssh_key {
    username   = "admincp2"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]
}

// Crear una subred para AKS
resource "azurerm_subnet" "aks_subnet" {
  name                 = "alexdevops-aks-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

// Crear un Azure Kubernetes Service (AKS)
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "alexdevops-aks"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "alexdevops-aks"

  default_node_pool {
    name       = "default"
    node_count = 2
    vm_size    = "Standard_DS2_v2"
    os_disk_size_gb = 30
    type       = "VirtualMachineScaleSets"
    max_pods    = 110
    vnet_subnet_id = azurerm_subnet.aks_subnet.id
  }

  network_profile {
    network_plugin = "azure"
    service_cidr   = "10.0.3.0/24"  // Rango de IPs para los servicios de Kubernetes, asegurándote de que no se solape con otras subredes
    dns_service_ip = "10.0.3.10"
  }

// Define el tipo de identidad asignada al cluster
  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Development"
  }

  depends_on = [
    azurerm_container_registry.acr,
    azurerm_subnet.aks_subnet
  ]
}
