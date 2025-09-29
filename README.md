# Expense Tracker - Kubernetes Version

## Overview
This is a simple Expense Tracker web application using:
- Backend: Flask (Python)
- Frontend: HTML + JS (served via Nginx)
- Deployment: Docker + Kubernetes (Minikube)

## Steps to Run

1. Start Minikube:
   ```bash
   minikube start
   eval $(minikube docker-env)
   ```

2. Build Docker images:
   ```bash
   docker build -t expense-backend ./backend
   docker build -t expense-frontend ./frontend
   ```

3. Apply Kubernetes manifests:
   ```bash
   kubectl apply -f k8s/
   ```

4. Delete old pods if needed:
   ```bash
   kubectl delete pod -l app=frontend
   kubectl delete pod -l app=backend
   ```

5. Verify pods:
   ```bash
   kubectl get pods
   ```

6. Open frontend:
   ```bash
   minikube service frontend-service
   ```