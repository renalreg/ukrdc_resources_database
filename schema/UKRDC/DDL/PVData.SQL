-- Table: "extract".pvdata

CREATE TABLE "extract".pvdata
(
  id character varying(100) NOT NULL,
  rrtstatus character varying(100),
  tpstatus character varying(100),
  diagnosisdate date,
  bloodgroup character varying(10),
  creation_date timestamp without time zone DEFAULT now() NOT NULL,
  update_date timestamp without time zone,
  CONSTRAINT pvdata_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "extract".pvdata
  OWNER TO ukrdc;
GRANT ALL PRIVILEGES ON TABLE "extract".pvdata TO ukrdc;