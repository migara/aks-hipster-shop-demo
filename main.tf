provider "azurerm" {
  version = "~>2.0"
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = var.TFC_WORKSPACE_NAME
  location = var.location
}

resource "azurerm_kubernetes_cluster" "example" {
  name                = var.TFC_WORKSPACE_NAME
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  dns_prefix          = lower(var.TFC_WORKSPACE_NAME)

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}

output "client_certificate" {
  value = azurerm_kubernetes_cluster.example.kube_config.0.client_certificate
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.example.kube_config_raw
}
