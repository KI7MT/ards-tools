/* 

    Project .............: ARDS Tools
    Author ..............: Greg, Beam, KI7MT, <ki7mt@yahoo.com>
    Copyright ...........: Copyright (C) 2018 Greg Beam, KI7MT
    License .............: GPL-3

    File ................: lotw.sql
    Description .........: Script to import LoTW Active user csv file
    Database Type .......: PostgreSQL v10 or later
    Version .............: 0.0.1
    ADIF Specification ..: 3.0.9

    Tool Requirments:

    * PostgreSQL v10 or above
    * Access to Curl (Native Linux, WSL, Powershell, WinSSL, other)

    Installation and Usage Instrucitons
    
    1. Download and update table for lotw-user-activity.csv

        * Clone the repository

            git clone https://github.com/KI7MT/ards-tools.git

        * Update Commands:

            Win32
                cd /d ards-tools\src\pgsql
                set url=https://lotw.arrl.org/lotw-user-activity.csv
                curl -o lotw/lotw-user-activity.csv %url%            

            Linux | MacOS | Posix
                cd ards-tools/src/pgsql
                url="https://lotw.arrl.org/lotw-user-activity.csv"
                curl -o lotw/lotw-user-activity.csv "$url"

    2. In the Terminal, run the following command:

       psql -v ON_ERROR_STOP=1 -U postgres -f lotw.pgsql

    3. After installation, run the following query to test the installaiton:

       psql -U postgres -c "select * from lotw.lotw_test_view"

*/

-- *****************************************************************************
--  BEGIN TABLE GENERATION and IMPORT
-- *****************************************************************************

\set name lotw
\set ver 0.0.2
\set adifv 3.0.9

\echo ''
\echo '-----------------------------------'
\echo 'Regenerating LoTW Schema'
\echo '-----------------------------------'

-- Drop, and re-create schema
DROP SCHEMA IF EXISTS lotw CASCADE;

-- Create New Schema
CREATE SCHEMA lotw;

INSERT INTO ards.schema_info(schema_name, schema_version, adif_spec, last_update)
VALUES(:'name', :'ver', :'adifv', CURRENT_TIMESTAMP)
ON CONFLICT (schema_name) DO UPDATE SET schema_version = :'ver',
                                        adif_spec = :'adifv',
                                        last_update = CURRENT_TIMESTAMP;

-- LoTW Active Users
CREATE TABLE lotw.lotw_activity
(
    callsign TEXT NOT NULL,
    last_update DATE NOT NULL,
    last_time TIME NOT NULL,
    CONSTRAINT lotw_activity_callsign_pkey PRIMARY KEY (callsign)
);

-- Copy the CSV into LOTW Schema
\COPY lotw.lotw_activity FROM 'lotw/lotw-user-activity.csv' DELIMITER ',' QUOTE '"' CSV HEADER;

-- Create Test View: lotw.lotw_test_view
CREATE OR REPLACE VIEW lotw.lotw_test_view AS
    SELECT
        lotw_activity.callsign AS "Callsign",
        lotw_activity.last_update AS "Last Update",
        lotw_activity.last_time AS "Time"
    FROM lotw.lotw_activity
        WHERE last_update > '2018-12-1' AND last_update < '2019-01-31'
        ORDER BY last_update DESC,
            last_time DESC
        LIMIT 10;

\echo ''
\echo '-----------------------------------'
\echo 'Running Query lotw.lotw_test_view'
\echo '-----------------------------------'
\echo ''
select * from lotw.lotw_test_view;

-- *****************************************************************************
--  FOOTER - Finished
-- *****************************************************************************
\echo ''
\echo Finished Creating ARDS Schema for ( :name )
\echo ''
\echo 'Schema Informaiton'
\echo ''
SELECT * FROM ards.schema_info_view WHERE schema_info_view."Schema Name" = :'name';
\echo

-- END: lotw.sql