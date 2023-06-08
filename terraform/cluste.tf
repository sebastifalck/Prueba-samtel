resource "azurerm_resource_group" "rg" {
  name     = "pdrgsebas"
  location = "East US"
}

resource "azurerm_kubernetes_cluster" "clus" {
  name                = "prodsebasaks"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
 

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
  value     = azurerm_kubernetes_cluster.clus.kube_config.0.client_certificate
  sensitive = true
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.clus.kube_config_raw

  sensitive = true
}