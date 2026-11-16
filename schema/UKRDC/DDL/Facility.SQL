-- Table: "extract".facility

CREATE TYPE "extract".facility_type_enum AS ENUM (
  'Adult Renal Centre',
  'Paediatric Renal Centre',
  'Multiple Centre',
  'Satellite',
  'Non‑Renal Unit',
  'Other'
);

ALTER TYPE "extract".facility_type_enum
  OWNER TO ukrdc;

CREATE TABLE "extract".facility
(
  facilitycode character varying(100) NOT NULL,
  facilitycodestd character varying(256) NOT NULL,
  facilitytype "extract".facility_type_enum NOT NULL,
  pkbout boolean DEFAULT false NOT NULL,
  pkbmsgexclusions text[],
  pkb_pv_msg_exclusions text[],
  pkb_ukrdc_msg_exclusions text[],
  ukrdcoutpkb boolean DEFAULT false NOT NULL,
  pvoutpkb boolean DEFAULT false NOT NULL,
  radar_out boolean DEFAULT false NOT NULL,
  enabled_radar_extracts text[],
  startdate timestamp(6) without time zone,
  enddate timestamp(6) without time zone,
  firstdataquarter integer,
  pkboutstartdate timestamp(6) without time zone,
  creation_date timestamp without time zone DEFAULT now() NOT NULL,
  update_date timestamp without time zone DEFAULT now() NOT NULL,
  PRIMARY KEY (facilitycode, facilitycodestd),
  FOREIGN KEY (facilitycode, facilitycodestd)
    REFERENCES "extract".code_list (code, coding_standard)
    ON UPDATE CASCADE ON DELETE RESTRICT
)
WITH (
  OIDS=FALSE
);

ALTER TABLE "extract".facility
  OWNER TO ukrdc;
GRANT ALL PRIVILEGES ON TABLE "extract".facility TO ukrdc;

COMMENT ON COLUMN "extract".facility.radar_out IS 'Master switch for RADAR export for this facility. If false, nothing exports for this facility, regardless of enabled_radar_extracts or which extracts are enabled globally.';

COMMENT ON COLUMN "extract".facility.enabled_radar_extracts IS 'Sending extracts that RADAR should export for this facility. An extract must ALSO be enabled globally via SendingExtractMetadata.enable_radar_export - this list only narrows that down per facility, it cannot widen it. A null/empty list means nothing exports for this facility.';