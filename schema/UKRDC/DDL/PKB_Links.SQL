CREATE TABLE "extract".pkb_links (
    id integer NOT NULL,
    link varchar,
    link_name varchar,
    coding_standard varchar,
    code varchar,
    PRIMARY KEY (id)
);

ALTER TABLE "extract".pkb_links
  OWNER TO ukrdc;
GRANT ALL PRIVILEGES ON TABLE "extract".pkb_links TO ukrdc;

CREATE SEQUENCE "extract".pkb_links_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE "extract".pkb_links_id_seq OWNER TO ukrdc;

ALTER SEQUENCE "extract".pkb_links_id_seq
  OWNED BY "extract".pkb_links.id;