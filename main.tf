provider "azurerm" {
  version = "~>2.0"
  features {}
}

resource "azurerm_resource_group" "main" {
  name     = var.TFC_WORKSPACE_NAME
  location = var.location
}

resource "azurerm_kubernetes_cluster" "main" {
  name                = var.TFC_WORKSPACE_NAME
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  dns_prefix          = lower(var.TFC_WORKSPACE_NAME)

  default_node_pool {
    name       = "default"
    node_count = var.node_count
    vm_size    = var.vm_size
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    DND        = "DND"
    DND_REASON = "demo"
    RunStatus  = "NOSTOP"
  }

  timeouts {
    create = "30m"
    update = "40m"
  }
}

