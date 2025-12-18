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

-- Name: generate_new_pid; Type: SEQUENCE; Schema: extract; Owner: postgres

CREATE SEQUENCE "extract".generate_new_pid
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE "extract".generate_new_pid OWNER TO postgres;

COMMENT ON SEQUENCE "extract".generate_new_pid IS
  'Sequence to generate new pids should be initiated as the maxiumum pid';

-- Name: generate_new_ukrdcid; Type: SEQUENCE; Schema: extract; Owner: postgres

CREATE SEQUENCE "extract".generate_new_ukrdcid
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE "extract".generate_new_ukrdcid OWNER TO postgres;

COMMENT ON SEQUENCE "extract".generate_new_ukrdcid IS 'Sequence mints new ukrdcids';

GRANT SELECT,USAGE ON SEQUENCE "extract".generate_new_pid TO ukrdc;
GRANT SELECT,USAGE ON SEQUENCE "extract".generate_new_ukrdcid TO ukrdc;