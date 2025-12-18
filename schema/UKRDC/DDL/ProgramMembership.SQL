-- Table: "extract".programmembership

CREATE TABLE "extract".programmembership
(
  id character varying(100) NOT NULL,
  pid character varying(30) NOT NULL,
  programname character varying(100),
  programdescription character varying(100),
  enteredbycode character varying(100),
  enteredbycodestd character varying(100),
  enteredbydesc character varying(100),
  enteredatcode character varying(100),
  enteredatcodestd character varying(100),
  enteredatdesc character varying(100),
  fromtime date,
  totime date,
  updatedon timestamp without time zone,
  actioncode character varying(3),
  externalid character varying(100),
  creation_date timestamp without time zone DEFAULT now() NOT NULL,
  update_date timestamp without time zone,
  CONSTRAINT programmembership_pkey PRIMARY KEY (id),
  CONSTRAINT programmembership_pid_fkey
    FOREIGN KEY (pid)
    REFERENCES "extract".patientrecord(pid)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "extract".programmembership
  OWNER TO ukrdc;
GRANT ALL PRIVILEGES ON TABLE "extract".programmembership TO ukrdc;

CREATE INDEX programmembership_pid_idx
  ON "extract".programmembership (pid);