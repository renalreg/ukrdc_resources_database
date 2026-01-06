
CREATE TABLE "extract".code_list (
    coding_standard varchar(256),
    code varchar(256),
    description varchar(256),
    object_type varchar(256),
    units varchar(256),
    pkb_reference_range varchar(10),
    pkb_comment text,
    creation_date timestamp without time zone DEFAULT now() NOT NULL,
    update_date timestamp without time zone,
    CONSTRAINT code_list_pkey PRIMARY KEY (coding_standard, code)
);

ALTER TABLE "extract".code_list
  OWNER TO ukrdc;
GRANT ALL PRIVILEGES ON TABLE extract.code_list to ukrdc;

