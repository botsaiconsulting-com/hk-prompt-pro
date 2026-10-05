#!/usr/bin/env bash
# Loads the training databases. Runs INSIDE the SQL Server container, as the administrator:
#
#   docker compose exec sql bash /db/load.sh                          # all three databases + read-only login
#   docker compose exec sql bash /db/load.sh company surat HK_SURAT_SCRATCH   # one company's objects into a named database
#
# On a SQL Server Express training VM without Docker, run the same files in the same order with sqlcmd
# (see db/README.md).
set -euo pipefail
SQLCMD=/opt/mssql-tools18/bin/sqlcmd
[ -x "$SQLCMD" ] || SQLCMD=/opt/mssql-tools/bin/sqlcmd
: "${MSSQL_SA_PASSWORD:?MSSQL_SA_PASSWORD is not set}"

run() { "$SQLCMD" -S localhost -U sa -P "$MSSQL_SA_PASSWORD" -C -b "$@"; }

# SQL Server takes a little while to accept logins after the container starts.
for i in $(seq 1 60); do
  if run -Q "SELECT 1" >/dev/null 2>&1; then break; fi
  [ "$i" -eq 60 ] && { echo "SQL Server did not accept logins within 2 minutes." >&2; exit 1; }
  sleep 2
done

load_company() {
  local dir=$1 db=$2
  run -Q "IF DB_ID('$db') IS NULL CREATE DATABASE [$db];"
  for kind in tables views procedures seed; do
    for f in /db/company-"$dir"/"$kind"/*.sql; do
      echo "  $db <- ${f#/db/}"
      run -d "$db" -i "$f"
    done
  done
}

if [ "${1:-}" = "company" ]; then
  load_company "$2" "$3"
  exit 0
fi

: "${HK_RO_PASSWORD:?HK_RO_PASSWORD is not set}"
echo "Rebuilding HK_SURAT, HK_INDIA_A and HK_INDIA_B"
run -i /db/00_create_databases.sql
load_company surat HK_SURAT
load_company india-a HK_INDIA_A
load_company india-b HK_INDIA_B
echo "Creating the read-only login hk_training_ro"
run -v RO_PASSWORD="$HK_RO_PASSWORD" -i /db/security/create_readonly_login.sql
echo "Done."
