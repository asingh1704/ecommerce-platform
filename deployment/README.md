# Deployment Directory Structure

This directory contains all deployment and orchestration configurations.

## Structure

```
deployment/
├── local/                          # Docker Compose (Local Development / UAT)
│   ├── docker-compose.infrastructure.yml    # Databases, cache, message queue
│   └── docker-compose.services.yml          # Microservices
│
├── kubernetes/                     # Kubernetes (Production-like)
│   ├── namespaces/                # K8s namespace definitions
│   ├── infrastructure/            # Database deployments, StatefulSets
│   ├── services/                  # Microservice deployments
│   ├── gateway/                   # Kong, Keycloak
│   └── observability/             # Prometheus, Grafana, Jaeger
│
└── helm/                          # Helm Charts
    └── charts/                    # Helm packages for K8s deployment
```

## Local Development (Docker Compose)

**Start infrastructure:**
```powershell
cd deployment/local
docker-compose -f docker-compose.infrastructure.yml up -d
```

**Start services:**
```powershell
docker-compose -f docker-compose.services.yml up -d
```

## Kubernetes (Production)

**Deploy with kubectl:**
```powershell
cd deployment/kubernetes
kubectl apply -f namespaces/
kubectl apply -f infrastructure/
kubectl apply -f services/
```

**Or use Helm:**
```powershell
cd deployment/helm
helm install ecommerce ./charts/ecommerce-platform
```

## Environments

- **local/** = UAT environment (docker-compose)
- **kubernetes/** = Production-like (k3d/kind cluster)
- **helm/** = Package management for K8s
