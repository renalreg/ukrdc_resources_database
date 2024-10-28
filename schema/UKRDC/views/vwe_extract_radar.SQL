CREATE VIEW vwe_extract_radar AS
SELECT
    pr.pid
FROM
    patientrecord pr
WHERE
    (
        (
        -- Check Extract Type
        pr.sendingextract IN ('PV', 'UKRDC')
        AND
        -- Check Patient Record has been updated since last extract run
        pr.repositoryupdatedate > (SELECT eventdate from eventcontrol WHERE eventtype = 'RADAREXTRACT')
        )
        OR
        (
        -- Check Extract Type
        pr.sendingextract = 'RADAR'
        AND
        -- Check Patient Record is a new RADAR Program Membership
        pr.repositorycreationdate > (SELECT eventdate from eventcontrol WHERE eventtype = 'RADAREXTRACT')
        )
    )
    AND
    -- Check an open Program Membership Exists
    pr.ukrdcid in
    (
        SELECT
            pr2.ukrdcid
        FROM
            programmembership pm
        INNER JOIN patientrecord pr2 ON pm.pid = pr2.pid
        WHERE
            pm.programname IN ('RADAR', 'NURTURE') AND
            pm.totime IS NULL
    )
    AND
    NOT EXISTS (
        SELECT 1
        FROM programmembership pm2
        INNER JOIN patientrecord pr3 ON pm2.pid = pr3.pid
        WHERE
            pr3.ukrdcid = pr.ukrdcid
            AND pm2.programname IN ('RADAR.COHORT.NOCON', 'RADAR.COHORT.CONS_WTDWN')
    );

GRANT ALL PRIVILEGES ON "extract".vwe_extract_radar TO ukrdc;
