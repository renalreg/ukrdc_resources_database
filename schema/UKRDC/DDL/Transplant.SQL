-- Table: "extract".transplant

CREATE TABLE "extract".transplant
(
  id character varying(100) NOT NULL,
  pid character varying(30) NOT NULL,
  idx integer,
  proceduretypecode character varying(100),
  proceduretypecodestd character varying(100),
  proceduretypedesc character varying(100),
  cliniciancode character varying(100),
  cliniciancodestd character varying(100),
  cliniciandesc character varying(100),
  proceduretime timestamp without time zone,
  enteredbycode character varying(100),
  enteredbycodestd character varying(100),
  enteredbydesc character varying(100),
  enteredatcode character varying(100),
  enteredatcodestd character varying(100),
  enteredatdesc character varying(100),
  updatedon timestamp without time zone,
  actioncode character varying(3),
  externalid character varying(100),
  tra64 timestamp without time zone,
  tra65 character varying(255),
  tra66 character varying(255),
  tra69 timestamp without time zone,
  tra76 character varying(255),
  tra77 character varying(255),
  tra78 character varying(255),
  tra79 character varying(255),
  tra80 character varying(255),
  tra8a character varying(255),
  tra81 character varying(255),
  tra82 character varying(255),
  tra83 character varying(255),
  tra84 character varying(255),
  tra85 character varying(255),
  tra86 character varying(255),
  tra87 character varying(255),
  tra88 character varying(255),
  tra89 character varying(255),
  tra90 character varying(255),
  tra91 character varying(255),
  tra92 character varying(255),
  tra93 character varying(255),
  tra94 character varying(255),
  tra95 character varying(255),
  tra96 character varying(255),
  tra97 character varying(255),
  tra98 character varying(255),
  CONSTRAINT transplant_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "extract".transplant
  OWNER TO ukrdc;
GRANT ALL PRIVILEGES on TABLE "extract".transplant TO ukrdc
