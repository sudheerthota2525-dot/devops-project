                              ┌───────────────────────────────┐
                              │           Developers           │
                              │ (Write code for all services)  │
                              └───────────────┬───────────────┘
                                              │  Push code
                                              v
                              ┌────────────────────────────────┐
                              │           GitHub Repo           │
                              │  services/  k8s/  helm/  tf/   │
                              └───────────────┬────────────────┘
                                              │  CI Trigger
                                              v
                        ┌────────────────────────────────────────────┐
                        │             GitHub Actions (CI)             │
                        │----------------------------------------------│
                        │ 1. Checkout code                             │
                        │ 2. Install deps                              │
                        │ 3. Run tests (optional)                      │
                        │ 4. Build Docker images                       │
                        │ 5. Push to Container Registry                │
                        └───────────────┬──────────────────────────────┘
                                        │ Docker Images
                                        v
                      ┌────────────────────────────────────────┐
                      │         Container Registry              │
                      │ (GHCR / DockerHub / ECR / ACR)          │
                      └───────────────┬─────────────────────────┘
                                      │  CD Trigger
                                      v
                 ┌────────────────────────────────────────────────────────┐
                 │                   GitHub Actions (CD)                  │
                 │--------------------------------------------------------│
                 │ • Pull Helm chart values                               │
                 │ • helm upgrade --install                               │
                 │ • Apply Kubernetes manifests                           │
                 │ • Update Deployment image tags                         │
                 └───────────────┬────────────────────────────────────────┘
                                 │
                                 v
       ┌──────────────────────────────────────────────────────────────────────┐
       │                        Kubernetes Cluster (AKS/EKS/GKE)             │
       │──────────────────────────────────────────────────────────────────────│
       │ Namespace: healthcare                                               │
       │                                                                      │
       │  ┌──────────────────────┐   ┌─────────────────────────┐              │
       │  │ patient-api           │   │ appointment-service      │              │
       │  │ Deployment            │   │ Deployment               │              │
       │  │ ClusterIP Service     │   │ ClusterIP Service        │              │
       │  └───────────┬──────────┘   └──────────────┬───────────┘              │
       │              │                              │                         │
       │  ┌───────────v──────────┐   ┌───────────────v──────────┐              │
       │  │ billing-service       │   │ portal-ui                 │              │
       │  │ Deployment            │   │ Deployment                │              │
       │  │ ClusterIP Service     │   │ NodePort / Ingress        │              │
       │  └───────────────────────┘   └──────────────────────────┘              │
       │                                                                      │
       └──────────────────────────────────────────────────────────────────────┘
                                 │
                                 v
              ┌────────────────────────────────────────────────────┐
              │              Monitoring & Observability            │
              │────────────────────────────────────────────────────│
              │ Prometheus → Scrapes metrics from services         │
              │ Grafana    → Dashboards (CPU, memory, traffic)     │
              │ Alerts     → Email / Slack (optional)              │
              └────────────────────────────────────────────────────┘
