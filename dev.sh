#!/bin/bash

# Colors (for neat output)
GREEN="\e[32m"
BLUE="\e[34m"
NC="\e[0m"

case $1 in

  build)
    echo -e "${BLUE}🔨 Building all Docker images…${NC}"
    docker build -t patient-api:v1 ./services/patient-api
    docker build -t appointment-service:v1 ./services/appointment-service
    docker build -t billing-service:v1 ./services/billing-service
    docker build -t portal-ui:v1 ./services/portal-ui
    echo -e "${GREEN}✔ Build complete${NC}"
    ;;

  run)
    echo -e "${BLUE}🚀 Running all services locally…${NC}"

    docker run -d --name patient-api -p 3001:3000 patient-api:v1
    docker run -d --name appointment-service -p 3002:3001 appointment-service:v1
    docker run -d --name billing-service -p 3003:3002 billing-service:v1
    docker run -d --name portal-ui -p 8080:80 portal-ui:v1

    echo -e "${GREEN}✔ Services running. Access URLs below:\n${NC}"
    echo "Patient API       → http://localhost:3001"
    echo "Appointment API   → http://localhost:3002"
    echo "Billing API       → http://localhost:3003"
    echo "Portal UI         → http://localhost:8080"
    ;;

  deploy)
    echo -e "${BLUE}📦 Deploying all manifests to Kubernetes…${NC}"
    kubectl apply -f k8s-manifests/
    echo -e "${GREEN}✔ K8s deploy complete${NC}"
    echo -e "${BLUE}⏳ Checking Pods…${NC}"
    kubectl get pods -n default
    echo -e "${BLUE}📌 Checking Services…${NC}"
    kubectl get svc -n default
    ;;

  logs)
    echo -e "${BLUE}📜 Showing logs for container: $2${NC}"
    docker logs -f $2
    ;;

  stop)
    echo -e "${BLUE}🛑 Stopping all containers…${NC}"
    docker stop $(docker ps -q)
    docker rm $(docker ps -aq)
    echo -e "${GREEN}✔ All containers stopped & removed${NC}"
    ;;

  *)
    echo "Usage: ./dev.sh {build|run|deploy|logs|stop}"
    ;;
esac
