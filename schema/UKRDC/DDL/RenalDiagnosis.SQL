-- Table: "extract".renaldiagnosis
CREATE TABLE "extract".renaldiagnosis
(
  pid character varying(30) NOT NULL,
  diagnosistype character varying(50),
  diagnosingcliniciancode character varying(100),
  diagnosingcliniciancodestd character varying(100),
  diagnosingcliniciandesc character varying(100),
  diagnosiscode character varying(100),
  diagnosiscodestd character varying(100),
  diagnosisdesc character varying(255),
  comments text,
  identificationtime timestamp without time zone,
  onsettime timestamp without time zone,
  enteredon timestamp without time zone,
  updatedon timestamp without time zone,
  actioncode character varying(3),
  externalid character varying(100),
  creation_date timestamp without time zone DEFAULT now() NOT NULL,
  update_date timestamp without time zone,
  idx integer,
  biopsyperformed character varying(100),
  verificationstatus character varying(100),
  CONSTRAINT renaldiagnosis_pkey PRIMARY KEY (pid, idx),
  CONSTRAINT renaldiagnosis_pid_fkey
    FOREIGN KEY (pid)
    REFERENCES "extract".patientrecord(pid)
)
WITH (
  OIDS=FALSE
);

ALTER TABLE "extract".renaldiagnosis
  OWNER TO ukrdc;
GRANT ALL PRIVILEGES ON TABLE "extract".renaldiagnosis TO ukrdc;     


CREATE INDEX renaldiagnosis_pid_idx
  ON "extract".renaldiagnosis (pid)