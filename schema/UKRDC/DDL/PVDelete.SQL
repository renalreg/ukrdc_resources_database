-- Table: "extract".pvdelete

CREATE TABLE "extract".pvdelete
(
  did SERIAL,
  pid character varying(30) NOT NULL,
  observationtime timestamp without time zone,
  serviceidcode character varying(100),
  creation_date timestamp without time zone DEFAULT now() NOT NULL,
  update_date timestamp without time zone,
  CONSTRAINT pvdelete_pkey PRIMARY KEY (did),
  CONSTRAINT pvdelete_pid_fkey
    FOREIGN KEY (pid)
    REFERENCES "extract".patientrecord(pid)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "extract".pvdelete
  OWNER TO ukrdc;
GRANT ALL PRIVILEGES ON TABLE "extract".pvdelete TO ukrdc;

CREATE SEQUENCE "extract".pvdelete_did_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "extract".pvdelete_did_seq OWNER TO ukrdc;
