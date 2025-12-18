-- Table: "extract".name
CREATE TABLE "extract".name
(
  id character varying(100) NOT NULL,
  pid character varying(30) NOT NULL,
  idx integer,
  nameuse character varying(10),
  prefix character varying(10),
  family character varying(60),
  given character varying(60),
  othergivennames character varying(60),
  suffix character varying(10),
  creation_date timestamp without time zone DEFAULT now() NOT NULL,
  update_date timestamp without time zone,
  CONSTRAINT name_pkey PRIMARY KEY (id),
  CONSTRAINT name_pid_fkey
    FOREIGN KEY (pid)
    REFERENCES "extract".patientrecord(pid)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "extract".name
  OWNER TO ukrdc;
GRANT ALL PRIVILEGES ON TABLE "extract".name TO ukrdc;