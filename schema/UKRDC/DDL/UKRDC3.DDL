-- Database: "UKRDC3"

-- This script to be run before the rest of the scripts

DROP DATABASE IF EXISTS "UKRDC3";

CREATE DATABASE "UKRDC3"
  WITH OWNER = ukrdc
       ENCODING = 'UTF8'
       TABLESPACE = pg_default
       CONNECTION LIMIT = -1;

-- Connect to database 
\c UKRDC3

CREATE SCHEMA "extract"
  AUTHORIZATION ukrdc;

GRANT ALL ON SCHEMA "extract" TO ukrdc;

GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA extract TO ukrdc;

ALTER DATABASE "UKRDC3" SET search_path TO "$user",extract;
