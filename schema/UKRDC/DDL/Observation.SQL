-- Table: "extract".observation

CREATE TABLE "extract".observation
(
  id character varying(100) NOT NULL,
  pid character varying(30) NOT NULL,
  idx integer,
  observationtime timestamp without time zone,
  observationcode character varying(100),
  observationcodestd character varying(100),
  observationdesc character varying(100),
  observationvalue character varying(100),
  observationunits character varying(100),
  prepost character varying(4),
  commenttext character varying(100),
  cliniciancode character varying(100),
  cliniciancodestd character varying(100),
  cliniciandesc character varying(100),
  enteredatcode character varying(100),
  enteredatcodestd character varying(100),
  enteredatdesc character varying(100),
  enteringorganizationcode character varying(100),
  enteringorganizationcodestd character varying(100),
  enteringorganizationdesc character varying(100),
  updatedon timestamp without time zone,
  actioncode character varying(3),
  externalid character varying(100),
  creation_date timestamp without time zone DEFAULT now() NOT NULL,
  update_date timestamp without time zone,
  CONSTRAINT observation_pkey PRIMARY KEY (id),
  CONSTRAINT observation_pid_fkey
    FOREIGN KEY (pid)
    REFERENCES "extract".patientrecord(pid)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "extract".observation
  OWNER TO ukrdc;
GRANT ALL PRIVILEGES ON TABLE "extract".observation TO ukrdc;

CREATE INDEX observation_pid_idx
  ON "extract".observation (pid);