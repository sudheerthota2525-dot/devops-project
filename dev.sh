#!/bin/bash

case $1 in

  build)
    echo "Building all services…"
    docker build -t patient-api ./services/patient-api
    docker build -t appointment-service ./services/appointment-service
    docker build -t billing-service ./services/billing-service
    docker build -t portal-ui ./services/portal-ui
    ;;

  run)
    echo "Running all services…"
    docker run -d -p 3001:3001 patient-api
    docker run -d -p 3002:3002 appointment-service
    docker run -d -p 3003:3003 billing-service
    docker run -d -p 8080:80 portal-ui
    ;;

  deploy)
    echo "Deploying to Kubernetes…"
    kubectl apply -f k8s-manifests/
    ;;

  logs)
    echo "Showing logs for $2"
    docker logs -f $2
    ;;

  stop)
    echo "Stopping containers…"
    docker stop $(docker ps -q)
    ;;

  *)
    echo "Usage: ./dev.sh {build|run|deploy|logs|stop}"
    ;;
esac
