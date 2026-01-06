-- Table: "extract".facility_new

CREATE TYPE "extract".facility_type_enum AS ENUM (
  'Adult Renal Centre',
  'Paediatric Renal Centre',
  'Multiple Centre',
  'Satellite',
  'Non‑Renal Unit'
);

ALTER TYPE "extract".facility_type_enum
  OWNER TO ukrdc;

CREATE TABLE "extract".facility_new
(
  facilitycode character varying(100) NOT NULL,
  facilitycodestd character varying(100) NOT NULL,
  facilitytype "extract".facility_type_enum NOT NULL,
  pkbout boolean DEFAULT false NOT NULL,
  pkbmsgexclusions text[],
  ukrdcoutpkb boolean DEFAULT false NOT NULL,
  pvoutpkb boolean DEFAULT false NOT NULL,
  startdate timestamp(6) without time zone,
  enddate timestamp(6) without time zone,
  firstdataquarter integer,
  pkboutstartdate timestamp(6) without time zone,
  creation_date timestamp without time zone DEFAULT now() NOT NULL,
  update_date timestamp without time zone DEFAULT now() NOT NULL
)
WITH (
  OIDS=FALSE
);

ALTER TABLE "extract".facility_new
  OWNER TO ukrdc;
GRANT ALL PRIVILEGES ON TABLE "extract".facility_new TO ukrdc;