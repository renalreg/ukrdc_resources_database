
CREATE TABLE "extract".code_list (
    CODING_STANDARD varchar(256),
    CODE varchar(256),
    DESCRIPTION varchar(256),
    OBJECT_TYPE varchar(256),
    UNITS varchar(256),
    PKB_REFERENCE_RANGE varchar(10),
    PKB_COMMENT text,
    CONSTRAINT code_list_pkey PRIMARY KEY (CODING_STANDARD, CODE)
);

ALTER TABLE "extract".code_list
  OWNER TO ukrdc;
GRANT ALL PRIVILEGES ON TABLE extract.code_list to ukrdc;

