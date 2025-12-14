┌───────────────────────────────────────────┐
│               Developers                  │
│  (Write & update microservices code)      │
└──────────────────────┬────────────────────┘
                       │  git push
                       v
┌───────────────────────────────────────────┐
│                GitHub Repo                │
│-------------------------------------------│
│ services/                                 │
│ k8s-manifests/                            │
│ helm-charts/                              │
│ terraform/                                │
│ dev.sh                                   │
│ .github/workflows/build.yaml              │
└──────────────────────┬────────────────────┘
                       │  CI Trigger
                       v
┌───────────────────────────────────────────┐
│          GitHub Actions (CI ONLY)          │
│-------------------------------------------│
│ 1. Checkout code                          │
│ 2. Login to Docker Hub (Secrets)          │
│ 3. Build Docker images                    │
│ 4. Push images to Docker Hub              │
│                                           │
│❌ No Kubernetes access                   │
│❌ No kubectl / helm here                 │
│                                           │              
└──────────────────────┬────────────────────┘
                       │ Docker Images
                       v
┌───────────────────────────────────────────┐
│             Docker Hub Registry            │
│-------------------------------------------│
│ sudheerthota25/patient-api                │
│ sudheerthota25/appointment-service        │
│ sudheerthota25/billing-service            │
│ sudheerthota25/portal-ui                  │
└──────────────────────┬────────────────────┘
                       │ Image Pull
                       v
┌───────────────────────────────────────────┐
│     Local / Cloud Kubernetes Cluster      │
│   (Docker Desktop / AKS / EKS / GKE)      │
│-------------------------------------------│
│ Namespace: healthcare                     │
│                                           │
│  ┌─────────────────────────────────────┐ │
│  │ patient-api Deployment               │ │
│  │ ClusterIP Service                    │ │
│  └─────────────────────────────────────┘ │
│                                           │
│  ┌─────────────────────────────────────┐ │
│  │ appointment-service Deployment       │ │
│  │ ClusterIP Service                    │ │
│  └─────────────────────────────────────┘ │
│                                           │
│  ┌─────────────────────────────────────┐ │
│  │ billing-service Deployment           │ │
│  │ ClusterIP Service                    │ │
│  └─────────────────────────────────────┘ │
│                                           │
│  ┌─────────────────────────────────────┐ │
│  │ portal-ui Deployment                 │ │
│  │ NodePort / Ingress                   │ │
│  └─────────────────────────────────────┘ │
│                                           │
│ Deployment handled by:                    │
│ • dev.sh                                 │
│ • kubectl apply                          │
│ • helm upgrade --install                 │
└──────────────────────┬────────────────────┘
                       │ Metrics
                       v
┌───────────────────────────────────────────┐
│        Monitoring & Observability          │
│-------------------------------------------│
│ Prometheus → Scrapes pod & node metrics   │
│ Grafana    → Dashboards                   │
│ Alerts     → Email / Slack (optional)     │
└───────────────────────────────────────────┘
