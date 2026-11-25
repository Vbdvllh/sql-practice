"""
Local SQL runner for sql-practice (stdlib sqlite3 mirror of the PostgreSQL init/ schema).

Lets you write, execute, and verify every .sql file in problems/ instantly — even offline or
when Docker Desktop is stopped — while keeping 100% compatibility with PostgreSQL 16.

Usage:
    python scripts/run_sql.py problems/01_monthly_revenue_growth_lag.sql
    python scripts/run_sql.py --all
"""
from __future__ import annotations

import argparse
import sqlite3
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
INIT_DIR = ROOT / "init"
PROBLEMS_DIR = ROOT / "problems"


def build_in_memory_db() -> sqlite3.Connection:
    conn = sqlite3.connect(":memory:")
    conn.row_factory = sqlite3.Row
    for sql_file in sorted(INIT_DIR.glob("*.sql")):
        conn.executescript(sql_file.read_text(encoding="utf-8"))
    return conn


def run_query_file(conn: sqlite3.Connection, path: Path) -> tuple[list[str], list[tuple]]:
    sql = path.read_text(encoding="utf-8")
    cur = conn.execute(sql)
    cols = [d[0] for d in (cur.description or [])]
    rows = [tuple(r) for r in cur.fetchall()]
    return cols, rows


def format_table(cols: list[str], rows: list[tuple]) -> str:
    if not cols:
        return "(no result set)"
    widths = [max(len(str(c)), *(len(str(r[i])) for r in rows)) if rows else len(str(c)) for i, c in enumerate(cols)]
    header = " | ".join(str(c).ljust(widths[i]) for i, c in enumerate(cols))
    sep = "-+-".join("-" * w for w in widths)
    body = [" | ".join(str(r[i]).ljust(widths[i]) for i, c in enumerate(cols)) for r in rows]
    return "\n".join([header, sep, *body])


def main(argv: list[str] | None = None) -> int:
    if hasattr(sys.stdout, "reconfigure"):
        sys.stdout.reconfigure(encoding="utf-8", errors="replace")

    parser = argparse.ArgumentParser(description="Execute SQL practice files against the seeded schema")
    parser.add_argument("file", nargs="?", help="path to a .sql file")
    parser.add_argument("--all", action="store_true", help="execute and validate all .sql files in problems/")
    args = parser.parse_args(argv)

    conn = build_in_memory_db()
    targets = sorted(PROBLEMS_DIR.rglob("*.sql")) if args.all else ([Path(args.file).resolve()] if args.file else [])
    if not targets:
        parser.error("Provide a .sql file path or pass --all")

    failed = 0
    for t in targets:
        try:
            cols, rows = run_query_file(conn, t)
            print(f"✓ {t.relative_to(ROOT)} ({len(rows)} rows)")
            if not args.all:
                print(format_table(cols, rows))
        except sqlite3.Error as exc:
            failed += 1
            print(f"✗ {t}: {exc}", file=sys.stderr)

    print(f"\nSummary: {len(targets) - failed}/{len(targets)} queries executed cleanly.")
    return 1 if failed else 0


if __name__ == "__main__":
    raise SystemExit(main())
