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
  CONSTRAINT patientrecord_pkey PRIMARY KEY (pid),
  CONSTRAINT patientrecord_key2 UNIQUE (sendingfacility, sendingextract, localpatientid)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "extract".patientrecord
  OWNER TO ukrdc;
GRANT ALL PRIVILEGES on TABLE "extract".patientrecord TO ukrdc
