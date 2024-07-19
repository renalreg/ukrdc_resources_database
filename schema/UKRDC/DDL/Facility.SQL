-- Table: "extract".facility

CREATE TABLE "extract".facility (
    code               varchar(256) CONSTRAINT pk_facility PRIMARY KEY,
    pkb_out            BOOLEAN default false,
    pkb_in             BOOLEAN default false,
	ukrdc_out_pkb	   BOOLEAN default false,
	pv_out_pkb		   BOOLEAN default false,
    pkb_msg_exclusions TEXT []
);

ALTER TABLE "extract".facility
  OWNER TO ukrdc;
GRANT ALL PRIVILEGES ON TABLE extract. facility TO ukrdc;
