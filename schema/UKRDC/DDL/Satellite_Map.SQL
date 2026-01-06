-- Table: "extract".satellite_map

CREATE TABLE "extract".satellite_map
(
  satellite_code character varying(10) NOT NULL,
  main_unit_code character varying(10) NOT NULL,
  creation_date timestamp without time zone DEFAULT now() NOT NULL,
  update_date timestamp without time zone,
  CONSTRAINT satellite_map_pkey PRIMARY KEY (satellite_code, main_unit_code)
)
WITH (
  OIDS=FALSE
);

ALTER TABLE "extract".satellite_map
  OWNER TO ukrdc;
GRANT ALL PRIVILEGES ON TABLE "extract".satellite_map TO ukrdc;