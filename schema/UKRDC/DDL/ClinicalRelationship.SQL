-- Table: "extract".clinicalrelationship

CREATE TABLE "extract".clinicalrelationship
(
  id character varying(100) NOT NULL,
  pid character varying(30) NOT NULL,
  idx integer,
  cliniciancode character varying(100),
  cliniciancodestd character varying(100),
  cliniciandesc character varying(100),
  facilitycode character varying(100),
  facilitycodestd character varying(100),
  facilitydesc character varying(100),
  fromtime date,
  totime date,
  updatedon timestamp without time zone,
  actioncode character varying(3),
  externalid character varying(100),
  creation_date timestamp without time zone DEFAULT now() NOT NULL,
  update_date timestamp without time zone,
  CONSTRAINT clinicalrelationship_pkey PRIMARY KEY (id),
  CONSTRAINT clinicalrelationship_pid_fkey
    FOREIGN KEY (pid)
    REFERENCES "extract".patientrecord(pid)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "extract".clinicalrelationship
  OWNER TO ukrdc;
GRANT ALL PRIVILEGES on TABLE "extract".clinicalrelationship TO ukrdc;

CREATE INDEX clinicalrelationship_pid_idx
  ON "extract".clinicalrelationship (pid);
