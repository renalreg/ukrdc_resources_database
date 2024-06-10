-- Table: "extract".address

CREATE TABLE "extract".validationerror
(
  vid SERIAL,
  pid character varying(30) NOT NULL,
  updatedon timestamp without time zone,
  errortype int NOT NULL,
  message character varying(200),
  CONSTRAINT validationerror_pkey PRIMARY KEY (vid)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "extract".validationerror
OWNER TO ukrdc;
GRANT ALL PRIVILEGES on TABLE "extract".validationerror TO ukrdc
