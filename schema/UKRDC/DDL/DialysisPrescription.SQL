-- Table: "extract".dialysisprescription

CREATE TABLE "extract".dialysisprescription
(
  id character varying(20) NOT NULL,
  pid character varying(20),
  idx integer,
  creation_date timestamp without time zone DEFAULT now() NOT NULL,
  update_date timestamp without time zone,
  enteredon timestamp without time zone,
  fromtime timestamp without time zone,
  totime timestamp without time zone,
  sessiontype character varying(5),
  sessionsperweek integer,
  timedialysed integer,
  vascularaccess character varying(5),
  CONSTRAINT dialysisprescription_pkey PRIMARY KEY (id),
  CONSTRAINT dialysisprescription_pid_fkey
    FOREIGN KEY (pid)
    REFERENCES "extract".patientrecord(pid)
)
WITH (
  OIDS=FALSE
);

ALTER TABLE "extract".dialysisprescription
  OWNER TO ukrdc;
GRANT ALL PRIVILEGES ON TABLE "extract".dialysisprescription TO ukrdc;

CREATE INDEX dialysisprescription_pid_idx
  ON "extract".dialysisprescription (pid);
