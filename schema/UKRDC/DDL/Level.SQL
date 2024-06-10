-- Table: "extract".level

CREATE TABLE "extract".level
(
  id character varying(100) NOT NULL,
  surveyid character varying(100) NOT NULL,
  idx integer,
  levelvalue character varying(100),
  leveltypecode character varying(100),
  leveltypecodestd character varying(100),
  leveltypedesc character varying(100),
  CONSTRAINT level_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "extract".level
  OWNER TO ukrdc;
GRANT ALL PRIVILEGES on TABLE "extract".level TO ukrdc
