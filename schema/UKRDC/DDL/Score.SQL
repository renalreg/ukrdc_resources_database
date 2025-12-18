-- Table: "extract".score

CREATE TABLE "extract".score
(
  id character varying(100) NOT NULL,
  surveyid character varying(100) NOT NULL,
  idx integer,
  scorevalue character varying(100),
  scoretypecode character varying(100),
  scoretypecodestd character varying(100),
  scoretypedesc character varying(100),
  creation_date timestamp without time zone DEFAULT now() NOT NULL,
  update_date timestamp without time zone,
  CONSTRAINT score_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "extract".score
  OWNER TO ukrdc;
GRANT ALL PRIVILEGES ON TABLE "extract".score TO ukrdc;