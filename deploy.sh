#!/bin/bash

echo "🔹 Step 1: Stop and delete existing Minikube cluster"
minikube stop
minikube delete

echo "🔹 Step 2: Start Minikube"
minikube start

echo "🔹 Step 3: Set Docker environment to Minikube"
eval $(minikube docker-env)

echo "🔹 Step 4: Remove old Docker images"
docker rmi -f $(docker images -q) 2>/dev/null || true

echo "🔹 Step 5: Build Docker images"
docker build -t expense-backend ./backend
docker build -t expense-frontend ./frontend

echo "🔹 Step 6: Apply Kubernetes manifests"
kubectl apply -f k8s/

echo "🔹 Step 7: Wait for pods to be ready"
kubectl wait --for=condition=ready pod -l app=backend --timeout=120s
kubectl wait --for=condition=ready pod -l app=frontend --timeout=120s

echo "🔹 Step 8: Show pods and services"
kubectl get pods
kubectl get svc

echo "🔹 Step 9: Open frontend in browser"
minikube service frontend-service

