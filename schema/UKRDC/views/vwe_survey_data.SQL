CREATE VIEW VWE_SURVEY_DATA AS
SELECT
    a.pid,
	a.sendingfacility,
	i.description AS sendingfacility_desc,
	CASE 
		WHEN K.main_unit_code IS NOT NULL
			THEN K.main_unit_code
		ELSE L.main_unit_code
		END AS main_unit_code,
	CASE 
		WHEN K.main_unit_code IS NOT NULL
			THEN M.description
		ELSE N.description
		END AS main_unit_desc,
	a.repositorycreationdate,
	h.patientid AS "NHS Number",
	g.given AS forename,
	g.family AS surname,
	f.birthtime AS dob,
	f.ethnicgroupdesc AS ethnicity,
	f.gender,
	j.postcode AS "Post Code",
	b.surveytime AS "Date Completed",
	b.enteredatcode,
	max(CASE 
			WHEN c.questiontypecode::TEXT = 'YSQ1'::TEXT
				THEN c.response
			ELSE NULL::VARCHAR
			END::TEXT) AS ysq1,
	max(CASE 
			WHEN c.questiontypecode::TEXT = 'YSQ2'::TEXT
				THEN c.response
			ELSE NULL::VARCHAR
			END::TEXT) AS ysq2,
	max(CASE 
			WHEN c.questiontypecode::TEXT = 'YSQ3'::TEXT
				THEN c.response
			ELSE NULL::VARCHAR
			END::TEXT) AS ysq3,
	max(CASE 
			WHEN c.questiontypecode::TEXT = 'YSQ4'::TEXT
				THEN c.response
			ELSE NULL::VARCHAR
			END::TEXT) AS ysq4,
	max(CASE 
			WHEN c.questiontypecode::TEXT = 'YSQ5'::TEXT
				THEN c.response
			ELSE NULL::VARCHAR
			END::TEXT) AS ysq5,
	max(CASE 
			WHEN c.questiontypecode::TEXT = 'YSQ6'::TEXT
				THEN c.response
			ELSE NULL::VARCHAR
			END::TEXT) AS ysq6,
	max(CASE 
			WHEN c.questiontypecode::TEXT = 'YSQ7'::TEXT
				THEN c.response
			ELSE NULL::VARCHAR
			END::TEXT) AS ysq7,
	max(CASE 
			WHEN c.questiontypecode::TEXT = 'YSQ8'::TEXT
				THEN c.response
			ELSE NULL::VARCHAR
			END::TEXT) AS ysq8,
	max(CASE 
			WHEN c.questiontypecode::TEXT = 'YSQ9'::TEXT
				THEN c.response
			ELSE NULL::VARCHAR
			END::TEXT) AS ysq9,
	max(CASE 
			WHEN c.questiontypecode::TEXT = 'YSQ10'::TEXT
				THEN c.response
			ELSE NULL::VARCHAR
			END::TEXT) AS ysq10,
	max(CASE 
			WHEN c.questiontypecode::TEXT = 'YSQ11'::TEXT
				THEN c.response
			ELSE NULL::VARCHAR
			END::TEXT) AS ysq11,
	max(CASE 
			WHEN c.questiontypecode::TEXT = 'YSQ12'::TEXT
				THEN c.response
			ELSE NULL::VARCHAR
			END::TEXT) AS ysq12,
	max(CASE 
			WHEN c.questiontypecode::TEXT = 'YSQ13'::TEXT
				THEN c.response
			ELSE NULL::VARCHAR
			END::TEXT) AS ysq13,
	max(CASE 
			WHEN c.questiontypecode::TEXT = 'YSQ14'::TEXT
				THEN c.response
			ELSE NULL::VARCHAR
			END::TEXT) AS ysq14,
	max(CASE 
			WHEN c.questiontypecode::TEXT = 'YSQ15'::TEXT
				THEN c.response
			ELSE NULL::VARCHAR
			END::TEXT) AS ysq15,
	max(CASE 
			WHEN c.questiontypecode::TEXT = 'YSQ16'::TEXT
				THEN c.response
			ELSE NULL::VARCHAR
			END::TEXT) AS ysq16,
	max(CASE 
			WHEN c.questiontypecode::TEXT = 'YSQ17'::TEXT
				THEN c.response
			ELSE NULL::VARCHAR
			END::TEXT) AS ysq17,
	max(CASE 
			WHEN c.questiontypecode::TEXT = 'YOHQ1'::TEXT
				THEN c.response
			ELSE NULL::VARCHAR
			END::TEXT) AS yohq1,
	max(CASE 
			WHEN c.questiontypecode::TEXT = 'YOHQ2'::TEXT
				THEN c.response
			ELSE NULL::VARCHAR
			END::TEXT) AS yohq2,
	max(CASE 
			WHEN c.questiontypecode::TEXT = 'YOHQ3'::TEXT
				THEN c.response
			ELSE NULL::VARCHAR
			END::TEXT) AS yohq3,
	max(CASE 
			WHEN c.questiontypecode::TEXT = 'YOHQ4'::TEXT
				THEN c.response
			ELSE NULL::VARCHAR
			END::TEXT) AS yohq4,
	max(CASE 
			WHEN c.questiontypecode::TEXT = 'YOHQ5'::TEXT
				THEN c.response
			ELSE NULL::VARCHAR
			END::TEXT) AS yohq5,
	max(CASE 
			WHEN c.questiontypecode::TEXT = 'MYHQ1'::TEXT
				THEN c.response
			ELSE NULL::VARCHAR
			END::TEXT) AS myhq1,
	max(CASE 
			WHEN c.questiontypecode::TEXT = 'MYHQ2'::TEXT
				THEN c.response
			ELSE NULL::VARCHAR
			END::TEXT) AS myhq2,
	max(CASE 
			WHEN c.questiontypecode::TEXT = 'MYHQ3'::TEXT
				THEN c.response
			ELSE NULL::VARCHAR
			END::TEXT) AS myhq3,
	max(CASE 
			WHEN c.questiontypecode::TEXT = 'MYHQ4'::TEXT
				THEN c.response
			ELSE NULL::VARCHAR
			END::TEXT) AS myhq4,
	max(CASE 
			WHEN c.questiontypecode::TEXT = 'MYHQ5'::TEXT
				THEN c.response
			ELSE NULL::VARCHAR
			END::TEXT) AS myhq5,
	max(CASE 
			WHEN c.questiontypecode::TEXT = 'MYHQ6'::TEXT
				THEN c.response
			ELSE NULL::VARCHAR
			END::TEXT) AS myhq6,
	max(CASE 
			WHEN c.questiontypecode::TEXT = 'MYHQ7'::TEXT
				THEN c.response
			ELSE NULL::VARCHAR
			END::TEXT) AS myhq7,
	max(CASE 
			WHEN c.questiontypecode::TEXT = 'MYHQ8'::TEXT
				THEN c.response
			ELSE NULL::VARCHAR
			END::TEXT) AS myhq8,
	max(CASE 
			WHEN c.questiontypecode::TEXT = 'MYHQ9'::TEXT
				THEN c.response
			ELSE NULL::VARCHAR
			END::TEXT) AS myhq9,
	max(CASE 
			WHEN c.questiontypecode::TEXT = 'MYHQ10'::TEXT
				THEN c.response
			ELSE NULL::VARCHAR
			END::TEXT) AS myhq10,
	max(CASE 
			WHEN c.questiontypecode::TEXT = 'MYHQ11'::TEXT
				THEN c.response
			ELSE NULL::VARCHAR
			END::TEXT) AS myhq11,
	max(CASE 
			WHEN c.questiontypecode::TEXT = 'MYHQ12'::TEXT
				THEN c.response
			ELSE NULL::VARCHAR
			END::TEXT) AS myhq12,
	max(CASE 
			WHEN c.questiontypecode::TEXT = 'MYHQ13'::TEXT
				THEN c.response
			ELSE NULL::VARCHAR
			END::TEXT) AS myhq13,
	max(CASE 
			WHEN d.scoretypecode::TEXT = '925431000000109'::TEXT
				THEN d.scorevalue
			ELSE NULL::VARCHAR
			END::TEXT) AS pam_13_score,
	max(CASE 
			WHEN e.leveltypecode::TEXT = '962851000000103'::TEXT
				THEN e.levelvalue
			ELSE NULL::VARCHAR
			END::TEXT) AS pam_13_level,
	max(CASE 
			WHEN c.questiontypecode::TEXT = 'YHS1'::TEXT
				THEN c.response
			ELSE NULL::VARCHAR
			END::TEXT) AS yhs1,
	max(CASE 
			WHEN c.questiontypecode::TEXT = 'YHS2'::TEXT
				THEN c.response
			ELSE NULL::VARCHAR
			END::TEXT) AS yhs2,
	max(CASE 
			WHEN c.questiontypecode::TEXT = 'YHS3'::TEXT
				THEN c.response
			ELSE NULL::VARCHAR
			END::TEXT) AS yhs3,
	max(CASE 
			WHEN c.questiontypecode::TEXT = 'YHS4'::TEXT
				THEN c.response
			ELSE NULL::VARCHAR
			END::TEXT) AS yhs4,
	max(CASE 
			WHEN c.questiontypecode::TEXT = 'YHS5'::TEXT
				THEN c.response
			ELSE NULL::VARCHAR
			END::TEXT) AS yhs5,
	max(CASE 
			WHEN c.questiontypecode::TEXT = 'YHS6'::TEXT
				THEN c.response
			ELSE NULL::VARCHAR
			END::TEXT) AS yhs6,
	CASE
		WHEN PM_YHS.PID IS NOT NULL
			THEN 'YES'
		ELSE NULL
	END AS YHS,
	CASE
		WHEN PM_SHD.PID IS NOT NULL
			THEN 'YES'
		ELSE NULL
	END AS SHD,
	CASE
		WHEN PM_LCC.PID IS NOT NULL
			THEN 'YES'
		ELSE NULL
	END AS LCC
