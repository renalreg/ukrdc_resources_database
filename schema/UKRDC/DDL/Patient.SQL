-- Table: "extract".patient

CREATE TABLE "extract".patient
(
  pid character varying(30) NOT NULL,
  birthtime timestamp without time zone,
  deathtime timestamp without time zone,
  gender character varying(2),
  countryofbirth character varying(3),
  ethnicgroupcode character varying(100),
  ethnicgroupcodestd character varying(100),
  ethnicgroupdesc character varying(100),
  occupationcode character varying(100),
  occupationcodestd character varying(100),
  occupationdesc character varying(100),
  primarylanguagecode character varying(100),
  primarylanguagecodestd character varying(100),
  primarylanguagedesc character varying(100),
  bloodgroup character varying(100),
  bloodrhesus character varying(100),
  death boolean,
  persontocontactname character varying(100),
  persontocontact_relationship character varying(20),
  persontocontact_contactnumber character varying(20),
  persontocontact_contactnumbertype character varying(20),
  persontocontact_contactnumbercomments character varying(200),
  updatedon timestamp without time zone,
  actioncode character varying(3),
  externalid character varying(100),
  CONSTRAINT patient_pkey PRIMARY KEY (pid)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "extract".patient
  OWNER TO ukrdc;
GRANT ALL PRIVILEGES on TABLE "extract".patient TO ukrdc
