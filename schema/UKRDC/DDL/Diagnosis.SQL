-- Table: "extract".diagnosis

CREATE TABLE "extract".diagnosis
(
  id character varying(100) NOT NULL,
  pid character varying(30) NOT NULL,
  idx integer,
  diagnosistype character varying(50),
  diagnosingcliniciancode character varying(100),
  diagnosingcliniciancodestd character varying(100),
  diagnosingcliniciandesc character varying(100),
  diagnosiscode character varying(100),
  diagnosiscodestd character varying(100),
  diagnosisdesc character varying(100),
  comments text,
  identificationtime timestamp without time zone,
  onsettime timestamp without time zone,
  enteredon timestamp without time zone,
  updatedon timestamp without time zone,
  actioncode character varying(3),
  externalid character varying(100),
  creation_date timestamp without time zone DEFAULT now() NOT NULL,
  update_date timestamp without time zone,
  enteredatcode character varying(100),
  enteredatcodestd character varying(100),
  enteredatdesc character varying(100),
  encounternumber character varying(100),
  verificationstatus character varying(100),
  biopsyperformed character varying(100),
  CONSTRAINT diagnosis_pkey PRIMARY KEY (id),
  CONSTRAINT diagnosis_pid_fkey
    FOREIGN KEY (pid)
    REFERENCES "extract".patientrecord(pid)
)
WITH (
  OIDS=FALSE
);

ALTER TABLE "extract".diagnosis
  OWNER TO ukrdc;
GRANT ALL PRIVILEGES ON TABLE "extract".diagnosis TO ukrdc;

CREATE INDEX diagnosis_pid_idx
  ON "extract".diagnosis (pid);