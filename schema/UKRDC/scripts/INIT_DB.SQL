-- switch to default database
\c postgres

-- drop and rebuild the database
\i ../DDL/UKRDC3.DDL

-- build the tables
\i ../SCRIPTS/REBUILD_ALL_TABLES.DDL

-- build the views
\i ../SCRIPTS/REBUILD_ALL_VIEWS.DDL