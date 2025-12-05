output "namespace_name" {
  description = "The namespace created for the application"
  value       = kubernetes_namespace.microservices_ns.metadata[0].name
}
