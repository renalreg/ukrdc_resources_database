-- Data Repo version 1.6.13
-- JTrace version 1.3.8
-- 28/01/2020

-- Diagnosis

ALTER TABLE extract.diagnosis ADD COLUMN enteredatcode character varying(100);
ALTER TABLE extract.diagnosis ADD COLUMN enteredatcodestd character varying(100);
ALTER TABLE extract.diagnosis ADD COLUMN enteredatdesc character varying(100);
ALTER TABLE extract.diagnosis ADD COLUMN encounternumber character varying(100);
ALTER TABLE extract.diagnosis ADD COLUMN verificationstatus character varying(100);

-- Medication

ALTER TABLE extract.medication ADD COLUMN encounternumber character varying(100);
ALTER TABLE extract.medication ALTER COLUMN routecode TYPE character varying (10);

-- Patient Number

CREATE INDEX patientnumber_patientid ON extract.patientnumber (patientid);

-- Satellite Map
\c UKRDC3

ALTER TABLE extract.satellite_map
  OWNER TO ukrdc;