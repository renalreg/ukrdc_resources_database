-- Table: "extract".patientrecord

CREATE TABLE "extract".patientrecord
(
  pid character varying(30) NOT NULL,
  sendingfacility character varying(7) NOT NULL,
  sendingextract character varying(6) NOT NULL,
  localpatientid character varying(17) NOT NULL,
  ukrdcid character varying(10),
  channelname character varying(50),
  channelid character varying(50),
  extracttime character varying(50),
  schemaversion character varying(50),
  repositorycreationdate timestamp without time zone NOT NULL,
  repositoryupdatedate timestamp without time zone NOT NULL,
  startdate timestamp without time zone,
  stopdate timestamp without time zone,
  migrated boolean NOT NULL DEFAULT(false),
  creation_date timestamp without time zone DEFAULT now() NOT NULL,
  update_date timestamp without time zone,
  CONSTRAINT patientrecord_pkey PRIMARY KEY (pid),
  CONSTRAINT patientrecord_key2 UNIQUE (sendingfacility, sendingextract, localpatientid)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "extract".patientrecord
  OWNER TO ukrdc;
GRANT ALL PRIVILEGES ON TABLE "extract".patientrecord TO ukrdc;


ALTER TABLE "extract".patientrecord
  ALTER COLUMN pid
  SET DEFAULT nextval('"extract".generate_new_pid')::varchar(30);

ALTER TABLE "extract".patientrecord
  ALTER COLUMN ukrdcid
  SET DEFAULT nextval('"extract".generate_new_ukrdcid')::varchar(10);

GRANT SELECT,USAGE ON SEQUENCE "extract".generate_new_pid TO ukrdc;
GRANT SELECT,USAGE ON SEQUENCE "extract".generate_new_ukrdcid TO ukrdc;