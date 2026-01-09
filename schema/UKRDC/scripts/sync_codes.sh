#!/bin/bash
set -e

echo "Downloading latest lookup codes"
curl -L -f -o /tmp/registry_codes.dump https://github.com/renalreg/registry-codes/releases/latest/download/registry_codes.dump

echo "Clearing existing lookup data"
psql -U postgres -d UKRDC <<'SQL'
DELETE FROM extract.code_exclusion;
DELETE FROM extract.code_map;
DELETE FROM extract.facility_new;
DELETE FROM extract.modality_codes;
DELETE FROM extract.rr_codes;
DELETE FROM extract.rr_data_definition;
DELETE FROM extract.ukrdc_ods_gp_codes;
SQL

echo "Restoring latest lookup codes"
pg_restore --dbname=UKRDC \
--user=postgres \
--schema=extract \
--data-only \
--table=code_exclusion \
--table=code_map \
--table=facility_new \
--table=modality_codes \
--table=rr_codes \
--table=rr_data_definition \
--table=ukrdc_ods_gp_codes \
--verbose /tmp/registry_codes.dump

rm /tmp/registry_codes.dump

echo "Refreshing materialized view"
psql -U postgres -d UKRDC -c "REFRESH MATERIALIZED VIEW extract.vwe_facility_relationship;"

echo "Sync complete"