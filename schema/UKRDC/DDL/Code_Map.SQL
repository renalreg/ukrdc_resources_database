CREATE TABLE "extract".code_map (
    source_coding_standard varchar(256),
    source_code varchar(256),
    destination_coding_standard varchar(256),
    destination_code varchar(256),
    creation_date timestamp without time zone DEFAULT now() NOT NULL,
    update_date timestamp without time zone,
    CONSTRAINT code_map_pkey PRIMARY KEY (source_coding_standard, source_code, destination_coding_standard, destination_code)
);
ALTER TABLE "extract".code_map
  OWNER TO ukrdc;
GRANT ALL PRIVILEGES ON TABLE "extract".code_map TO ukrdc;
