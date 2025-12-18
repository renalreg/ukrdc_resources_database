-- Table: "extract".address

CREATE TABLE "extract".address
(
  id character varying(100) NOT NULL,
  pid character varying(30) NOT NULL,
  idx integer,
  addressuse character varying(10),
  fromtime date,
  totime date,
  street character varying(100),
  town character varying(100),
  county character varying(100),
  postcode character varying(10),
  countrycode character varying(100),
  countrycodestd character varying(100),
  countrydesc character varying(100),
  creation_date timestamp without time zone DEFAULT now() NOT NULL,
  update_date timestamp without time zone,
  CONSTRAINT address_pkey PRIMARY KEY (id),
  CONSTRAINT causeofdeath_pid_fkey
  FOREIGN KEY (pid)
  REFERENCES "extract".patientrecord(pid)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "extract".address
  OWNER TO ukrdc;
GRANT ALL PRIVILEGES ON TABLE "extract".address TO ukrdc;
