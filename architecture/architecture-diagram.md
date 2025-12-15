# Healthcare Microservices DevOps Project

## Enterprise Architecture & Maintenance Model

---

## High-Level Architecture Flow

Developers
|
| git push
v
GitHub Repository
|
| CI trigger
v
GitHub Actions (CI)
|
| Docker images
v
Docker Hub Registry
|
| Image pull
v
Kubernetes Cluster
|
| Metrics
v
Prometheus & Grafana

yaml
Copy code

---

## Detailed End-to-End Architecture

┌──────────────────────────────────────────────────────────────┐
│ DEVELOPERS │
│--------------------------------------------------------------│
│ Write & update microservices code │
│ Update Dockerfiles │
│ Update Helm charts & Kubernetes manifests │
│ Update Terraform & monitoring configurations │
│ │
│ Services: │
│ patient-api | appointment-service | billing-service | UI │
└──────────────────────────────┬───────────────────────────────┘
│ git commit & push
v
┌──────────────────────────────────────────────────────────────┐
│ GITHUB REPOSITORY │
│--------------------------------------------------------------│
│ services/ │
│ k8s-manifests/ │
│ helm-charts/ │
│ terraform/ │
│ monitoring/ │
│ .github/workflows/build.yaml │
│ dev.sh │
│ README.md │
└──────────────────────────────┬───────────────────────────────┘
│ CI trigger
v
┌──────────────────────────────────────────────────────────────┐
│ GITHUB ACTIONS (CI ONLY) │
│--------------------------------------------------------------│
│ Checkout source code │
│ Login to Docker Hub (GitHub Secrets) │
│ Build Docker images │
│ Tag images (latest / commit SHA) │
│ Push images to Docker Hub │
│ │
│ ❌ No kubectl / helm │
│ ❌ No Kubernetes access │
└──────────────────────────────┬───────────────────────────────┘
│ Docker images
v
┌──────────────────────────────────────────────────────────────┐
│ DOCKER HUB REGISTRY │
│--------------------------------------------------------------│
│ sudheerthota25/patient-api │
│ sudheerthota25/appointment-service │
│ sudheerthota25/billing-service │
│ sudheerthota25/portal-ui │
└──────────────────────────────┬───────────────────────────────┘
│ docker pull
v
┌──────────────────────────────────────────────────────────────┐
│ KUBERNETES CLUSTER (RUNTIME) │
│--------------------------------------------------------------│
│ Environment: Docker Desktop / AKS / EKS / GKE │
│ Namespace: healthcare │
│ │
│ patient-api Deployment → ClusterIP Service │
│ appointment-service Deployment → ClusterIP Service │
│ billing-service Deployment → ClusterIP Service │
│ portal-ui Deployment → NodePort / Ingress │
│ │
│ Deployment handled via: │
│ dev.sh │
│ kubectl apply │
│ helm upgrade --install │
└──────────────────────────────┬───────────────────────────────┘
│ metrics
v
┌──────────────────────────────────────────────────────────────┐
│ MONITORING & OBSERVABILITY │
│--------------------------------------------------------------│
│ Prometheus: pod & node metrics │
│ Grafana: dashboards & visualization │
│ Alerts: email / Slack (optional) │
└──────────────────────────────────────────────────────────────┘