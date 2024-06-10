-- Table: "extract".contactdetail

CREATE TABLE "extract".contactdetail
(
  id character varying(100) NOT NULL,
  pid character varying(30) NOT NULL,
  idx integer,
  contactuse character varying(10),
  contactvalue character varying(100),
  commenttext character varying(100),
  updatedon timestamp without time zone,
  actioncode character varying(3),
  externalid character varying(100),
  CONSTRAINT contactdetail_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "extract".contactdetail
  OWNER TO ukrdc;
GRANT ALL PRIVILEGES on TABLE "extract".contactdetail TO ukrdc
