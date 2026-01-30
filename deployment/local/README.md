# Local Deployment with Docker Compose

## Container Organization with Labels

All containers are labeled for easy filtering and organization:

```
Infrastructure (labeled: com.ecommerce.category=infrastructure)
├── Data Tier (com.ecommerce.tier=data)
│   ├── ecomm-postgres     (type: database)
│   ├── ecomm-mongodb      (type: database)
│   └── ecomm-redis        (type: cache)
└── Middleware Tier (com.ecommerce.tier=middleware)
    └── ecomm-rabbitmq     (type: messaging)
```

---

## Starting Infrastructure

```powershell
# From this directory
docker-compose -f docker-compose.infrastructure.yml up -d

# Or from root
cd C:\Users\U423550\ecomm
docker-compose -f deployment/local/docker-compose.infrastructure.yml up -d
```

---

## Filtering Containers by Labels

### View all infrastructure containers
```powershell
docker ps --filter "label=com.ecommerce.category=infrastructure"
```

### View only databases
```powershell
docker ps --filter "label=com.ecommerce.type=database"
```

### View only data tier
```powershell
docker ps --filter "label=com.ecommerce.tier=data"
```

### Stop all infrastructure containers
```powershell
docker stop $(docker ps -q --filter "label=com.ecommerce.category=infrastructure")
```

---

## Viewing Container Groups in Docker Desktop

**Docker Desktop UI:**
1. Open Docker Desktop
2. Go to "Containers"
3. You'll see containers grouped by compose project
4. Filter by clicking on labels in the UI

**Group by label (CLI):**
```powershell
# List by category
docker ps --format "table {{.Names}}\t{{.Label \"com.ecommerce.category\"}}\t{{.Label \"com.ecommerce.type\"}}\t{{.Status}}"
```

---

## Label Schema

| Label | Purpose | Values |
|-------|---------|--------|
| `com.ecommerce.category` | Main grouping | `infrastructure`, `services`, `gateway`, `observability` |
| `com.ecommerce.type` | Component type | `database`, `cache`, `messaging`, `api`, etc. |
| `com.ecommerce.tier` | Architecture tier | `data`, `middleware`, `application`, `presentation` |

---

## Useful Commands

### View all containers with labels
```powershell
docker inspect ecomm-postgres --format='{{json .Config.Labels}}' | ConvertFrom-Json
```

### View all containers in a nice table
```powershell
docker ps -a --format "table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}"
```

### View logs by category
```powershell
# All infrastructure logs
docker-compose -f docker-compose.infrastructure.yml logs -f
```

### Health check status
```powershell
docker ps --format "table {{.Names}}\t{{.Status}}"
```

---

## Quick Reference

**Start:** `docker-compose -f docker-compose.infrastructure.yml up -d`  
**Stop:** `docker-compose -f docker-compose.infrastructure.yml stop`  
**Logs:** `docker-compose -f docker-compose.infrastructure.yml logs -f`  
**Status:** `docker-compose -f docker-compose.infrastructure.yml ps`  
**Remove:** `docker-compose -f docker-compose.infrastructure.yml down`  
**Remove + Data:** `docker-compose -f docker-compose.infrastructure.yml down -v`

---

## Access Points

| Service | URL/Connection | Credentials |
|---------|---------------|-------------|
| PostgreSQL | localhost:5432 | ecommerce / dev123 |
| MongoDB | mongodb://localhost:27017 | admin / dev123 |
| Redis | localhost:6379 | password: dev123 |
| RabbitMQ UI | http://localhost:15672 | admin / dev123 |
