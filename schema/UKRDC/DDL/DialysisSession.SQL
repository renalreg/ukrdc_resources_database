-- Table: "extract".dialysissession

CREATE TABLE "extract".dialysissession
(
  id character varying(100) NOT NULL,
  pid character varying(30) NOT NULL,
  idx integer,
  proceduretypecode character varying(100),
  proceduretypecodestd character varying(100),
  proceduretypedesc character varying(100),
  cliniciancode character varying(100),
  cliniciancodestd character varying(100),
  cliniciandesc character varying(100),
  proceduretime timestamp without time zone,
  enteredbycode character varying(100),
  enteredbycodestd character varying(100),
  enteredbydesc character varying(100),
  enteredatcode character varying(100),
  enteredatcodestd character varying(100),
  enteredatdesc character varying(100),
  qhd19 character varying(255),
  qhd20 character varying(255),
  qhd21 character varying(255),
  qhd22 character varying(255),
  qhd30 character varying(255),
  qhd31 character varying(255),
  qhd32 character varying(255),
  qhd33 character varying(255),
  updatedon timestamp without time zone,
  actioncode character varying(3),
  externalid character varying(100),
  creation_date timestamp without time zone DEFAULT now() NOT NULL,
  update_date timestamp without time zone,
  CONSTRAINT dialysissession_pkey PRIMARY KEY (id),
  CONSTRAINT dialysissession_pid_fkey
    FOREIGN KEY (pid)
    REFERENCES "extract".patientrecord(pid)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "extract".dialysissession
  OWNER TO ukrdc;
GRANT ALL PRIVILEGES ON TABLE "extract".dialysissession TO ukrdc;
