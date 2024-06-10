-- Table: "extract".medication

CREATE TABLE "extract".medication
(
  id character varying(150) NOT NULL,
  pid character varying(30) NOT NULL,
  idx integer,
  prescriptionnumber character varying(100),
  fromtime timestamp without time zone,
  totime timestamp without time zone,
  orderedbycode character varying(100),
  orderedbycodestd character varying(100),
  orderedbydesc character varying(100),
  enteringorganizationcode character varying(100),
  enteringorganizationcodestd character varying(100),
  enteringorganizationdesc character varying(100),
  routecode character varying(10),
  routecodestd character varying(100),
  routedesc character varying(100),
  drugproductidcode character varying(100),
  drugproductidcodestd character varying(100),
  drugproductiddesc character varying(100),
  drugproductgeneric character varying(255),
  drugproductlabelname character varying(255),
  drugproductformcode character varying(100),
  drugproductformcodestd character varying(100),
  drugproductformdesc character varying(100),
  drugproductstrengthunitscode character varying(100),
  drugproductstrengthunitscodestd character varying(100),
  drugproductstrengthunitsdesc character varying(100),
  frequency character varying(50),
  commenttext character varying(1000),
  dosequantity numeric(19,2),
  doseuomcode character varying(100),
  doseuomcodestd character varying(100),
  doseuomdesc character varying(100),
  indication character varying(100),
  encounternumber character varying(100),
  repositoryupdatedate timestamp without time zone NOT NULL,
  updatedon timestamp without time zone,
  actioncode character varying(3),
  externalid character varying(100),
  CONSTRAINT medication_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "extract".medication
  OWNER TO ukrdc;
GRANT ALL PRIVILEGES on TABLE "extract".medication TO ukrdc;