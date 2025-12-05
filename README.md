# Healthcare Microservices DevOps Project

This project contains 4 microservices, Kubernetes deployments, Helm charts, Terraform automation, GitHub Actions CI/CD pipelines, and a full monitoring setup using Prometheus & Grafana.  
This architecture is built exactly like real enterprise DevOps environments (CVS Health, Stanford Health Care, Kaiser, etc.).

---

# ⭐ Project Architecture

The system has 4 microservices:

- **patient-api**
- **appointment-service**
- **billing-service**
- **portal-ui (frontend)**

Technologies used:

- Docker
- Kubernetes (manifests)
- Helm Charts
- Terraform
- GitHub Actions CI/CD
- Prometheus + Grafana

---

# ⭐ Folder Structure (Final Blueprint)

```
devops-project/
│
├── services/
│   ├── patient-api/
│   ├── appointment-service/
│   ├── billing-service/
│   └── portal-ui/
│
├── k8s-manifests/
│   ├── namespace.yaml
│   ├── patient-api/
│   ├── appointment-service/
│   ├── billing-service/
│   └── portal-ui/
│
├── helm-charts/
│   ├── patient-api-chart/
│   ├── appointment-chart/
│   ├── billing-chart/
│   └── portal-ui-chart/
│
├── terraform/
│   ├── namespaces.tf
│   ├── secrets.tf
│   ├── variables.tf
│   └── outputs.tf
│
├── .github/
│   └── workflows/
│       ├── build.yaml
│       └── deploy.yaml
│
├── monitoring/
│   ├── prometheus.yaml
│   └── grafana-dashboards/
│       └── main-dashboard.json
│
└── README.md
```

---

# ⭐ Microservices

Each microservice includes:

- `app.js`
- `Dockerfile`
- `.dockerignore`
- `package.json`

To run locally:

```bash
cd services/patient-api
npm install
npm start
```

---

# ⭐ Docker Build Commands

```
docker build -t sudheerthota/patient-api:latest ./services/patient-api
docker build -t sudheerthota/appointment-service:latest ./services/appointment-service
docker build -t sudheerthota/billing-service:latest ./services/billing-service
docker build -t sudheerthota/portal-ui:latest ./services/portal-ui
```

---

# ⭐ Kubernetes Deployment

Create namespace:

```bash
kubectl apply -f k8s-manifests/namespace.yaml
```

Deploy patient-api:

```bash
kubectl apply -f k8s-manifests/patient-api/deployment.yaml
kubectl apply -f k8s-manifests/patient-api/service.yaml
```

Repeat for appointment, billing, portal-ui.

---

# ⭐ Helm Deployment (Production Ready)

```
helm upgrade --install patient-api ./helm-charts/patient-api-chart --namespace healthcare-app --create-namespace
helm upgrade --install appointment-service ./helm-charts/appointment-chart --namespace healthcare-app
helm upgrade --install billing-service ./helm-charts/billing-chart --namespace healthcare-app
helm upgrade --install portal-ui ./helm-charts/portal-ui-chart --namespace healthcare-app
```

---

# ⭐ Terraform Setup

Initialize:

```bash
cd terraform
terraform init
terraform apply
```

Terraform creates:

- Kubernetes namespace  
- Docker registry secret  
- Output variables  

---

# ⭐ CI/CD (GitHub Actions)

### 🔹 build.yaml  
Builds and pushes Docker images for all four microservices.

### 🔹 deploy.yaml  
Deploys all Helm charts to Kubernetes automatically.

---

# ⭐ Monitoring (Prometheus + Grafana)

Prometheus scrapes:

- CPU usage  
- Memory usage  
- Pod restarts  
- Live pod metrics  

Grafana shows dashboards (JSON config is inside `monitoring/grafana-dashboards/`).

---

# ⭐ Access the UI

Forward the portal-ui service:

```bash
kubectl port-forward svc/portal-ui 8080:8080 -n healthcare-app
```

Open browser:

```
http://localhost:8080
```

---

# ⭐ Summary

This project demonstrates:

- Real-world microservices architecture  
- Automated Kubernetes deployments  
- Helm-based production rollout  
- GitHub Actions CI/CD  
- Terraform infrastructure setup  
- Full monitoring & observability  
- Enterprise-grade DevOps pipeline  

Perfect for:

✔️ Resume  
✔️ GitHub portfolio  
✔️ DevOps interviews  
✔️ Learning real industry patterns  

---

# ⭐ Author

**Shanmukha Sudheer Thota**  
DevOps & Cloud Engineer
