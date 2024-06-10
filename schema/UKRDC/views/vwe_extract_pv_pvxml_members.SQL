CREATE VIEW vwe_extract_pv_pvxml_members AS
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
    -- Exclude PV Data
    pr.sendingfacility NOT IN ('PV', 'NHST');

GRANT ALL PRIVILEGES ON "extract".vwe_extract_pv_pvxml_members TO ukrdc;
