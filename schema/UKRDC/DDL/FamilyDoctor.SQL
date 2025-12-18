-- Table: "extract".familydoctor

CREATE TABLE "extract".familydoctor
(
  id character varying(100) NOT NULL,
  gpname character varying(100),
  gpid character varying(20),
  gppracticeid character varying(20),
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
  contactuse character varying(10),
  contactvalue character varying(100),
  email character varying(100),
  commenttext character varying(100),
  creation_date timestamp without time zone DEFAULT now() NOT NULL,
  update_date timestamp without time zone,
  CONSTRAINT familydoctor_pkey PRIMARY KEY (id),
  CONSTRAINT patient_familydoctor_fkey
    FOREIGN KEY (id)
    REFERENCES "extract".patientrecord(pid)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "extract".familydoctor
  OWNER TO ukrdc;
GRANT ALL PRIVILEGES ON TABLE "extract".familydoctor TO ukrdc;
