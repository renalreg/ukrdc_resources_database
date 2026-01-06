-- Table: "extract".question

CREATE TABLE "extract".question
(
  id character varying(100) NOT NULL,
  surveyid character varying(100) NOT NULL,
  idx integer,
  questiontypecode character varying(100),
  questiontypecodestd character varying(100),
  questiontypedesc character varying(100),
  response character varying(100),
  questiontext character varying(100),
  creation_date timestamp without time zone DEFAULT now() NOT NULL,
  update_date timestamp without time zone,
  CONSTRAINT question_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "extract".question
  OWNER TO ukrdc;
GRANT ALL PRIVILEGES ON TABLE "extract".question TO ukrdc;