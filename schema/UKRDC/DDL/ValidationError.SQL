-- Table: "extract".address

CREATE TABLE "extract".validationerror
(
  vid SERIAL,
  pid character varying(30) NOT NULL,
  updatedon timestamp without time zone,
  errortype integer NOT NULL,
  message character varying(200),
  creation_date timestamp without time zone DEFAULT now() NOT NULL,
  update_date timestamp without time zone,
  CONSTRAINT validationerror_pkey PRIMARY KEY (vid),
  CONSTRAINT validationerror_pid_fkey
    FOREIGN KEY (pid)
    REFERENCES "extract".patientrecord(pid)
)
WITH (
  OIDS=FALSE
);

ALTER TABLE "extract".validationerror
  OWNER TO ukrdc;
GRANT ALL PRIVILEGES ON TABLE "extract".validationerror TO ukrdc;

CREATE INDEX validationerror_pid_idx
  ON "extract".validationerror (pid);