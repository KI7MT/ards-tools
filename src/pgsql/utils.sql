-- Project .............: ARDS Tools
-- Author ..............: Greg, Beam, KI7MT, <ki7mt@yahoo.com>
-- Copyright ...........: Copyright (C) 2018 Greg Beam, KI7MT
-- License .............: GPL-3

-- File ................: utils.sql
-- Description .........: Database Utility Views
-- Database Type .......: PostgreSQL v10 or later
-- Version .............: 0.0.1
-- ADIF Specification ..: 3.0.8

--******************************************************************************
-- Enum Schema Utility Views
--******************************************************************************

\echo ''
\echo '-----------------------------'
\echo 'Creating User Views'
\echo '-----------------------------'

-- View: utils.vw_view_list
CREATE OR REPLACE VIEW utils.view_list AS
    SELECT
        schemaname AS "Schema",
        viewname AS "View Name"
        FROM pg_catalog.pg_views
        WHERE schemaname NOT IN ('pg_catalog', 'information_schema')
    ORDER BY schemaname, viewname;

-- View: utils.vw_db_size_detail
CREATE OR REPLACE VIEW utils.db_size_view AS
    SELECT
        pg_size_pretty(pg_database_size('postgres')) AS "DB Size";

-- View: utils.vw_db_size_detail
CREATE OR REPLACE VIEW utils.schema_size_view AS
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

\echo ''
\echo 'Finished Creating Utility Views'
\echo 'Version ........: 1.0.0'
\echo 'ADIF Spec ......: 3.0.9'
\echo 'Report Bugs to..: https://github.com/KI7MT/dotnet-core-examples/issues'
\echo ''
\echo 'The following Views Are Available For Use'
select * from utils.view_list;

-- END utils-utility-views.sql