-- Table: "extract".familyhistory

CREATE TABLE "extract".familyhistory
(
  id character varying(100) NOT NULL,
  pid character varying(30) NOT NULL,
  idx integer,
  familymembercode character varying(100),
  familymembercodestd character varying(100),
  familymemberdesc character varying(100),
  diagnosiscode character varying(100),
  diagnosiscodestd character varying(100),
  diagnosisdesc character varying(100),
  notetext character varying(100),
  enteredatcode character varying(100),
  enteredatcodestd character varying(100),
  enteredatdesc character varying(100),
  fromtime timestamp without time zone,
  totime timestamp without time zone,
  updatedon timestamp without time zone,
  actioncode character varying(3),
  externalid character varying(100),
  CONSTRAINT familyhistory_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "extract".familyhistory
  OWNER TO ukrdc;
GRANT ALL PRIVILEGES on TABLE "extract".familyhistory TO ukrdc
