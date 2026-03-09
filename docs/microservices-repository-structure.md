# Microservices Repository Structure

Standard repository structure for all IoT-Hub microservices.

---

## Recommended Structure

All services follow this structure regardless of complexity. Simple services will have fewer files, but the folder layout stays the same.

```
service-name/
├── app/                        # Source code
│   ├── __init__.py
│   ├── main.py                 # Entry point
│   ├── api/                    # HTTP/gRPC layer
│   │   ├── __init__.py
│   │   └── routes.py
│   ├── core/                   # Configuration & utilities
│   │   ├── __init__.py
│   │   └── config.py
│   ├── models/                 # Data models (if needed)
│   │   └── __init__.py
│   ├── services/               # Business logic
│   │   └── __init__.py
│   └── db/                     # Database (if needed)
│       └── __init__.py
│
├── tests/                      # Test suite
│   ├── conftest.py
│   ├── unit/
│   └── integration/
│
├── scripts/                    # Utility scripts (if needed)
├── configs/                    # Config files (if needed)
│
├── Dockerfile
├── requirements.txt
├── requirements-dev.txt
├── .env.example
├── .gitignore
├── CHANGELOG.md
└── README.md
```

---

## Required Files (All Services)

| File/Folder | Purpose |
|-------------|---------|
| `app/` | Application source code |
| `tests/` | Unit and integration tests |
| `Dockerfile` | Container build |
| `requirements.txt` | Dependencies |
| `.env.example` | Environment variable template |
| `README.md` | Overview, setup, env vars |

## Optional (Add When Needed)

| Folder | When to Add |
|--------|-------------|
| `scripts/` | Custom startup, migration, or seed scripts |
| `configs/` | External config files (YAML, JSON) |
| `migrations/` | Database migrations (Alembic) |
| `app/db/` | Services with database access |
| `app/models/` | Services with data models |

---

## Example: Simple Service (HTTP Ingest)

```
http-ingest/
├── app/
│   ├── __init__.py
│   ├── main.py
│   ├── api/
│   │   ├── __init__.py
│   │   └── routes.py
│   ├── core/
│   │   ├── __init__.py
│   │   └── config.py
│   └── services/
│       ├── __init__.py
│       └── kafka_producer.py
├── tests/
│   ├── conftest.py
│   └── unit/
│       └── test_routes.py
├── Dockerfile
├── requirements.txt
├── .env.example
└── README.md
```

## Example: Complex Service (Device API)

```
device-api/
├── app/
│   ├── __init__.py
│   ├── main.py
│   ├── api/
│   │   ├── __init__.py
│   │   ├── routes.py
│   │   ├── dependencies.py
│   │   └── middleware.py
│   ├── core/
│   │   ├── __init__.py
│   │   ├── config.py
│   │   ├── logging.py
│   │   └── exceptions.py
│   ├── models/
│   │   ├── __init__.py
│   │   └── schemas.py
│   ├── services/
│   │   ├── __init__.py
│   │   └── device_service.py
│   └── db/
│       ├── __init__.py
│       ├── session.py
│       └── repository.py
├── tests/
│   ├── conftest.py
│   ├── unit/
│   │   ├── test_services.py
│   │   └── test_models.py
│   └── integration/
│       └── test_api.py
├── migrations/
│   └── versions/
├── docs/
│   └── architecture.md
├── scripts/
│   └── seed.sh
├── Dockerfile
├── requirements.txt
├── requirements-dev.txt
├── .env.example
├── CHANGELOG.md
└── README.md
```

---

## README.md Template

```markdown
# Service Name

Brief description.

## Quick Start

cp .env.example .env
docker-compose up

## Environment Variables

| Variable | Description | Required |
|----------|-------------|----------|
| `DATABASE_URL` | PostgreSQL connection | Yes |
| `KAFKA_BOOTSTRAP_SERVERS` | Kafka brokers | Yes |

## API

- Health: `GET /health`
- Docs: `GET /docs`

## Testing

pytest

## Related Services

- [service-a](https://github.com/org/service-a)
```
