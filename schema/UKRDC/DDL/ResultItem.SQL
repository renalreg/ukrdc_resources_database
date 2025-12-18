-- Table: "extract".resultitem

CREATE TABLE "extract".resultitem
(
  id character varying(100) NOT NULL,
  orderid character varying(100) NOT NULL,
  resulttype character varying(2),
  serviceidcode character varying(100),
  serviceidcodestd character varying(100),
  serviceiddesc character varying(100),
  subid character varying(50),
  resultvalue character varying(30),
  resultvalueunits character varying(30),
  referencerange character varying(30),
  interpretationcodes character varying(50),
  status character varying(5),
  observationtime timestamp without time zone,
  commenttext character varying(1000),
  referencecomment character varying(1000),
  prepost character varying(4),
  enteredon timestamp without time zone,
  updatedon timestamp without time zone,
  actioncode character varying(3),
  externalid character varying(100),
  creation_date timestamp without time zone DEFAULT now() NOT NULL,
  update_date timestamp without time zone,
  CONSTRAINT resultitem_pkey PRIMARY KEY (id),
  CONSTRAINT resultitem_orderid_fkey
    FOREIGN KEY (orderid)
    REFERENCES "extract".laborder(id)
)
WITH (
  OIDS=FALSE
);

ALTER TABLE "extract".resultitem
  OWNER TO ukrdc;
GRANT ALL PRIVILEGES ON TABLE "extract".resultitem TO ukrdc;

CREATE INDEX resultitem_orderid
  ON "extract".resultitem USING btree
  (orderid COLLATE pg_catalog."default")
  TABLESPACE pg_default;