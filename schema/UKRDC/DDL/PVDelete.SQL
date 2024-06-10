-- Table: "extract".pvdelete

CREATE TABLE "extract".pvdelete
(
  did SERIAL,
  pid character varying(30) NOT NULL,
  observationtime timestamp without time zone,
  serviceidcode character varying(100),
  CONSTRAINT pvdelete_pkey PRIMARY KEY (did)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "extract".pvdelete
OWNER TO ukrdc;
GRANT ALL PRIVILEGES on TABLE "extract".pvdelete TO ukrdc
