CREATE OR REPLACE VIEW vwe_pkb_test_patients AS

SELECT DISTINCT
    pid
FROM
    patientnumber
WHERE
    numbertype = 'NI' AND
    organization IN ('NHS', 'CHI', 'HSC') AND
    patientid in (
    'XXX'
    );

GRANT ALL PRIVILEGES ON "extract".vwe_pkb_test_patients TO ukrdc;