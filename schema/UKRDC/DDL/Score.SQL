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
  CONSTRAINT score_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "extract".score
  OWNER TO ukrdc;
GRANT ALL PRIVILEGES on TABLE "extract".score TO ukrdc
