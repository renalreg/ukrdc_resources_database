-- Table: "extract".causeofdeath

CREATE TABLE "extract".causeofdeath
(
  pid character varying(30) NOT NULL,
  diagnosistype character varying(50),
  diagnosingcliniciancode character varying(100),
  diagnosingcliniciancodestd character varying(100),
  diagnosingcliniciandesc character varying(100),
  diagnosiscode character varying(100),
  diagnosiscodestd character varying(100),
  diagnosisdesc character varying(255),
  comments text,
  enteredon timestamp without time zone,
  updatedon timestamp without time zone,
  actioncode character varying(3),
  externalid character varying(100),
  CONSTRAINT causeofdeath_pkey PRIMARY KEY (pid)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "extract".causeofdeath
  OWNER TO ukrdc;
GRANT ALL PRIVILEGES on TABLE "extract".causeofdeath TO ukrdc
