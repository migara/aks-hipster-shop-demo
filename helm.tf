provider "helm" {
  kubernetes {
    load_config_file       = "false"
    host                   = "${azurerm_kubernetes_cluster.main.kube_config.0.host}"
    client_certificate     = "${base64decode(azurerm_kubernetes_cluster.main.kube_config.0.client_certificate)}"
    client_key             = "${base64decode(azurerm_kubernetes_cluster.main.kube_config.0.client_key)}"
    cluster_ca_certificate = "${base64decode(azurerm_kubernetes_cluster.main.kube_config.0.cluster_ca_certificate)}"
  }
}

resource "helm_release" "local" {
  name  = "hipster-shop"
  chart = "./hipster-shop"

  timeout = 1800
}
# output "client_certificate" {
#   value = azurerm_kubernetes_cluster.main.kube_config.0.client_certificate
# }

# output "kube_config" {
#   value = azurerm_kubernetes_cluster.main.kube_config_raw
# }
