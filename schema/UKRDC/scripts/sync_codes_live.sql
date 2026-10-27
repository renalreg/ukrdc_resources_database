-- Clear and reload registry lookup codes on live-db.
-- Run by sync_codes.sh with --single-transaction and ON_ERROR_STOP=1,
-- so any error rolls back everything.
-- :tmp_sql is the plain-SQL data file made by pg_restore.
--
-- live-db has no fk_facilitycode, so no constraint handling is needed here.

SET LOCAL lock_timeout = '10s';

DELETE FROM extract.code_exclusion;
DELETE FROM extract.ukrdc_ods_gp_codes;
DELETE FROM extract.coding_standards;
DELETE FROM extract.code_list;
DELETE FROM extract.code_map;
DELETE FROM extract.modality_codes;
DELETE FROM extract.rr_codes;
DELETE FROM extract.rr_data_definition;
DELETE FROM extract.locations;

\i :tmp_sql
