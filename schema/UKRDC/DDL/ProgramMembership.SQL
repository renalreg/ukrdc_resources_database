-- Table: "extract".programmembership

CREATE TABLE "extract".programmembership
(
  id character varying(100) NOT NULL,
  pid character varying(30) NOT NULL,
  programname character varying(100),
  programdescription character varying(100),
  enteredbycode character varying(100),
  enteredbycodestd character varying(100),
  enteredbydesc character varying(100),
  enteredatcode character varying(100),
  enteredatcodestd character varying(100),
  enteredatdesc character varying(100),
  fromtime date,
  totime date,
  updatedon timestamp without time zone,
  actioncode character varying(3),
  externalid character varying(100),
  CONSTRAINT programmembership_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "extract".programmembership
  OWNER TO ukrdc;
GRANT ALL PRIVILEGES on TABLE "extract".programmembership TO ukrdc;
