-- Table: "extract".locations

CREATE TABLE "extract".locations
(
  centre_code character varying(10) NOT NULL,
  centre_name character varying(255) NOT NULL,
  country_code character varying(6) NOT NULL,
  region_code character varying(10),
  paed_unit integer NOT NULL
)
WITH (
  OIDS=FALSE
);

ALTER TABLE "extract".locations
  OWNER TO ukrdc;
GRANT ALL PRIVILEGES ON TABLE "extract".locations TO ukrdc;