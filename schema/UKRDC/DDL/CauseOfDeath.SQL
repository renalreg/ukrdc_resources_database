-- Table: "extract".causeofdeath

CREATE TABLE "extract".causeofdeath
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
  enteredon timestamp without time zone,
  updatedon timestamp without time zone,
  actioncode character varying(3),
  externalid character varying(100),
  creation_date timestamp without time zone DEFAULT now() NOT NULL,
  update_date timestamp without time zone,
  CONSTRAINT causeofdeath_pkey PRIMARY KEY (pid),
  CONSTRAINT causeofdeath_pid_fkey
    FOREIGN KEY (pid)
    REFERENCES "extract".patientrecord(pid)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "extract".causeofdeath
  OWNER TO ukrdc;
GRANT ALL PRIVILEGES on TABLE "extract".causeofdeath TO ukrdc;

CREATE INDEX causeofdeath_pid_idx
  ON "extract".causeofdeath (pid);