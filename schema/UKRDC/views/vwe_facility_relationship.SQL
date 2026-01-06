-- Materialized View: "extract".vwe_facility_relationship

CREATE MATERIALIZED VIEW "extract".vwe_facility_relationship AS
 SELECT
   f2.facilitycode    AS parentfacilitycode,
   f2.facilitycodestd AS parentfacilitycodestd,
   f1.facilitycode    AS childfacilitycode,
   f1.facilitycodestd AS childfacilitycodestd,
   CASE
     WHEN (
       (f1.facilitycodestd)::text = 'RR1+'::text AND
       (f2.facilitycodestd)::text = 'RR1+'::text AND
       (cm.source_coding_standard)::text = 'RR1+_FEEDSHARE_CHILD'::text AND
       (cm.destination_coding_standard)::text = 'RR1+_FEEDSHARE_PARENT'::text
     ) THEN 'FEED-SHARE'::text
     WHEN (
       (f1.facilitycodestd)::text = 'RR1+'::text AND
       (f2.facilitycodestd)::text = 'RR1+'::text AND
       (cm.source_coding_standard)::text = 'RR1+_SATELLITE'::text AND
       (cm.destination_coding_standard)::text = 'RR1+_MAIN'::text
     ) THEN 'MAIN-SATELLITE'::text
     WHEN (
       (f1.facilitycodestd)::text = 'RR1+'::text AND
       (f2.facilitycodestd)::text = 'RR1+'::text AND
       (cm.source_coding_standard)::text = 'RR1+_CURRENT'::text AND
       (cm.destination_coding_standard)::text = 'RR1+_DEPRECATED'::text
     ) THEN 'DEPRECATED-CURRENT'::text
     ELSE NULL::text
   END AS relationshiptype
 FROM "extract".facility_new f1
 JOIN "extract".code_map cm
   ON (f1.facilitycode)::text = (cm.source_code)::text
 JOIN "extract".facility_new f2
   ON (f2.facilitycode)::text = (cm.destination_code)::text
 WHERE (cm.source_coding_standard)::text = ANY (
   ARRAY[
     ('RR1+_FEEDSHARE_CHILD'::character varying)::text,
     ('RR1+_SATELLITE'::character varying)::text,
     ('RR1+_CURRENT'::character varying)::text
   ]
 )
 WITH NO DATA;

ALTER MATERIALIZED VIEW "extract".vwe_facility_relationship
  OWNER TO ukrdc;
