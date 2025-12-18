-- View: "extract".vwe_satellite_map

CREATE VIEW "extract".vwe_satellite_map AS
 SELECT
   parentfacilitycode AS main_unit_code,
   childfacilitycode  AS satellite_code
 FROM "extract".vwe_facility_relationship
 WHERE relationshiptype = 'MAIN-SATELLITE'::text;

ALTER VIEW "extract".vwe_satellite_map
  OWNER TO ukrdc;