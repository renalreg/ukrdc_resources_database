CREATE OR REPLACE VIEW vwe_extract_pkb_updates AS

SELECT
    patientrecord.pid,
    NULL::text AS id,
    'ADT_A28'::text AS msg_type
FROM patientrecord
-- Require PKB Membership
INNER JOIN vwe_pkb_members ON patientrecord.ukrdcid = vwe_pkb_members.ukrdcid
INNER JOIN facility ON patientrecord.sendingfacility = facility.code
WHERE
    -- Require that Unit is Enabled
    facility.pkb_out = true
    AND
    patientrecord.sendingextract IN ('PV', 'UKRDC')
    AND
    (
        (
        patientrecord.update_date IS NULL AND
        patientrecord.creation_date > ( SELECT eventcontrol.eventdate
                                        FROM eventcontrol
                                        WHERE eventcontrol.eventtype = 'PKBEXTRACT'::bpchar)
        ) OR
--        (
--        patientrecord.update_date IS NOT NULL AND
--        patientrecord.update_date > (   SELECT eventcontrol.eventdate
--                                       FROM eventcontrol
--                                        WHERE eventcontrol.eventtype = 'PKBEXTRACT'::bpchar)
--        ) OR
        (EXISTS (   SELECT medication.id
                    FROM medication
                    WHERE medication.pid::text = patientrecord.pid::text AND
                    (
                        (
                            medication.update_date IS NULL AND medication.creation_date > ( SELECT eventcontrol.eventdate
                                                                                            FROM eventcontrol
                                                                                            WHERE eventcontrol.eventtype = 'PKBEXTRACT'::bpchar)
                        ) OR 
                        (
                            medication.update_date IS NOT NULL AND medication.update_date > (   SELECT eventcontrol.eventdate
                                                                                                FROM eventcontrol
                                                                                                WHERE eventcontrol.eventtype = 'PKBEXTRACT'::bpchar)
                        )
                    )
                )
        ) OR
        (EXISTS (   SELECT diagnosis.id
                FROM diagnosis
                WHERE diagnosis.pid::text = patientrecord.pid::text AND
                (
                    (
                        diagnosis.update_date IS NULL AND diagnosis.creation_date > (   SELECT eventcontrol.eventdate
                                                                                        FROM eventcontrol
                                                                                        WHERE eventcontrol.eventtype = 'PKBEXTRACT'::bpchar)
                    ) OR
                    (
                        diagnosis.update_date IS NOT NULL AND diagnosis.update_date > ( SELECT eventcontrol.eventdate
                                                                                        FROM eventcontrol
                                                                                        WHERE eventcontrol.eventtype = 'PKBEXTRACT'::bpchar)
                    )
                )
            )
        ) OR
        (EXISTS (   SELECT renaldiagnosis.pid
                FROM renaldiagnosis
                WHERE renaldiagnosis.pid::text = patientrecord.pid::text AND
                (
                    (
                        renaldiagnosis.update_date IS NULL AND renaldiagnosis.creation_date > (   SELECT eventcontrol.eventdate
                                                                                        FROM eventcontrol
                                                                                        WHERE eventcontrol.eventtype = 'PKBEXTRACT'::bpchar)
                    ) OR
                    (
                        renaldiagnosis.update_date IS NOT NULL AND renaldiagnosis.update_date > ( SELECT eventcontrol.eventdate
                                                                                        FROM eventcontrol
                                                                                        WHERE eventcontrol.eventtype = 'PKBEXTRACT'::bpchar)
                    )
                )
            )
        )
    )

UNION ALL

SELECT
    patientrecord.pid,
    NULL::text AS id,
    'MDM_T02_CP'::text AS msg_type
FROM patientrecord
LEFT JOIN pvdata ON patientrecord.pid = pvdata.id
-- Require PKB Membership
INNER JOIN vwe_pkb_members ON patientrecord.ukrdcid = vwe_pkb_members.ukrdcid
INNER JOIN facility ON patientrecord.sendingfacility = facility.code
WHERE
    -- Require that Unit is Enabled
    facility.pkb_out = true
    AND
    patientrecord.sendingextract IN ('PV', 'UKRDC')
    AND
    (
        (
        pvdata.update_date IS NULL AND
        pvdata.creation_date > (    SELECT eventcontrol.eventdate
                                    FROM eventcontrol
                                    WHERE eventcontrol.eventtype = 'PKBEXTRACT'::bpchar)
        ) OR
        (
            pvdata.update_date IS NOT NULL AND
            pvdata.update_date > (      SELECT eventcontrol.eventdate
                                        FROM eventcontrol
                                        WHERE eventcontrol.eventtype = 'PKBEXTRACT'::bpchar)
        ) OR
        (EXISTS (   SELECT diagnosis.id
                FROM diagnosis
                WHERE diagnosis.pid::text = patientrecord.pid::text AND
                (
                    (
                        diagnosis.update_date IS NULL AND diagnosis.creation_date > (   SELECT eventcontrol.eventdate
                                                                                        FROM eventcontrol
                                                                                        WHERE eventcontrol.eventtype = 'PKBEXTRACT'::bpchar)
                    ) OR
                    (
                        diagnosis.update_date IS NOT NULL AND diagnosis.update_date > ( SELECT eventcontrol.eventdate
                                                                                        FROM eventcontrol
                                                                                        WHERE eventcontrol.eventtype = 'PKBEXTRACT'::bpchar)
                    )
                )
            )
        ) OR
        (EXISTS (   SELECT renaldiagnosis.pid
                FROM renaldiagnosis
                WHERE renaldiagnosis.pid::text = patientrecord.pid::text AND
                (
                    (
                        renaldiagnosis.update_date IS NULL AND renaldiagnosis.creation_date > (   SELECT eventcontrol.eventdate
                                                                                        FROM eventcontrol
                                                                                        WHERE eventcontrol.eventtype = 'PKBEXTRACT'::bpchar)
                    ) OR
                    (
                        renaldiagnosis.update_date IS NOT NULL AND renaldiagnosis.update_date > ( SELECT eventcontrol.eventdate
                                                                                        FROM eventcontrol
                                                                                        WHERE eventcontrol.eventtype = 'PKBEXTRACT'::bpchar)
                    )
                )
            )
        ) OR
        (EXISTS (   SELECT A.id
                FROM pvdata A
                INNER JOIN patientrecord B ON A.id = B.pid
                WHERE
                    B.ukrdcid = patientrecord.ukrdcid AND
                    B.sendingfacility = 'NHSBT' AND
                (
                    (
                        A.update_date IS NULL AND A.creation_date > (   SELECT eventcontrol.eventdate
                                                                                        FROM eventcontrol
                                                                                        WHERE eventcontrol.eventtype = 'PKBEXTRACT'::bpchar)
                    ) OR
                    (
                        A.update_date IS NOT NULL AND A.update_date > ( SELECT eventcontrol.eventdate
                                                                                        FROM eventcontrol
                                                                                        WHERE eventcontrol.eventtype = 'PKBEXTRACT'::bpchar)
                    )
                )
            )
        ) 
    )

