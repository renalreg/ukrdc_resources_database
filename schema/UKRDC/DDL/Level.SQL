-- Table: "extract".level

CREATE TABLE "extract".level
(
  id character varying(100) NOT NULL,
  surveyid character varying(100) NOT NULL,
  idx integer,
  levelvalue character varying(100),
  leveltypecode character varying(100),
  leveltypecodestd character varying(100),
  leveltypedesc character varying(100),
  creation_date timestamp without time zone DEFAULT now() NOT NULL,
  update_date timestamp without time zone,
  CONSTRAINT level_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "extract".level
  OWNER TO ukrdc;
GRANT ALL PRIVILEGES ON TABLE "extract".level TO ukrdc;