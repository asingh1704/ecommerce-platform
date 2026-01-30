# Cloud-Native E-Commerce Platform

## Overview
Enterprise-grade, cloud-native e-commerce platform built with microservices architecture, demonstrating production-ready patterns for payments, fraud detection, and distributed systems.

## Architecture
- **15 Microservices** (Product, Order, Payment, Inventory, Cart, User, Shipping, Notification, Search, Review, Recommendation, Analytics, Fraud, Image, Warehouse)
- **Kong API Gateway** - Enterprise API management
- **Keycloak** - OAuth 2.0 / OIDC identity provider
- **Event-Driven Architecture** - RabbitMQ + Kafka/Redpanda
- **Full Observability** - Prometheus, Grafana, Jaeger, Loki
- **Service Mesh** - Istio (Kubernetes)
- **Two Environments**:
  - UAT: Docker Compose (local development)
  - PROD: Kubernetes (k3d/kind)

## Technology Stack (100% Free Tier)

### Backend
- .NET 8.0
- ASP.NET Core Web API
- Entity Framework Core
- gRPC for inter-service communication

### Frontend
- React 18 + TypeScript
- Vite (build tool)
- Tailwind CSS
- Redux Toolkit

### Databases
- PostgreSQL 15 (relational data)
- MongoDB (document store)
- Redis (cache & sessions)
- Elasticsearch (search)
- TimescaleDB (time-series analytics)

### Infrastructure
- Docker Desktop
- Kubernetes (k3d)
- Kong Gateway (OSS)
- Keycloak
- RabbitMQ
- Kafka/Redpanda
- MinIO (S3-compatible storage)

### Observability
- Prometheus (metrics)
- Grafana (visualization)
- Jaeger (distributed tracing)
- Loki (logging)
- OpenTelemetry (instrumentation)
- Kiali (service mesh UI)

### Payment Integrations
- Stripe (cards, Apple Pay, Google Pay)
- PayPal
- Adyen (international methods)

## Quick Start

### Prerequisites
```powershell
# Install required tools
choco install docker-desktop
choco install kubernetes-cli
choco install k3d
choco install dotnet-sdk
choco install nodejs
choco install git
```

### UAT Environment (Docker Compose)
```powershell
# Clone and navigate
cd C:\Users\U423550\ecomm

# Start infrastructure
docker-compose up -d

# Access services
# Web App:        http://localhost:3000
# Admin Portal:   http://localhost:3001
# Kong Gateway:   http://localhost:8000
# Kong Admin:     http://localhost:8001
# Keycloak:       http://localhost:8080
# Grafana:        http://localhost:4000
# Prometheus:     http://localhost:9090
# Jaeger UI:      http://localhost:16686
```

### PROD Environment (Kubernetes)
```powershell
# Create k3d cluster
.\scripts\setup-k8s.ps1

# Deploy with ArgoCD (GitOps)
kubectl apply -f k8s/argocd/applications/

# Or deploy manually
kubectl apply -f k8s/namespaces/
kubectl apply -f k8s/infrastructure/
kubectl apply -f k8s/gateway/
kubectl apply -f k8s/services/
kubectl apply -f k8s/observability/
```

## Development Roadmap

### Phase 1: Foundation (Weeks 1-2) ✅ IN PROGRESS
- [x] Project structure
- [x] Documentation
- [ ] Docker Compose setup
- [ ] Kong Gateway
- [ ] Keycloak integration
- [ ] Product Service
- [ ] User Service
- [ ] Cart Service
- [ ] Shared libraries
- [ ] Basic React frontend

### Phase 2: Core Services (Weeks 3-4)
- [ ] All 15 microservices
- [ ] Event-driven communication
- [ ] Database per service
- [ ] Service discovery

### Phase 3: Observability (Week 5)
- [ ] Prometheus + Grafana
- [ ] Jaeger tracing
- [ ] Loki logging
- [ ] Dashboards & alerts

### Phase 4: Frontend (Week 6)
- [ ] React web application
- [ ] Shopping cart & checkout
- [ ] Payment integration
- [ ] Admin portal

### Phase 5: Payments (Week 7)
- [ ] Stripe integration
- [ ] PayPal integration
- [ ] Webhook handling
- [ ] Fraud detection

### Phase 6: Advanced Features (Week 8)
- [ ] Search (Elasticsearch)
- [ ] Recommendations
- [ ] Reviews & ratings
- [ ] Image service (MinIO)

### Phase 7: Kubernetes (Week 9-10)
- [ ] K3d cluster setup
- [ ] Helm charts
- [ ] ArgoCD GitOps
- [ ] Istio service mesh

### Phase 8: Testing (Week 11)
- [ ] Unit tests (80%+ coverage)
- [ ] Integration tests
- [ ] E2E tests (Playwright)
- [ ] Load tests (k6)

### Phase 9: Production Hardening (Week 12)
- [ ] Security scanning
- [ ] Chaos engineering
- [ ] Backup & restore
- [ ] Documentation

## Documentation

See [docs/](./docs/) directory for:
- [System Architecture](./docs/architecture/SYSTEM_ARCHITECTURE.md)
- [Service Catalog](./docs/architecture/SERVICE_CATALOG.md)
- [Payment Integration Guide](./docs/architecture/PAYMENT_INTEGRATION.md)
- [Deployment Guide](./docs/deployment/DEPLOYMENT_GUIDE.md)
- [Observability Guide](./docs/deployment/OBSERVABILITY_GUIDE.md)

## Current Status: Phase 1

We're building the foundation with:
1. ✅ Project structure created
2. 🔄 Docker Compose infrastructure
3. 🔄 First microservice (Product Service)
4. 🔄 Kong Gateway setup
5. 🔄 Keycloak OAuth integration

---

**Built with ❤️ for learning cloud-native architecture, payments, and distributed systems**
