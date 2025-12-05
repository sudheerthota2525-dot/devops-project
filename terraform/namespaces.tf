resource "kubernetes_namespace" "microservices_ns" {
  metadata {
    name = var.namespace
  }
}
