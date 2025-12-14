#!/bin/bash

GREEN="\e[32m"
BLUE="\e[34m"
NC="\e[0m"

NAMESPACE="healthcare"

case $1 in

  build)
    echo -e "${BLUE}Building Docker images…${NC}"
    docker build -t patient-api:v1 ./services/patient-api
    docker build -t appointment-service:v1 ./services/appointment-service
    docker build -t billing-service:v1 ./services/billing-service
    docker build -t portal-ui:v1 ./services/portal-ui
    echo -e "${GREEN}Build complete${NC}"
    ;;

  deploy)
    echo -e "${BLUE}Creating namespace…${NC}"
    kubectl create namespace $NAMESPACE --dry-run=client -o yaml | kubectl apply -f -

    echo -e "${BLUE}Deploying all services…${NC}"
    kubectl apply -n $NAMESPACE \
      -f k8s-manifests/patient-api/ \
      -f k8s-manifests/appointment-service/ \
      -f k8s-manifests/billing-service/ \
      -f k8s-manifests/portal-ui/

    echo -e "${GREEN}Deployment complete${NC}"

    kubectl get pods -n $NAMESPACE
    kubectl get svc -n $NAMESPACE
    ;;

  logs)
    kubectl logs -n $NAMESPACE deployment/$2
    ;;

  cleanup)
    kubectl delete namespace $NAMESPACE
    ;;

  *)
    echo "Usage: ./dev.sh {build|deploy|logs <deployment-name>|cleanup}"
    ;;
esac
