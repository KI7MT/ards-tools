/*
    Project .............: ARDS Tools
    Author ..............: Greg, Beam, KI7MT, <ki7mt@yahoo.com>
    Copyright ...........: Copyright (C) 2018 Greg Beam, KI7MT
    License .............: GPL-3

    File ................: utils.pgsql
    Description .........: Database Utility Views
    Database Type .......: PostgreSQL v10 or later
    Version .............: 0.0.1
    ADIF Specification ..: 3.0.8

    Installation
    
        * Clone the repository

            git clone https://github.com/KI7MT/ards-tools.git
        
        * Change directories and run the sql script

            cd ards-tools\src\pgsql

            psql -v ON_ERROR_STOP=1 -U postgres -f utils.pgsql

*/

--******************************************************************************
-- Enum Schema Utility Views
--******************************************************************************

-- Script variables
\set name utils
\set ver 0.0.1
\set adifv 3.0.9
\echo Generating Schema for ( :name )
\echo '-----------------------------------'

-- Drop, and re-create schema
DROP SCHEMA IF EXISTS :name CASCADE;

-- Create New Schema
CREATE SCHEMA :name;

INSERT INTO schema_info(schema_name, schema_version, adif_spec, last_update)
VALUES(:'name', :'ver', :'adifv', CURRENT_TIMESTAMP)
ON CONFLICT (schema_name) DO UPDATE SET schema_version = :'ver',
                                        adif_spec = :'adifv',
                                        last_update = CURRENT_TIMESTAMP;

-- View: utils.vw_view_list
CREATE OR REPLACE VIEW utils.view_list AS
    SELECT
        schemaname AS "Schema",
        viewname AS "View Name"
        FROM pg_catalog.pg_views
        WHERE schemaname NOT IN ('pg_catalog', 'information_schema')
    ORDER BY schemaname, viewname;

-- View: utils.view_db_size
CREATE OR REPLACE VIEW utils.view_db_size AS
    SELECT
        pg_size_pretty(pg_database_size('adif')) AS "Database Size";

-- View: utils.view_schema_size
CREATE OR REPLACE VIEW utils.view_schema_size AS
    SELECT schema_name, 
        pg_size_pretty(sum(table_size)::BIGINT),
        trunc((sum(table_size) / pg_database_size(current_database())) * 100, 2) AS percent
    FROM (
        SELECT pg_catalog.pg_namespace.nspname AS schema_name,
               pg_relation_size(pg_catalog.pg_class.oid) AS table_size
        FROM pg_catalog.pg_class
            JOIN pg_catalog.pg_namespace ON relnamespace = pg_catalog.pg_namespace.oid
    ) t
    GROUP BY schema_name
    ORDER BY schema_name;

-- *****************************************************************************
--  FOOTER - Finished
-- *****************************************************************************
\echo
SELECT * FROM view_schema_info WHERE view_schema_info."Schema Name" = :'name';

-- END utils.sql