UNION ALL

SELECT
    document.pid,
    document.id,
    'MDM_T02_DOC'::text AS msg_type
FROM document
INNER JOIN patientrecord ON document.pid = patientrecord.pid
-- Require PKB Membership
INNER JOIN vwe_pkb_members ON patientrecord.ukrdcid = vwe_pkb_members.ukrdcid
INNER JOIN facility ON patientrecord.sendingfacility = facility.code
WHERE
    -- Require that Unit is Enabled
    facility.pkb_out = true
    AND
    patientrecord.sendingextract IN ('PV', 'UKRDC')
    AND
    (
        (
            document.update_date IS NULL AND
            document.creation_date > (  SELECT eventcontrol.eventdate
                                            FROM eventcontrol
                                            WHERE eventcontrol.eventtype = 'PKBEXTRACT'::bpchar)
        ) OR
        (
            document.update_date IS NOT NULL AND
            document.update_date > (        SELECT eventcontrol.eventdate
                                            FROM eventcontrol
                                            WHERE eventcontrol.eventtype = 'PKBEXTRACT'::bpchar)
        )
    )

UNION ALL

SELECT
    laborder.pid,
    laborder.id,
    'ORU_R01_LAB'::text AS msg_type
FROM laborder
INNER JOIN patientrecord ON laborder.pid = patientrecord.pid
-- Require PKB Membership
INNER JOIN vwe_pkb_members ON patientrecord.ukrdcid = vwe_pkb_members.ukrdcid
INNER JOIN facility ON patientrecord.sendingfacility = facility.code
WHERE
    -- Require that Unit is Enabled
    facility.pkb_out = true
    AND
    patientrecord.sendingextract IN ('PV', 'UKRDC')
    AND
    (
        (
        laborder.update_date IS NULL AND
        laborder.creation_date > (  SELECT eventcontrol.eventdate
                                    FROM eventcontrol
                                    WHERE eventcontrol.eventtype = 'PKBEXTRACT'::bpchar)
        ) OR
        (
            laborder.update_date IS NOT NULL AND
            laborder.update_date > (    SELECT eventcontrol.eventdate
                                        FROM eventcontrol
                                        WHERE eventcontrol.eventtype = 'PKBEXTRACT'::bpchar)
        ) OR
        (
            laborder.repository_update_date IS NOT NULL AND
            laborder.repository_update_date > (    SELECT eventcontrol.eventdate
                                        FROM eventcontrol
                                        WHERE eventcontrol.eventtype = 'PKBEXTRACT'::bpchar)
        )
    )

UNION ALL

SELECT
    observation.pid,
    observation.id,
    'ORU_R01_OBS'::text AS msg_type
FROM observation
INNER JOIN patientrecord ON observation.pid = patientrecord.pid
-- Require PKB Membership
INNER JOIN vwe_pkb_members ON patientrecord.ukrdcid = vwe_pkb_members.ukrdcid
INNER JOIN facility ON patientrecord.sendingfacility = facility.code
WHERE
    -- Require that Unit is Enabled
    facility.pkb_out = true
    AND
    patientrecord.sendingextract IN ('PV', 'UKRDC')
    AND
    (
        (
        observation.update_date IS NULL AND
        observation.creation_date > (   SELECT eventcontrol.eventdate
                                    FROM eventcontrol
                                    WHERE eventcontrol.eventtype = 'PKBEXTRACT'::bpchar)
        ) OR
        (
        observation.update_date IS NOT NULL AND
        observation.update_date > (     SELECT eventcontrol.eventdate
                                    FROM eventcontrol
                                    WHERE eventcontrol.eventtype = 'PKBEXTRACT'::bpchar)
        )
    )

;


GRANT ALL PRIVILEGES ON "extract".vwe_extract_pkb_updates TO ukrdc;