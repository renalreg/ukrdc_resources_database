
CREATE TABLE "extract".satellite_map (
    SATELLITE_CODE varchar(10),
    MAIN_UNIT_CODE varchar(10),
    CONSTRAINT satellite_map_pkey PRIMARY KEY (SATELLITE_CODE, MAIN_UNIT_CODE)
);
ALTER TABLE "extract".satellite_map
  OWNER TO ukrdc;
GRANT ALL PRIVILEGES on TABLE "extract".satellite_map TO ukrdc;
