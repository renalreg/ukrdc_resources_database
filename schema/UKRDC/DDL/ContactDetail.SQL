-- Table: "extract".contactdetail

CREATE TABLE "extract".contactdetail
(
  id character varying(100) NOT NULL,
  pid character varying(30) NOT NULL,
  idx integer,
  contactuse character varying(10),
  contactvalue character varying(100),
  commenttext character varying(100),
  updatedon timestamp without time zone,
  actioncode character varying(3),
  externalid character varying(100),
  creation_date timestamp without time zone DEFAULT now() NOT NULL,
  update_date timestamp without time zone,
  CONSTRAINT contactdetail_pkey PRIMARY KEY (id),
  CONSTRAINT contactdetail_pid_fkey
    FOREIGN KEY (pid)
    REFERENCES "extract".patientrecord(pid)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "extract".contactdetail
  OWNER TO ukrdc;
GRANT ALL PRIVILEGES ON TABLE "extract".contactdetail TO ukrdc;

CREATE INDEX contactdetail_pid_idx
  ON "extract".contactdetail (pid);
