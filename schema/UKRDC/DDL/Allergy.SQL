-- Table: "extract".allergy

CREATE TABLE "extract".allergy
(
  id character varying(100) NOT NULL,
  pid character varying(30) NOT NULL,
  idx integer,
  allergycode character varying(100),
  allergycodestd character varying(100),
  allergydesc character varying(100),
  allergycategorycode character varying(100),
  allergycategorycodestd character varying(100),
  allergycategorydesc character varying(100),
  severitycode character varying(100),
  severitycodestd character varying(100),
  severitydesc character varying(100),
  cliniciancode character varying(100),
  cliniciancodestd character varying(100),
  cliniciandesc character varying(100),
  discoverytime timestamp without time zone,
  confirmedtime timestamp without time zone,
  commenttext character varying(500),
  inactivetime timestamp without time zone,
  freetextallergy character varying(500),
  qualifyingdetails character varying(500),
  updatedon timestamp without time zone,
  actioncode character varying(3),
  externalid character varying(100),
  CONSTRAINT allergy_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "extract".allergy
  OWNER TO ukrdc;
GRANT ALL PRIVILEGES on TABLE "extract".allergy TO ukrdc
