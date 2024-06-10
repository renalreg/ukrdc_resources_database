CREATE OR REPLACE VIEW vwe_pv_members AS

SELECT DISTINCT
	pr.ukrdcid
FROM
	programmembership pm
INNER JOIN patientrecord pr ON pm.pid = pr.pid
WHERE
	pm.programname LIKE 'PV.%' AND
	pm.totime IS NULL;
	
GRANT ALL PRIVILEGES ON "extract".vwe_pv_members TO ukrdc;