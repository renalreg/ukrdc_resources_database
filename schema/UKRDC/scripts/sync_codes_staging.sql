-- Clear and reload registry lookup codes on staging-db.
-- Run by sync_codes.sh with --single-transaction and ON_ERROR_STOP=1,
-- so any error rolls back everything.
-- :tmp_sql is the plain-SQL data file made by pg_restore.
--
-- facility is not synced but has facility_facilitycode_facilitycodestd_fkey to code_list
-- (ON DELETE RESTRICT), which blocks emptying code_list. Drop it inside the
-- transaction and re-add it after the reload. Re-adding checks every facility
-- row, so a release missing a code still in use fails and rolls back.

SET LOCAL lock_timeout = '10s';
ALTER TABLE extract.facility DROP CONSTRAINT facility_facilitycode_facilitycodestd_fkey;

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

ALTER TABLE extract.facility ADD CONSTRAINT facility_facilitycode_facilitycodestd_fkey
  FOREIGN KEY (facilitycode, facilitycodestd)
  REFERENCES extract.code_list (code, coding_standard)
  ON UPDATE CASCADE ON DELETE RESTRICT;
