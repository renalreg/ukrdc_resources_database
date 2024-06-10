-- Table: "extract".patientnumber

CREATE TABLE "extract".patientnumber
(
  id character varying(100) NOT NULL,
  pid character varying(30) NOT NULL,
  idx integer,
  patientid character varying(50),
  numbertype character varying(3),
  organization character varying(50),
  updatedon timestamp without time zone,
  actioncode character varying(3),
  externalid character varying(100),
  CONSTRAINT patientnumber_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "extract".patientnumber
  OWNER TO ukrdc;
GRANT ALL PRIVILEGES on TABLE "extract".patientnumber TO ukrdc;

CREATE INDEX patientnumber_patientid ON "extract".patientnumber (patientid);
