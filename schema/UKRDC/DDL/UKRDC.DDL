-- Database: "UKRDC"

-- This script to be run before the rest of the scripts
DROP DATABASE IF EXISTS "UKRDC";
DROP ROLE IF EXISTS ukrdc;

CREATE ROLE ukrdc;

CREATE DATABASE "UKRDC"
  WITH OWNER = ukrdc
       ENCODING = 'UTF8'
       TABLESPACE = pg_default
       CONNECTION LIMIT = -1;

  
-- Connect to database 
\c UKRDC

CREATE SCHEMA "extract"
  AUTHORIZATION ukrdc;

GRANT ALL ON SCHEMA "extract" TO ukrdc;

GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA extract TO ukrdc;

-- set search path for the database 
ALTER DATABASE "UKRDC" SET search_path TO "$user",extract;