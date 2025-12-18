-- Table: "extract".laborder

CREATE TABLE "extract".laborder
(
  id character varying(100) NOT NULL,
  pid character varying(30) NOT NULL,
  placerid character varying(100),
  fillerid character varying(100),
  receivinglocationcode character varying(100),
  receivinglocationcodestd character varying(100),
  receivinglocationdesc character varying(100),
  orderedbycode character varying(100),
  orderedbycodestd character varying(100),
  orderedbydesc character varying(100),
  orderitemcode character varying(100),
  orderitemcodestd character varying(100),
  orderitemdesc character varying(100),
  prioritycode character varying(100),
  prioritycodestd character varying(100),
  prioritydesc character varying(100),
  status character varying(100),
  ordercategorycode character varying(100),
  ordercategorycodestd character varying(100),
  ordercategorydesc character varying(100),
  specimensource character varying(50),
  specimenreceivedtime timestamp without time zone,
  specimencollectedtime timestamp without time zone,
  duration character varying(50),
  patientclasscode character varying(100),
  patientclasscodestd character varying(100),
  patientclassdesc character varying(100),
  enteredon timestamp without time zone,
  enteredatcode character varying(100),
  enteredatcodestd character varying(100),
  enteredatdesc character varying(100),
  enteringorganizationcode character varying(100),
  enteringorganizationcodestd character varying(100),
  enteringorganizationdesc character varying(100),
  updatedon timestamp without time zone,
  actioncode character varying(3),
  externalid character varying(100),
  creation_date timestamp without time zone DEFAULT now() NOT NULL,
  update_date timestamp without time zone,
  repository_update_date timestamp without time zone,
  CONSTRAINT order_pkey PRIMARY KEY (id),
  CONSTRAINT laborder_pid_fkey
    FOREIGN KEY (pid)
    REFERENCES "extract".patientrecord(pid)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "extract".laborder
  OWNER TO ukrdc;
GRANT ALL PRIVILEGES ON TABLE "extract".laborder TO ukrdc;

-- keep or drop this as you prefer
CREATE INDEX order_id
    ON "extract".laborder USING btree
    (id COLLATE pg_catalog."default")
    TABLESPACE pg_default;
