variable "namespace" {
  description = "Kubernetes namespace for microservices"
  type        = string
  default     = "healthcare-app"
}

variable "docker_config_json" {
  description = "Base64 encoded docker config JSON for image pulls"
  type        = string
}
