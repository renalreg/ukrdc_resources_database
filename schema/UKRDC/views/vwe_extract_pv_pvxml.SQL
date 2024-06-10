CREATE OR REPLACE VIEW "extract".vwe_extract_pv_pvxml AS
SELECT
    pr.pid
FROM
    patientrecord pr
-- Check an open Program Membership Exists
INNER JOIN vwe_pv_members ON pr.ukrdcid = vwe_pv_members.ukrdcid
WHERE
    -- Check Extract Type
    pr.sendingextract IN ('PV', 'UKRDC')
    AND
    -- Exclude Certain Facilities
    pr.sendingfacility NOT IN ('PV', 'NHSBT', 'TRACING')
    AND
    -- Check Patient Record has been updated since last extract run
    pr.repositoryupdatedate > (SELECT eventdate from eventcontrol WHERE eventtype = 'PVEXTRACT');

GRANT ALL PRIVILEGES ON "extract".vwe_extract_pv_pvxml TO ukrdc;
