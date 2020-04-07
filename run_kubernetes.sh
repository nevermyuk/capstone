#!/usr/bin/env bash

# Run Kubernetes locally.


# Deploy kubernetes service and deployment.
kubectl apply -f deployment.yaml

# List kubernetes pods
kubectl get pods

# Forward the container port to service
kubectl port-forward service/ml-micro-service 8000:8000

