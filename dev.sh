#!/bin/bash

# Colors
GREEN="\e[32m"
BLUE="\e[34m"
NC="\e[0m"

NAMESPACE="healthcare"

case $1 in

  docker-env)
    echo -e "${BLUE}Pointing Docker to Minikube…${NC}"
    eval $(minikube -p minikube docker-env)
    echo -e "${GREEN}Docker is now using Minikube daemon${NC}"
    ;;

  build)
    echo -e "${BLUE}Building all Docker images inside Minikube…${NC}"
    docker build -t patient-api:v1 ./services/patient-api
    docker build -t appointment-service:v1 ./services/appointment-service
    docker build -t billing-service:v1 ./services/billing-service
    docker build -t portal-ui:v1 ./services/portal-ui
    echo -e "${GREEN}Build complete!${NC}"
    ;;

  deploy)
    echo -e "${BLUE}Creating namespace if not exists…${NC}"
    kubectl create namespace $NAMESPACE --dry-run=client -o yaml | kubectl apply -f -

    echo -e "${BLUE}Deploying Kubernetes manifests…${NC}"
    kubectl apply -n $NAMESPACE -f k8s-manifests/

    echo -e "${GREEN}Deployment complete!${NC}"
    echo -e "${BLUE}Checking Pods…${NC}"
    kubectl get pods -n $NAMESPACE

    echo -e "${BLUE}Checking Services…${NC}"
    kubectl get svc -n $NAMESPACE
    ;;

  logs)
    echo -e "${BLUE}Showing logs for: $2${NC}"
    kubectl logs -n $NAMESPACE -f $2
    ;;

  cleanup)
    echo -e "${BLUE}Deleting all resources in namespace: $NAMESPACE…${NC}"
    kubectl delete all --all -n $NAMESPACE
    echo -e "${GREEN}Cleanup complete${NC}"
    ;;

  *)
    echo "Usage: ./dev.sh {docker-env|build|deploy|logs <pod>|cleanup}"
    ;;
esac
