# Infrastructure Quick Reference

## What Each Component Does

### PostgreSQL (Relational Database)
**What:** Traditional SQL database with ACID guarantees
**Use for:** 
- Orders (need transactions)
- User accounts
- Inventory (strict consistency)
- Payment records

**Why:** When you need strict data consistency and relationships

**Example:** 
```sql
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  user_id INT,
  total DECIMAL,
  status VARCHAR(50)
);
```

---

### MongoDB (Document Database)
**What:** NoSQL database storing JSON-like documents
**Use for:**
- Product catalog (flexible attributes per product)
- Product reviews
- User activity logs

**Why:** Flexible schema, fast reads, good for nested data

**Example:**
```json
{
  "_id": "prod123",
  "name": "Laptop",
  "price": 999.99,
  "specs": {
    "ram": "16GB",
    "storage": "512GB SSD"
  },
  "tags": ["electronics", "computers"]
}
```

---

### Redis (In-Memory Cache)
**What:** Super-fast key-value store in RAM
**Use for:**
- Shopping carts (temporary data)
- Session storage
- Cache (product details, avoid DB queries)
- Rate limiting

**Why:** Microsecond response time, perfect for temporary data

**Example:**
```
SET cart:user123 '{"items": [{"id": "prod123", "qty": 2}]}'
EXPIRE cart:user123 3600  # Auto-delete after 1 hour
```

---

### RabbitMQ (Message Queue)
**What:** Message broker for async communication
**Use for:**
- Decouple services
- Async tasks (send email, process image)
- Event-driven architecture

**Why:** Services don't need to call each other directly

**Example Flow:**
```
Order Service → Publishes "OrderPlaced" event → RabbitMQ
                                                    ↓
                                    Email Service receives event
                                    Inventory Service receives event
                                    Analytics Service receives event
```

---

## Resource Usage

| Service | RAM | Disk | Port |
|---------|-----|------|------|
| PostgreSQL | ~200 MB | ~100 MB | 5432 |
| MongoDB | ~500 MB | ~200 MB | 27017 |
| Redis | ~100 MB | ~10 MB | 6379 |
| RabbitMQ | ~400 MB | ~50 MB | 5672, 15672 |
| **TOTAL** | **~1.2 GB** | **~360 MB** | - |

---

## Commands Cheat Sheet

```powershell
# Start infrastructure
docker-compose -f docker-compose.infrastructure.yml up -d

# Check what's running
docker ps

# View logs (all services)
docker-compose -f docker-compose.infrastructure.yml logs -f

# View logs (specific service)
docker-compose -f docker-compose.infrastructure.yml logs -f postgres

# Stop infrastructure (free RAM, keep data)
docker-compose -f docker-compose.infrastructure.yml stop

# Start again (instant)
docker-compose -f docker-compose.infrastructure.yml start

# Check health
docker-compose -f docker-compose.infrastructure.yml ps
```

---

## Testing Connections

### PostgreSQL
```powershell
# Connect using psql (if installed)
psql -h localhost -p 5432 -U ecommerce -d ecommerce

# Or using Docker exec
docker exec -it ecomm-postgres psql -U ecommerce -d ecommerce
```

### MongoDB
```powershell
# Using mongosh (if installed)
mongosh mongodb://admin:dev123@localhost:27017

# Or using Docker exec
docker exec -it ecomm-mongodb mongosh -u admin -p dev123
```

### Redis
```powershell
# Using redis-cli (if installed)
redis-cli -h localhost -p 6379 -a dev123

# Or using Docker exec
docker exec -it ecomm-redis redis-cli -a dev123
# Then: PING (should return PONG)
```

### RabbitMQ
```
Open browser: http://localhost:15672
Username: admin
Password: dev123
```

---

## Network Explained

All containers are on the same network: `ecommerce-network`

**From your laptop:**
- Use `localhost` or `127.0.0.1`
- Example: `localhost:5432`

**From one container to another:**
- Use service name (from docker-compose)
- Example: `postgres:5432` or `redis:6379`

**Why this matters:**
Your Product Service (running in Docker) will connect to:
- `postgres:5432` (NOT localhost:5432)

Your development tools (running on Windows) will connect to:
- `localhost:5432`

---

## What Happens When You Start This

```
1. Docker pulls images (first time only, ~800 MB total)
2. Creates named volumes for data persistence
3. Creates ecommerce-network
4. Starts containers in order
5. Waits for healthchecks to pass
6. All services ready! (~30 seconds first time, ~5 seconds after)
```

---

## Ready to Start?

Run this command:
```powershell
cd C:\Users\U423550\ecomm
docker-compose -f docker-compose.infrastructure.yml up -d
```

You should see:
```
Creating network "ecomm_ecommerce-network" ... done
Creating volume "ecomm_postgres-data" ... done
Creating volume "ecomm_mongo-data" ... done
Creating volume "ecomm_redis-data" ... done
Creating volume "ecomm_rabbitmq-data" ... done
Creating ecomm-postgres ... done
Creating ecomm-mongodb  ... done
Creating ecomm-redis    ... done
Creating ecomm-rabbitmq ... done
```

Verify everything is healthy:
```powershell
docker ps
```

All containers should show `(healthy)` in STATUS column.
