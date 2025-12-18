-- Table: "extract".assessment

CREATE TABLE "extract".assessment
(
  id character varying NOT NULL,
  pid character varying,
  idx integer,
  creation_date timestamp without time zone DEFAULT now() NOT NULL,
  update_date timestamp without time zone,
  assessmentstart timestamp without time zone,
  assessmentend timestamp without time zone,
  assessmenttypecode character varying(100),
  assessmenttypecodestd character varying(100),
  assessmenttypecodedesc character varying(100),
  assessmentoutcomecode character varying(100),
  assessmentoutcomecodestd character varying(100),
  assessmentoutcomecodedesc character varying(100),
  CONSTRAINT assessment_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "extract".assessment
  OWNER TO ukrdc;
GRANT ALL PRIVILEGES ON TABLE "extract".assessment TO ukrdc;
