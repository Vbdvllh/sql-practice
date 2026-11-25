# SQL Practice Lab (PostgreSQL 16 + Offline Runner)

Covers **Stage 1** missions:
- **S1-03**: PostgreSQL 16 running in Docker (`docker-compose.yml`) with automatic schema & seed loading.
- **S1-02**: 50 solved `.sql` problems (`problems/01_*.sql` … `problems/50_*.sql`), including ≥ 10 window functions / CTEs.

The schema (`init/01_schema.sql`) models both **Egyptian B2B/B2C commerce** (`customers`, `products`, `orders`, `order_items`) and **security audit logs** (`security_audit_logs`) so you practice Data Analytics and GRC/SOC SQL in one place.

## Quick start

### Option A — PostgreSQL 16 in Docker
```powershell
docker compose up -d
docker exec -it sql_practice_pg psql -U bis_analyst -d egypt_commerce
```

### Option B — Instant offline verification (no Docker daemon needed)
```powershell
python scripts/run_sql.py problems/01_monthly_revenue_growth_lag.sql
python scripts/run_sql.py --all
```

## Roadmap to 50 Queries (`PROBLEMS.md`)
5 reference queries (`01`–`05`) are included as examples of CTEs, `LAG`, `DENSE_RANK`, running totals, and `LEAD` audit-log investigation. Solve `06`–`50` from [`PROBLEMS.md`](PROBLEMS.md) to unlock **S1-02** in `career-ops`.
