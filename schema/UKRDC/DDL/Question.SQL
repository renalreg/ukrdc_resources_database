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
  questiontext character varying(200),
  CONSTRAINT question_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "extract".question
  OWNER TO ukrdc;
GRANT ALL PRIVILEGES on TABLE "extract".question TO ukrdc
