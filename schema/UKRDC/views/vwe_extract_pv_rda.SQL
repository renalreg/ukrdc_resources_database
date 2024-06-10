CREATE VIEW "extract".vwe_extract_pv_rda AS
SELECT
    pr.pid
FROM
    patientrecord pr
-- Check an open Program Membership Exists
INNER JOIN vwe_pv_members ON pr.ukrdcid = vwe_pv_members.ukrdcid
WHERE
    -- Check Extract Type
    pr.sendingextract IN ('SURVEY')
    AND
    -- Check Patient Record has been updated since last extract run
    pr.repositoryupdatedate > (SELECT eventdate from eventcontrol WHERE eventtype = 'PVSURVEYEXTRACT');
GRANT ALL PRIVILEGES ON "extract".vwe_extract_pv_rda TO ukrdc;
    
