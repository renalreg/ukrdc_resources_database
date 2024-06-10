CREATE OR REPLACE VIEW vwe_extract_pkb_new_test AS

SELECT DISTINCT
    ukrdcid
FROM patientrecord pr
WHERE
    pr.pid in (SELECT pid from vwe_pkb_test_patients)
;

GRANT ALL PRIVILEGES ON "extract".vwe_extract_pkb_new_test TO ukrdc;