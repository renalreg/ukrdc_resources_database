-- Table: "extract".treatment

CREATE TABLE "extract".treatment
(
  id character varying(100) NOT NULL,
  pid character varying(30) NOT NULL,
  idx integer,
  encounternumber character varying(100),
  encountertype character varying(100),
  fromtime timestamp without time zone,
  totime timestamp without time zone,
  admittingcliniciancode character varying(100),
  admittingcliniciancodestd character varying(100),
  admittingcliniciandesc character varying(100),
  admitreasoncode character varying(100),
  admitreasoncodestd character varying(100),
  admitreasondesc character varying(100),
  admissionsourcecode character varying(100),
  admissionsourcecodestd character varying(100),
  admissionsourcedesc character varying(100),
  dischargereasoncode character varying(100),
  dischargereasoncodestd character varying(100),
  dischargereasondesc character varying(100),
  dischargelocationcode character varying(100),
  dischargelocationcodestd character varying(100),
  dischargelocationdesc character varying(100),
  healthcarefacilitycode character varying(100),
  healthcarefacilitycodestd character varying(100),
  healthcarefacilitydesc character varying(100),
  enteredatcode character varying(100),
  enteredatcodestd character varying(100),
  enteredatdesc character varying(100),
  visitdescription character varying(255),
  updatedon timestamp without time zone,
  actioncode character varying(3),
  externalid character varying(100),
  hdp01 character varying(255),
  hdp02 character varying(255),
  hdp03 character varying(255),
  hdp04 character varying(255),
  qbl05 character varying(255),
  qbl06 character varying(255),
  qbl07 character varying(255),
  erf61 character varying(255),
  pat35 character varying(255),
  CONSTRAINT treatment_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "extract".treatment
  OWNER TO ukrdc;
GRANT ALL PRIVILEGES on TABLE "extract".treatment TO ukrdc
