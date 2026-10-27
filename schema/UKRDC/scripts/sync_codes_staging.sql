-- Clear and reload registry lookup codes on staging-db.
-- Run by sync_codes.sh with --single-transaction and ON_ERROR_STOP=1,
-- so any error rolls back everything.
-- :tmp_sql is the plain-SQL data file made by pg_restore.
--
-- facility_new is not synced but has fk_facilitycode to code_list
-- (ON DELETE RESTRICT), which blocks emptying code_list. Drop it inside the
-- transaction and re-add it after the reload. Re-adding checks every facility_new
-- row, so a release missing a code still in use fails and rolls back.

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
DELETE FROM extract.locations;

\i :tmp_sql

ALTER TABLE extract.facility_new ADD CONSTRAINT fk_facilitycode
  FOREIGN KEY (facilitycode, facilitycodestd)
  REFERENCES extract.code_list (code, coding_standard)
  ON UPDATE CASCADE ON DELETE RESTRICT;
