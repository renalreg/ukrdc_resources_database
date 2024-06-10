-- Table: "extract".socialhistory

CREATE TABLE "extract".socialhistory
(
  id character varying(100) NOT NULL,
  pid character varying(30) NOT NULL,
  idx integer,
  socialhabitcode character varying(100),
  socialhabitcodestd character varying(100),
  socialhabitdesc character varying(100),
  updatedon timestamp without time zone,
  actioncode character varying(3),
  externalid character varying(100),
  CONSTRAINT socialhistory_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "extract".socialhistory
  OWNER TO ukrdc;
GRANT ALL PRIVILEGES on TABLE "extract".socialhistory TO ukrdc