FROM patientrecord a
LEFT JOIN survey b ON a.pid::TEXT = b.pid::TEXT
LEFT JOIN question c ON b.id::TEXT = c.surveyid::TEXT
LEFT JOIN score d ON b.id::TEXT = d.surveyid::TEXT
LEFT JOIN LEVEL e ON b.id::TEXT = e.surveyid::TEXT
LEFT JOIN patient f ON a.pid::TEXT = f.pid::TEXT
LEFT JOIN name g ON a.pid::TEXT = g.pid::TEXT
	AND g.nameuse::TEXT = 'L'::TEXT
LEFT JOIN patientnumber h ON a.pid::TEXT = h.pid::TEXT
LEFT JOIN code_list i ON a.sendingfacility::TEXT = i.code::TEXT
	AND i.coding_standard::TEXT = 'RR1+'::TEXT
LEFT JOIN address j ON a.pid::TEXT = j.pid::TEXT
LEFT JOIN SATELLITE_MAP K ON A.sendingfacility = K.satellite_code
LEFT JOIN SATELLITE_MAP L ON A.sendingfacility = L.main_unit_code
LEFT JOIN CODE_LIST M ON K.main_unit_code = M.Code
	AND M.coding_standard = 'RR1+'
LEFT JOIN CODE_LIST N ON L.main_unit_code = N.Code
	AND N.coding_standard = 'RR1+'
LEFT JOIN PROGRAMMEMBERSHIP PM_YHS ON a.PID = PM_YHS.pid and PM_YHS.programname = 'YHS'
LEFT JOIN PROGRAMMEMBERSHIP PM_SHD ON a.PID = PM_SHD.pid and PM_SHD.programname = 'SHD'
LEFT JOIN PROGRAMMEMBERSHIP PM_LCC ON a.PID = PM_LCC.pid and PM_LCC.programname = 'LCC'
WHERE a.sendingextract = 'SURVEY'
GROUP BY a.pid,
	a.sendingfacility,
	i.description,
	K.main_unit_code,
	L.main_unit_code,
	M.description,
	N.description,
	a.repositorycreationdate,
	g.given,
	g.family,
	h.patientid,
	f.birthtime,
	f.gender,
	f.ethnicgroupdesc,
	j.postcode,
	b.surveytime,
	b.enteredatcode,
	PM_YHS.pid,
	PM_SHD.pid,
	PM_LCC.pid
ORDER BY a.repositoryupdatedate,
	a.pid;

GRANT ALL PRIVILEGES ON "extract".vwe_survey_data TO ukrdc;
