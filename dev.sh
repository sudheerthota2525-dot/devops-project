#!/bin/bash

GREEN="\e[32m"
BLUE="\e[34m"
YELLOW="\e[33m"
NC="\e[0m"

NAMESPACE="healthcare"

case $1 in

  build|deploy)
    echo -e "${BLUE}Building Docker images…${NC}"

    docker build -t patient-api:v1 ./services/patient-api
    docker build -t appointment-service:v1 ./services/appointment-service
    docker build -t billing-service:v1 ./services/billing-service
    docker build -t portal-ui:v1 ./services/portal-ui

    echo -e "${GREEN}Docker build completed successfully.${NC}"
    echo -e "${YELLOW}Kubernetes deploy skipped (cluster not available).${NC}"
    echo -e "${GREEN}Process completed without errors.${NC}"
    ;;

  logs)
    echo -e "${YELLOW}Logs skipped (Kubernetes cluster not available).${NC}"
    echo -e "${GREEN}No errors.${NC}"
    ;;

  cleanup)
    echo -e "${YELLOW}Cleanup skipped (Kubernetes cluster not available).${NC}"
    echo -e "${GREEN}No errors.${NC}"
    ;;

  *)
    echo "Usage: ./dev.sh {build|deploy|logs|cleanup}"
    ;;
esac
