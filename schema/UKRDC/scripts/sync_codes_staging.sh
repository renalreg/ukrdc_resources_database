#!/bin/bash
# Sync registry lookup codes into the UKRDC3 staging DB.
# Source: https://github.com/renalreg/registry-codes  (release asset: registry_codes.dump)
set -eo pipefail

# ===========================
# Configuration
# ===========================
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

# ===========================
# Sentry: start + trap
# ===========================

# Uncomment and put sentry valuse for sentry monitoring
#  if [[ $(hostname) == *live* ]]; then
#    ENVIRONMENT="live"
#  else
#     ENVIRONMENT="staging"
# fi
# SENTRY_INGEST="****"
# SENTRY_CRONS="${SENTRY_INGEST}/api/****/"
# RID=$(uuidgen)
# curl -sS -m 10 "${SENTRY_CRONS}?status=in_progress&environment=${ENVIRONMENT}&check_in_id=${RID}" >/dev/null || true
#
# # On every exit path: clean temp files, report terminal status, preserve exit code.
# trap '
#   exit_code=$?
#   status=$( [ "$exit_code" -eq 0 ] && echo ok || echo error )
#   rm -f "$TMP_DUMP" "$TMP_SQL"
#   curl -sS -m 10 "${SENTRY_CRONS}?status=${status}&environment=${ENVIRONMENT}&check_in_id=${RID}" >/dev/null || true
#   exit "$exit_code"
# ' EXIT

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
    --table=modality_codes \
    --table=rr_codes \
    --table=rr_data_definition \
    -f "$TMP_SQL" "$TMP_DUMP"

  # Clear + reload as ONE transaction. --single-transaction wraps the whole input
  # in BEGIN/COMMIT; ON_ERROR_STOP=1 makes any error abort and roll the lot back.
  # Readers keep seeing the old rows right up to COMMIT and never an empty table;
  # a failed restore leaves the previous data intact instead of empty/partial.
  #
  # STAGING ONLY: facility_new is not synced but has fk_facilitycode to code_list
  # (ON DELETE RESTRICT), which blocks emptying code_list. Drop it inside the
  # transaction and re-add it after the reload. Re-adding checks every facility_new
  # row, so a release missing a code still in use fails and rolls back.
  # live-db has no fk_facilitycode, so this version fails there at DROP CONSTRAINT.
  echo "Clearing and restoring lookup codes (atomic)"
  psql -v ON_ERROR_STOP=1 --single-transaction \
    -U "$DB_USER" -h "$DB_HOST" -p "$DB_PORT" -d "$DB_NAME" <<SQL
SET LOCAL lock_timeout = '10s';
ALTER TABLE extract.facility_new DROP CONSTRAINT fk_facilitycode;
DELETE FROM extract.code_exclusion;
DELETE FROM extract.ukrdc_ods_gp_codes;
DELETE FROM extract.coding_standards;
DELETE FROM extract.code_list;
DELETE FROM extract.code_map;
DELETE FROM extract.modality_codes;
DELETE FROM extract.rr_codes;
DELETE FROM extract.rr_data_definition;
\i $TMP_SQL
ALTER TABLE extract.facility_new ADD CONSTRAINT fk_facilitycode
  FOREIGN KEY (facilitycode, facilitycodestd)
  REFERENCES extract.code_list (code, coding_standard)
  ON UPDATE CASCADE ON DELETE RESTRICT;
SQL

  echo "Refreshing materialized view"
  psql -v ON_ERROR_STOP=1 \
    -U "$DB_USER" -h "$DB_HOST" -p "$DB_PORT" -d "$DB_NAME" \
    -c "REFRESH MATERIALIZED VIEW extract.vwe_facility_relationship;"

  echo "Registry codes sync complete"
} >>"$LOG_FILE" 2>&1
