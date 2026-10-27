#!/bin/bash
# Sync registry lookup codes into the UKRDC3 DB.
# Source: https://github.com/renalreg/registry-codes  (release asset: registry_codes.dump)
# Settings come from .env next to this script (see .env_sample).
# The clear + reload SQL is sync_codes_<ENVIRONMENT>.sql next to this script.
set -eo pipefail

# ===========================
# Configuration
# ===========================
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ENV_FILE="$SCRIPT_DIR/.env"

if [ ! -f "$ENV_FILE" ]; then
  echo "Missing $ENV_FILE" >&2
  exit 1
fi

# set -a exports every variable read from .env, set +a stops that again.
set -a
. "$ENV_FILE"
set +a

# Stop early with a clear message if any required setting is empty.
: "${ENVIRONMENT:?ENVIRONMENT not set in .env}"
: "${DB_NAME:?DB_NAME not set in .env}"
: "${DB_USER:?DB_USER not set in .env}"
: "${DB_PASSWORD:?DB_PASSWORD not set in .env}"
: "${DB_HOST:?DB_HOST not set in .env}"
: "${DB_PORT:?DB_PORT not set in .env}"
: "${RELEASE_URL:?RELEASE_URL not set in .env}"
: "${TMP_DUMP:?TMP_DUMP not set in .env}"
: "${TMP_SQL:?TMP_SQL not set in .env}"
: "${LOG_FILE:?LOG_FILE not set in .env}"

# Pick the SQL for this environment. staging-db has fk_facilitycode, live-db does not.
case "$ENVIRONMENT" in
staging | live)
  SQL_FILE="$SCRIPT_DIR/sync_codes_${ENVIRONMENT}.sql"
  ;;
*)
  echo "ENVIRONMENT must be staging or live, got: $ENVIRONMENT" >&2
  exit 1
  ;;
esac

if [ ! -f "$SQL_FILE" ]; then
  echo "Missing $SQL_FILE" >&2
  exit 1
fi

export PGPASSWORD="$DB_PASSWORD"

# ===========================
# Sentry: start + trap
# ===========================
: "${SENTRY_CRONS:?SENTRY_CRONS not set in .env}"

# One check-in ID for both pings, so Sentry pairs start and finish into one run.
RID=$(cat /proc/sys/kernel/random/uuid)

# On every exit path: clean temp files, report terminal status, preserve exit code.
trap '
  exit_code=$?
  status=$( [ "$exit_code" -eq 0 ] && echo ok || echo error )
  rm -f "$TMP_DUMP" "$TMP_SQL"
  curl -sS -m 10 "${SENTRY_CRONS}?status=${status}&environment=${ENVIRONMENT}&check_in_id=${RID}" >/dev/null || true
  exit "$exit_code"
' EXIT

curl -sS -m 10 "${SENTRY_CRONS}?status=in_progress&environment=${ENVIRONMENT}&check_in_id=${RID}" >/dev/null || true

# ===========================
# Work
# ===========================

{
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] Starting registry-codes-sync ($ENVIRONMENT)"

  echo "Downloading latest lookup codes"
  curl -L -f -o "$TMP_DUMP" "$RELEASE_URL"

  # Convert the custom-format dump to a plain-SQL data script FIRST, so a bad or
  # short dump fails here (set -e) BEFORE we touch the tables.
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
    --table=locations \
    -f "$TMP_SQL" "$TMP_DUMP"

  # Clear + reload as ONE transaction. --single-transaction wraps the whole file
  # in BEGIN/COMMIT; ON_ERROR_STOP=1 makes any error abort and roll the lot back.
  # Readers keep seeing the old rows right up to COMMIT and never an empty table;
  # a failed restore leaves the previous data intact instead of empty/partial.
  # tmp_sql passes the pg_restore data file path into the SQL file.
  echo "Clearing and restoring lookup codes (atomic, $(basename "$SQL_FILE"))"
  psql -v ON_ERROR_STOP=1 --single-transaction \
    -v tmp_sql="$TMP_SQL" \
    -U "$DB_USER" -h "$DB_HOST" -p "$DB_PORT" -d "$DB_NAME" \
    -f "$SQL_FILE"

  echo "Refreshing materialized view"
  psql -v ON_ERROR_STOP=1 \
    -U "$DB_USER" -h "$DB_HOST" -p "$DB_PORT" -d "$DB_NAME" \
    -c "REFRESH MATERIALIZED VIEW extract.vwe_facility_relationship;"

  echo "Registry codes sync complete"
} >>"$LOG_FILE" 2>&1
