-- Table: "extract".observation

CREATE TABLE "extract".observation
(
  id character varying(100) NOT NULL,
  pid character varying(30) NOT NULL,
  idx integer,
  observationtime timestamp without time zone,
  observationcode character varying(100),
  observationcodestd character varying(100),
  observationdesc character varying(100),
  observationvalue character varying(30),
  observationunits character varying(30),
  prepost character varying(4),
  commenttext character varying(1000),
  cliniciancode character varying(100),
  cliniciancodestd character varying(100),
  cliniciandesc character varying(100),
  enteredatcode character varying(100),
  enteredatcodestd character varying(100),
  enteredatdesc character varying(100),
  enteringorganizationcode character varying(100),
  enteringorganizationcodestd character varying(100),
  enteringorganizationdesc character varying(100),
  updatedon timestamp without time zone,
  actioncode character varying(3),
  externalid character varying(100),
  CONSTRAINT observation_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "extract".observation
  OWNER TO ukrdc;
GRANT ALL PRIVILEGES on TABLE "extract".observation TO ukrdc
