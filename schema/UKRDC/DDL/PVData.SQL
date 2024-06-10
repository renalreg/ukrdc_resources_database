-- Table: "extract".pvdata

CREATE TABLE "extract".pvdata
(
  id character varying(100) NOT NULL,
  rrtstatus character varying(100),
  tpstatus character varying(100),
  diagnosisdate date,
  bloodgroup character varying(10),
  CONSTRAINT pvdata_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "extract".pvdata
  OWNER TO ukrdc;
GRANT ALL PRIVILEGES on TABLE "extract".pvdata TO ukrdc
