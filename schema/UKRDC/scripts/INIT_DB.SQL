-- switch to default database
\c postgres

-- drop and rebuild the database
\i ../DDL/UKRDC4.DDL

-- set search path for this session 
SET search_path TO "$user",extract;

-- build the tables
\i ../SCRIPTS/REBUILD_ALL_TABLES.DDL

-- build the views
\i ../SCRIPTS/REBUILD_ALL_VIEWS.DDL