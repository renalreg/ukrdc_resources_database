CREATE OR REPLACE VIEW vwe_extract_pkb_deceased AS

SELECT DISTINCT
    pr.ukrdcid
FROM
    patientrecord pr
INNER JOIN vwe_pkb_members ON pr.ukrdcid = vwe_pkb_members.ukrdcid
WHERE
    pr.ukrdcid
    IN
    (
    SELECT
        ukrdcid
    FROM
        patientrecord A
    INNER JOIN patient B ON A.pid = B.pid
    WHERE
        B.deathtime IS NOT NULL
    );

GRANT ALL PRIVILEGES ON "extract".vwe_extract_pkb_deceased TO ukrdc;