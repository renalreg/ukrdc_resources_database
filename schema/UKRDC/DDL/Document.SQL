-- Table: "extract".document

CREATE TABLE "extract".document
(
  id character varying(100) NOT NULL,
  pid character varying(30) NOT NULL,
  idx integer,
  documenttime timestamp without time zone,
  notetext text,
  documenttypecode character varying(100),
  documenttypecodestd character varying(100),
  documenttypedesc character varying(100),
  cliniciancode character varying(100),
  cliniciancodestd character varying(100),
  cliniciandesc character varying(100),
  documentname character varying(100),
  statuscode character varying(100),
  statuscodestd character varying(100),
  statusdesc character varying(100),
  enteredbycode character varying(100),
  enteredbycodestd character varying(100),
  enteredbydesc character varying(100),
  enteredatcode character varying(100),
  enteredatcodestd character varying(100),
  enteredatdesc character varying(100),
  filetype character varying(100),
  filename character varying(100),
  stream bytea,
  documenturl character varying(100),
  repositoryupdatedate timestamp without time zone,
  updatedon timestamp without time zone,
  actioncode character varying(3),
  externalid character varying(100),
  CONSTRAINT document_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "extract".document
  OWNER TO ukrdc;
GRANT ALL PRIVILEGES on TABLE "extract".document TO ukrdc;
