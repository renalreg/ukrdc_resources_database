#!/bin/bash
# Sync registry lookup codes into the UKRDC3 staging DB.
# Source: https://github.com/renalreg/registry-codes  (release asset: registry_codes.dump)
set -eo pipefail

# ===========================
# Configuration
# ===========================

# Sentry cron monitoring update if needed
SENTRY_INGEST=""
SENTRY_CRONS=""

DB_NAME=""
DB_USER=""
DB_PASSWORD=""
DB_HOST=""
DB_PORT=""

# Paths
TMP_DUMP="/tmp/registry_codes.dump"
TMP_SQL="/tmp/registry_codes.data.sql"
LOG_FILE="/var/log/registry_codes_sync_codes.log"

export PGPASSWORD="$DB_PASSWORD"

# One check-in id, generated up front, reused for every ping this run.
RID=$(uuidgen)

# ===========================
# Sentry: start + trap
# ===========================

curl -sS -m 10 "${SENTRY_CRONS}?status=in_progress&check_in_id=${RID}" >/dev/null || true

# On every exit path: clean temp files, report terminal status, preserve exit code.
trap '
  exit_code=$?
  status=$( [ "$exit_code" -eq 0 ] && echo ok || echo error )
  rm -f "$TMP_DUMP" "$TMP_SQL"
  curl -sS -m 10 "${SENTRY_CRONS}?status=${status}&check_in_id=${RID}" >/dev/null || true
  exit "$exit_code"
' EXIT

# ===========================
# Work
# ===========================

{
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] Starting registry-codes-sync"

  echo "Downloading latest lookup codes"
  curl -L -f -o "$TMP_DUMP" \
    https://github.com/renalreg/registry-codes/releases/latest/download/registry_codes.dump

  # Convert the custom-format dump to a plain-SQL data script FIRST, so a bad or
  # short dump fails here (set -e) BEFORE we touch the live tables.
  echo "Preparing restore data"
  pg_restore --data-only --schema=extract \
    --table=code_exclusion \
    --table=ukrdc_ods_gp_codes \
    --table=code_list \
    --table=code_map \
    --table=coding_standards \
    --table=facility_new \
    --table=modality_codes \
    --table=rr_codes \
    --table=rr_data_definition \
    -f "$TMP_SQL" "$TMP_DUMP"

  # Clear + reload as ONE transaction. --single-transaction wraps the whole input
  # in BEGIN/COMMIT; ON_ERROR_STOP=1 makes any error abort and roll the lot back.
  # Readers keep seeing the old rows right up to COMMIT and never an empty table;
  # a failed restore leaves the previous data intact instead of empty/partial.
  echo "Clearing and restoring lookup codes (atomic)"
  psql -v ON_ERROR_STOP=1 --single-transaction \
    -U "$DB_USER" -h "$DB_HOST" -p "$DB_PORT" -d "$DB_NAME" <<SQL
DELETE FROM extract.code_exclusion;
DELETE FROM extract.ukrdc_ods_gp_codes;
DELETE FROM extract.facility_new;
DELETE FROM extract.coding_standards;
DELETE FROM extract.code_list;
DELETE FROM extract.code_map;
DELETE FROM extract.modality_codes;
DELETE FROM extract.rr_codes;
DELETE FROM extract.rr_data_definition;
\i $TMP_SQL
SQL

  echo "Refreshing materialized view"
  psql -v ON_ERROR_STOP=1 \
    -U "$DB_USER" -h "$DB_HOST" -p "$DB_PORT" -d "$DB_NAME" \
    -c "REFRESH MATERIALIZED VIEW extract.vwe_facility_relationship;"

  echo "Registry codes sync complete"
} >>"$LOG_FILE" 2>&1
