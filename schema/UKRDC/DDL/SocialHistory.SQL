-- Table: "extract".socialhistory

CREATE TABLE "extract".socialhistory
(
  id character varying(100) NOT NULL,
  pid character varying(30) NOT NULL,
  idx integer,
  socialhabitcode character varying(100),
  socialhabitcodestd character varying(100),
  socialhabitdesc character varying(100),
  updatedon timestamp without time zone,
  actioncode character varying(3),
  externalid character varying(100),
  creation_date timestamp without time zone DEFAULT now() NOT NULL,
  update_date timestamp without time zone,
  CONSTRAINT socialhistory_pkey PRIMARY KEY (id),
  CONSTRAINT socialhistory_pid_fkey
    FOREIGN KEY (pid)
    REFERENCES "extract".patientrecord(pid)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "extract".socialhistory
  OWNER TO ukrdc;
GRANT ALL PRIVILEGES ON TABLE "extract".socialhistory TO ukrdc;