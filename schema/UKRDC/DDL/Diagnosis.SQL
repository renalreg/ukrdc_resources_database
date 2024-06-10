-- Table: "extract".diagnosis

CREATE TABLE "extract".diagnosis
(
  id character varying(100) NOT NULL,
  pid character varying(30) NOT NULL,
  idx integer,
  diagnosistype character varying(50),
  diagnosingcliniciancode character varying(100),
  diagnosingcliniciancodestd character varying(100),
  diagnosingcliniciandesc character varying(100),
  diagnosiscode character varying(100),
  diagnosiscodestd character varying(100),
  diagnosisdesc character varying(100),
  comments text,
  identificationtime timestamp without time zone,
  onsettime timestamp without time zone,
  enteredon timestamp without time zone,
  enteredatcode character varying(100),
  enteredatcodestd character varying(100),
  enteredatdesc character varying(100),
  encounternumber character varying(100),
  verificationstatus character varying(20),
  updatedon timestamp without time zone,
  actioncode character varying(3),
  externalid character varying(100),
  CONSTRAINT diagnosis_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "extract".diagnosis
  OWNER TO ukrdc;
GRANT ALL PRIVILEGES on TABLE "extract".diagnosis TO ukrdc