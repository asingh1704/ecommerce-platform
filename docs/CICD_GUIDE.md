# CI/CD and Deployment Guide

## Overview

This project uses GitHub Actions for CI/CD automation and PowerShell scripts for local deployment.

## GitHub Actions Workflows

### 1. Infrastructure Deployment (`deploy-infrastructure.yml`)
**Triggers:**
- Push to `main` or `develop` branches
- Changes in `deployment/local/**`
- Manual trigger from GitHub UI

**What it does:**
- Validates docker-compose files
- Checks infrastructure configuration
- (Future) Deploys to cloud environments

### 2. Service Deployment (`deploy-services.yml`)
**Triggers:**
- Push to `main` or `develop` branches
- Changes in `src/Services/**`
- Manual trigger

**What it does:**
- Builds each microservice
- Runs unit tests
- Creates Docker images
- (Future) Pushes to container registry
- (Future) Deploys to K8s

## Local Deployment

### Using PowerShell Script (Recommended)

```powershell
# Navigate to project root
cd C:\Users\U423550\ecomm

# Start infrastructure
.\scripts\deploy-infrastructure.ps1 -Action up

# Check status
.\scripts\deploy-infrastructure.ps1 -Action status

# View logs
.\scripts\deploy-infrastructure.ps1 -Action logs

# Restart
.\scripts\deploy-infrastructure.ps1 -Action restart

# Stop (keep data)
.\scripts\deploy-infrastructure.ps1 -Action down
```

### Using Docker Compose Directly

```powershell
cd deployment/local

# Start
docker-compose -f docker-compose.infrastructure.yml up -d

# Stop
docker-compose -f docker-compose.infrastructure.yml down

# Logs
docker-compose -f docker-compose.infrastructure.yml logs -f

# Status
docker-compose -f docker-compose.infrastructure.yml ps
```

## Git Workflow

### Initial Setup
```powershell
cd C:\Users\U423550\ecomm

# Initialize git
git init

# Add remote (replace with your GitHub repo)
git remote add origin https://github.com/yourusername/ecommerce-platform.git

# Create .gitignore (already created)
# Commit initial code
git add .
git commit -m "Initial commit: Project structure and infrastructure"

# Push to GitHub
git push -u origin main
```

### Development Workflow

```powershell
# Create feature branch
git checkout -b feature/add-product-service

# Make changes to code...

# Commit changes
git add .
git commit -m "feat: Add Product Service with CRUD operations"

# Push to GitHub
git push origin feature/add-product-service

# Create Pull Request on GitHub
# GitHub Actions will automatically run tests and validation

# Merge to main → Triggers deployment workflow
```

## GitHub Actions - Manual Trigger

1. Go to your GitHub repository
2. Click **Actions** tab
3. Select workflow (e.g., "Infrastructure Deployment")
4. Click **Run workflow** button
5. Select branch and click **Run workflow**

## Environment Variables in GitHub

For cloud deployments, add secrets in GitHub:

1. Go to **Settings → Secrets and variables → Actions**
2. Click **New repository secret**
3. Add secrets:
   - `AWS_ACCESS_KEY_ID`
   - `AWS_SECRET_ACCESS_KEY`
   - `DOCKER_HUB_USERNAME`
   - `DOCKER_HUB_TOKEN`
   - Database passwords, API keys, etc.

## CI/CD Pipeline Flow

```
Developer
  ↓
git push
  ↓
GitHub
  ↓
GitHub Actions Trigger
  ↓
┌─────────────────────────────┐
│  1. Checkout Code           │
│  2. Build Services          │
│  3. Run Tests               │
│  4. Build Docker Images     │
│  5. Push to Registry        │
│  6. Deploy to Environment   │
└─────────────────────────────┘
  ↓
Deployment Complete
```

## Deployment Environments

| Environment | Trigger | Deploy Method | Infrastructure |
|-------------|---------|---------------|----------------|
| **Local (Dev)** | Manual | PowerShell script | Docker Compose |
| **UAT** | Push to `develop` | GitHub Actions | Docker Compose (remote) |
| **Staging** | Push to `main` | GitHub Actions | Kubernetes (k3d) |
| **Production** | Release tag | GitHub Actions | AWS EKS / AKS |

## Best Practices

### 1. Branch Strategy
```
main          → Production (protected)
develop       → UAT/Staging
feature/*     → Feature development
hotfix/*      → Emergency fixes
```

### 2. Commit Messages
```
feat: Add new feature
fix: Bug fix
docs: Documentation update
test: Add tests
refactor: Code refactoring
chore: Maintenance tasks
```

### 3. Pull Request Workflow
- Create feature branch
- Make changes
- Push and create PR
- Wait for CI checks to pass
- Get code review
- Merge to develop/main

### 4. Versioning
```
v1.0.0 → Major.Minor.Patch
v1.0.1 → Patch (bug fixes)
v1.1.0 → Minor (new features)
v2.0.0 → Major (breaking changes)
```

## Rollback Strategy

### Docker Compose
```powershell
# Stop current version
docker-compose down

# Checkout previous version
git checkout v1.0.0

# Deploy previous version
.\scripts\deploy-infrastructure.ps1 -Action up
```

### Kubernetes (Future)
```powershell
# Rollback to previous deployment
kubectl rollout undo deployment/product-service

# Rollback to specific revision
kubectl rollout undo deployment/product-service --to-revision=2
```

## Monitoring Deployments

### Check GitHub Actions Status
```
https://github.com/yourusername/ecommerce-platform/actions
```

### View Deployment Logs
```powershell
# Local
docker-compose -f deployment/local/docker-compose.infrastructure.yml logs -f

# Kubernetes (future)
kubectl logs -f deployment/product-service
```

## Next Steps

1. ✅ Set up Git repository
2. ✅ Create GitHub Actions workflows
3. ✅ Create deployment scripts
4. 🔄 Initialize Git and push to GitHub
5. 🔄 Test GitHub Actions workflows
6. 🔄 Add more microservices
7. 🔄 Implement K8s deployment

---

**Current Status:** Ready to initialize Git and start CI/CD pipeline!
