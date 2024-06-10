-- Table: "extract".name
CREATE TABLE "extract".name
(
  id character varying(100) NOT NULL,
  pid character varying(30) NOT NULL,
  idx integer,
  nameuse character varying(10),
  prefix character varying(10),
  family character varying(60),
  given character varying(60),
  othergivennames character varying(60),
  suffix character varying(10),
  CONSTRAINT name_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "extract".name
  OWNER TO ukrdc;
GRANT ALL PRIVILEGES on TABLE "extract".name TO ukrdc
