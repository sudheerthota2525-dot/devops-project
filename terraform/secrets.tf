resource "kubernetes_secret" "docker_registry_secret" {
  metadata {
    name      = "registry-secret"
    namespace = var.namespace
  }

  data = {
    ".dockerconfigjson" = var.docker_config_json
  }

  type = "kubernetes.io/dockerconfigjson"
}
