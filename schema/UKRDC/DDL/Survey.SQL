-- Table: "extract".survey

CREATE TABLE "extract".survey
(
  id character varying(100) NOT NULL,
  pid character varying(30) NOT NULL,
  surveytime timestamp without time zone NOT NULL,
  surveytypecode character varying(100),
  surveytypecodestd character varying(100),
  surveytypedesc character varying(100),
  typeoftreatment character varying(100),
  hdlocation character varying(100),
  template character varying(100),
  enteredbycode character varying(100),
  enteredbycodestd character varying(100),
  enteredbydesc character varying(100),
  enteredatcode character varying(100),
  enteredatcodestd character varying(100),
  enteredatdesc character varying(100),
  updatedon timestamp without time zone,
  actioncode character varying(3),
  externalid character varying(100),
  creation_date timestamp without time zone DEFAULT now() NOT NULL,
  update_date timestamp without time zone,
  CONSTRAINT survey_pkey PRIMARY KEY (id),
  CONSTRAINT survey_pid_fkey
    FOREIGN KEY (pid)
    REFERENCES "extract".patientrecord(pid)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "extract".survey
  OWNER TO ukrdc;
GRANT ALL PRIVILEGES ON TABLE "extract".survey TO ukrdc;

CREATE INDEX survey
  ON "extract".survey (pid);