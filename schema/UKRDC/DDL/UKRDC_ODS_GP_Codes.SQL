-- Type: "extract".gp_type

CREATE TYPE "extract".gp_type AS ENUM (
  'GP',
  'PRACTICE'
);

ALTER TYPE "extract".gp_type
  OWNER TO ukrdc;

CREATE TABLE "extract".ukrdc_ods_gp_codes
(
  code character varying(8) NOT NULL,
  name character varying(50),
  address1 character varying(35),
  postcode character varying(8),
  phone character varying(12),
  type "extract".gp_type,
  creation_date timestamp without time zone DEFAULT now() NOT NULL,
  update_date timestamp without time zone,
  CONSTRAINT ukrdc_ods_gp_codes_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);

ALTER TABLE "extract".ukrdc_ods_gp_codes
  OWNER TO ukrdc;
GRANT ALL PRIVILEGES ON TABLE "extract".ukrdc_ods_gp_codes TO ukrdc;