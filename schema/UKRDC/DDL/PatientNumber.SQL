-- Table: "extract".patientnumber

CREATE TABLE "extract".patientnumber
(
  id character varying(100) NOT NULL,
  pid character varying(30) NOT NULL,
  idx integer,
  patientid character varying(50),
  numbertype character varying(3),
  organization character varying(50),
  updatedon timestamp without time zone,
  actioncode character varying(3),
  externalid character varying(100),
  creation_date timestamp without time zone DEFAULT now() NOT NULL,
  update_date timestamp without time zone,
  CONSTRAINT patientnumber_pkey PRIMARY KEY (id),
  CONSTRAINT patientnumber_pid_fkey
    FOREIGN KEY (pid)
    REFERENCES "extract".patientrecord(pid)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "extract".patientnumber
  OWNER TO ukrdc;
GRANT ALL PRIVILEGES ON TABLE "extract".patientnumber TO ukrdc;

CREATE INDEX patientnumber_patientid ON "extract".patientnumber (patientid);