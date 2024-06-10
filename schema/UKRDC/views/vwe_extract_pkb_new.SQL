CREATE OR REPLACE VIEW vwe_extract_pkb_new AS

SELECT DISTINCT
    pr.ukrdcid
FROM
    patientrecord pr
WHERE
    -- No PKB Membership
    pr.ukrdcid NOT IN (SELECT ukrdcid from vwe_pkb_members)
    AND
    (
        pr.ukrdcid IN (SELECT ukrdcid from vwe_pv_members)
        OR
        pr.ukrdcid IN (SELECT ukrdcid from patientrecord where sendingextract = 'PV')
    )
    AND
    -- Not Dead
    pr.ukrdcid NOT IN
    (
    SELECT
        ukrdcid
    FROM
        patientrecord A
    INNER JOIN patient B ON A.pid = B.pid
    WHERE
        B.deathtime IS NOT NULL
    );

GRANT ALL PRIVILEGES ON "extract".vwe_extract_pkb_new TO ukrdc;