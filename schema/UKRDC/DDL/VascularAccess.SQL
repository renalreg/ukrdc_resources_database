-- Table: "extract".vascularaccess

CREATE TABLE "extract".vascularaccess
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
  updatedon timestamp without time zone,
  actioncode character varying(3),
  externalid character varying(100),
  acc19 timestamp without time zone,
  acc20 timestamp without time zone,
  acc21 timestamp without time zone,
  acc22 character varying(255),
  acc30 character varying(255),
  acc40 character varying(255),
  creation_date timestamp without time zone DEFAULT now() NOT NULL,
  CONSTRAINT vascularaccess_pkey PRIMARY KEY (id),
  CONSTRAINT vascularaccess_pid_fkey
    FOREIGN KEY (pid)
    REFERENCES "extract".patientrecord(pid)
)
WITH (
  OIDS=FALSE
);

ALTER TABLE "extract".vascularaccess
  OWNER TO ukrdc;
GRANT ALL PRIVILEGES ON TABLE "extract".vascularaccess TO ukrdc;

CREATE INDEX vascularaccess_pid_idx
  ON "extract".vascularaccess (pid);