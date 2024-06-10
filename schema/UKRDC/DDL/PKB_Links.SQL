CREATE TABLE "extract".pkb_links (
    id INTEGER NOT NULL,
    link VARCHAR,
    link_name VARCHAR,
    coding_standard VARCHAR,
    code VARCHAR,
    PRIMARY KEY (id)
);

ALTER TABLE "extract".pkb_links
  OWNER TO ukrdc;
GRANT ALL PRIVILEGES on TABLE "extract".pkb_links TO ukrdc;
