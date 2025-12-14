# Healthcare Microservices DevOps Project

This repository demonstrates a **real-world DevOps implementation** using microservices, Docker, Kubernetes, Helm, Terraform, GitHub Actions CI/CD, and monitoring with Prometheus & Grafana.

The project is designed to closely reflect **enterprise DevOps practices** followed in healthcare and large organizations (CVS Health, Stanford Health Care, Kaiser Permanente, etc.).

---

## ⭐ Project Overview

The system consists of **four microservices**:

- **patient-api**
- **appointment-service**
- **billing-service**
- **portal-ui** (frontend)

Each service is containerized and deployed to Kubernetes using manifests and Helm charts.

---

## ⭐ Technologies Used

- Docker
- Kubernetes (Docker Desktop Kubernetes)
- Helm
- Terraform
- GitHub Actions (CI)
- Prometheus & Grafana
- Bash scripting (`dev.sh`)

---

## ⭐ Folder Structure (Final)

devops-project/
│
├── services/
│ ├── patient-api/
│ ├── appointment-service/
│ ├── billing-service/
│ └── portal-ui/
│
├── k8s-manifests/
│ ├── namespace.yaml
│ ├── patient-api/
│ ├── appointment-service/
│ ├── billing-service/
│ └── portal-ui/
│
├── helm-charts/
│ ├── patient-api-chart/
│ ├── appointment-chart/
│ ├── billing-chart/
│ └── portal-ui-chart/
│
├── terraform/
│ ├── namespaces.tf
│ ├── secrets.tf
│ ├── variables.tf
│ └── outputs.tf
│
├── monitoring/
│ ├── prometheus.yaml
│ └── grafana-dashboards/
│
├── .github/
│ └── workflows/
│ └── build.yaml
│
├── dev.sh
└── README.md

yaml
Copy code

---

## ⭐ Microservices Structure

Each backend service contains:

- `app.js`
- `Dockerfile`
- `.dockerignore`
- `package.json`

Run locally (example):

```bash
cd services/patient-api
npm install
npm start
⭐ Docker Images & Registry
Docker images are built and pushed to Docker Hub using GitHub Actions.

Docker Hub Username: sudheerthota25

Images:

sudheerthota25/patient-api

sudheerthota25/appointment-service

sudheerthota25/billing-service

sudheerthota25/portal-ui

⭐ dev.sh (Local Automation Script)
dev.sh is used for local development and deployment.

Available Commands
bash
Copy code
./dev.sh build
./dev.sh deploy
./dev.sh logs <deployment-name>
./dev.sh cleanup
What Each Command Does
Build Docker Images
bash
Copy code
./dev.sh build
Builds all microservice Docker images locally

Deploy to Kubernetes
bash
Copy code
./dev.sh deploy
Creates namespace healthcare

Deploys all Kubernetes manifests

Verifies pods and services

View Logs
bash
Copy code
./dev.sh logs patient-api-deployment
Cleanup
bash
Copy code
./dev.sh cleanup
Deletes the healthcare namespace and all resources

⭐ Kubernetes Deployment (Manifests)
Create namespace:

bash
Copy code
kubectl apply -f k8s-manifests/namespace.yaml
Deploy all services:

bash
Copy code
kubectl apply -n healthcare \
  -f k8s-manifests/patient-api/ \
  -f k8s-manifests/appointment-service/ \
  -f k8s-manifests/billing-service/ \
  -f k8s-manifests/portal-ui/
⭐ Helm Deployment (Production-Style)
bash
Copy code
helm upgrade --install patient-api ./helm-charts/patient-api-chart -n healthcare --create-namespace
helm upgrade --install appointment-service ./helm-charts/appointment-chart -n healthcare
helm upgrade --install billing-service ./helm-charts/billing-chart -n healthcare
helm upgrade --install portal-ui ./helm-charts/portal-ui-chart -n healthcare
⭐ Terraform Setup
bash
Copy code
cd terraform
terraform init
terraform apply
Terraform provisions:

Kubernetes namespace

Secrets

Outputs for reuse

⭐ CI/CD (GitHub Actions)
build.yaml
Builds Docker images

Pushes images to Docker Hub

Uses GitHub Secrets for authentication

Does NOT deploy to Kubernetes (intentional design)

This separation avoids CI failures and follows industry best practices.

⭐ Monitoring (Prometheus & Grafana)
Prometheus scrapes:

CPU usage

Memory usage

Pod restarts

Grafana dashboards visualize cluster and application metrics

⭐ Access the Application
Check NodePort:

bash
Copy code
kubectl get svc portal-ui -n healthcare
Open browser:

text
Copy code
http://localhost:<NODE_PORT>
⭐ Summary
This project demonstrates:

Enterprise-grade microservices architecture

Docker image automation

Kubernetes deployments

Helm-based releases

GitHub Actions CI/CD

Secure secret management

Observability with Prometheus & Grafana

⭐ Author
Shanmukha Sudheer Thota
DevOps & Cloud Engineer