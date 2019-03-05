/*
    Project .............: ARDS Tools
    Author ..............: Greg, Beam, KI7MT, <ki7mt@yahoo.com>
    Copyright ...........: Copyright (C) 2018-2019 Greg Beam, KI7MT
    License .............: GPL-3

    File ................: utils.pgsql
    Description .........: ARDS Tables and Views
    Database Type .......: PostgreSQL v10 or later
    Version .............: 0.0.1
    ADIF Specification ..: 3.0.8

    Installation
    
        * Clone the repository

            git clone https://github.com/KI7MT/ards-tools.git
        
        * Change directories and run the sql script

            cd ards-tools\src\pgsql

            psql -v ON_ERROR_STOP=1 -U ards -d ards -f pgsql
*/

--******************************************************************************
-- Enum Schema Utility Views
--******************************************************************************

-- Script variables
\set name ards
\set ver 0.0.1
\set adifv 0.0.0
\echo Generating Schema  ( :name )
\echo '-----------------------------------'

-- Drop, and re-create schema
DROP SCHEMA IF EXISTS ards CASCADE;

-- Create New Schema
CREATE SCHEMA ards;

--ARDS Schema Information table
CREATE TABLE ards.schema_info
(
    schema_name VARCHAR(10),
    schema_version VARCHAR(10),
    adif_spec VARCHAR(10),
    last_update TIMESTAMP DEFAULT NOW(),
    CONSTRAINT schema_info_schema_name_pkey PRIMARY KEY (schema_name)
);

CREATE OR REPLACE VIEW ards.view_schema_info AS
    SELECT
        schema_info.schema_name AS "Schema Name",
        schema_info.schema_version AS "Schema Version",
        schema_info.adif_spec AS "ADIF Spec",
        date_trunc('second', schema_info.last_update::TIMESTAMP) AS "Create Date"
    FROM ards.schema_info
    ORDER BY ards.schema_info.schema_name;
    
-- View: utils.vw_view_list
CREATE OR REPLACE VIEW ards.view_list AS
    SELECT
        schemaname AS "Schema",
        viewname AS "View Name"
        FROM pg_catalog.pg_views
        WHERE schemaname NOT IN ('pg_catalog', 'information_schema')
    ORDER BY schemaname, viewname;

-- View: utils.view_db_size
CREATE OR REPLACE VIEW ards.view_db_size AS
    SELECT
        pg_size_pretty(pg_database_size('ards')) AS "Database Size";

-- View: utils.view_schema_size
CREATE OR REPLACE VIEW ards.view_schema_size AS
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

-- Insert ards data
INSERT INTO ards.schema_info(schema_name, schema_version, adif_spec, last_update)
VALUES(:'name', :'ver', :'adifv', CURRENT_TIMESTAMP)
ON CONFLICT (schema_name) DO UPDATE SET schema_version = :'ver',
                                        adif_spec = :'adifv',
                                        last_update = CURRENT_TIMESTAMP;

-- *****************************************************************************
--  FOOTER - Finished
-- *****************************************************************************
\echo ''
SELECT * FROM ards.view_schema_info WHERE view_schema_info."Schema Name" = :'name';