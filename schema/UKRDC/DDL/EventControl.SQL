-- Table: "extract".eventcontrol

CREATE TABLE "extract".eventcontrol
(
    eventtype character(20) COLLATE pg_catalog."default" NOT NULL,
    eventdate timestamp without time zone NOT NULL,
    pendingeventdate timestamp without time zone,
    CONSTRAINT eventcontrol_pkey PRIMARY KEY (eventtype)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE "extract".eventcontrol
    OWNER to ukrdc;   
    
GRANT ALL PRIVILEGES on TABLE "extract".eventcontrol TO ukrdc;

INSERT INTO "extract".eventcontrol(eventtype, eventdate)
	VALUES ('PVEXTRACT',TIMESTAMP '1970-01-01 00:00:00');
INSERT INTO "extract".eventcontrol(eventtype, eventdate)
	VALUES ('PVSURVEYEXTRACT',TIMESTAMP '1970-01-01 00:00:00');
INSERT INTO "extract".eventcontrol(eventtype, eventdate)
	VALUES ('RADAREXTRACT',TIMESTAMP '1970-01-01 00:00:00');

