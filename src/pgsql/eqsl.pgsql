/* 

    Project .............: ARDS Tools
    Author ..............: Greg, Beam, KI7MT, <ki7mt@yahoo.com>
    Copyright ...........: Copyright (C) 2018-2019 Greg Beam, KI7MT
    License .............: GPL-3

    File ................: eqsl
    Description .........: eQSL Tables and views
    Database Type .......: PostgreSQL v10 or later
    Version .............: 0.0.1
    ADIF Specification ..: 3.0.9

    Tool Requirments:

    * PostgreSQL v10 or above
    * Access to Curl (Native Linux, WSL, Powershell, WinSSL, other)

    Installation and Usage Instrucitons
    
    1. Download and update table for AGMemberListDated.txt

        * Clone the repository

            git clone https://github.com/KI7MT/ards-tools.git

        * Update Commands:

            Win32 (copy and paste the commands)
                cd /d ards-tools\src\pgsql
                mkdir eqsl
                set url=http://www.eqsl.cc/qslcard/DownloadedFiles/AGMemberListDated.txt
                curl -o eqsl/AGMemberListDated.txt %url%
                awk -F '[[:space:]]*,[[:space:]]*' '{$1=$1}1' OFS=, eqsl\AGMemberListDated.txt > eqsl\tmp.txt
                sed -i -e 's/0000\-00\-00/1900\-01\-01/' eqsl\tmp.txt

            Linux | MacOS | Posix

                Note: The line numbers may change that need editing. This is a temporary workaround
 
                cd ards-tools/src/pgsql
                bash update-eqsl.sh


    2. In the Terminal, run the following command:

       psql -v ON_ERROR_STOP=1 -U postgres -f eqsl.pgsql

    3. After installation, run the following query to test the installaiton:

       psql -U postgres -c "select * from eqsl.view_eqsl_test"

*/

-- *****************************************************************************
--  BEGIN TABLE GENERATION and IMPORT
-- *****************************************************************************

-- Script Variables
\set name eqsl
\set ver 0.0.1
\set adifv 0.0.0
\echo ''
\echo Generating Schema for ( :name )
\echo '-----------------------------------'

-- Drop, and re-create schema
DROP SCHEMA IF EXISTS :name CASCADE;

-- Create New Schema
CREATE SCHEMA :name;

-- Eqsl Active Users
CREATE TABLE eqsl.eqsl_ag
(
    callsign TEXT NOT NULL,
    last_update DATE,
    CONSTRAINT eqsl_ag_callsign_pkey PRIMARY KEY (callsign)
);

-- Create Test View: eqsl.view_eqsl_test
-- TODO: Covert this view to a function
CREATE OR REPLACE VIEW eqsl.view_eqsl_test AS
    SELECT
        eqsl_ag.callsign AS "Callsign",
        eqsl_ag.last_update AS "Last Update"
    FROM eqsl.eqsl_ag
        WHERE last_update > '2018-12-1' AND last_update < '2019-01-31'
        ORDER BY last_update DESC
        LIMIT 10;

-- Only import Data during Development testing
-- Copy the CSV into LOTW Schema
\COPY eqsl.eqsl_ag FROM 'eqsl/tmp.txt' DELIMITER ',' CSV HEADER;

-- *****************************************************************************
--  FOOTER - Finished
-- *****************************************************************************

INSERT INTO ards.schema_info(schema_name, schema_version, adif_spec, last_update)
VALUES(:'name', :'ver', :'adifv', CURRENT_TIMESTAMP)
ON CONFLICT (schema_name) DO UPDATE SET schema_version = :'ver',
                                        adif_spec = :'adifv',
                                        last_update = CURRENT_TIMESTAMP;

\echo
--SELECT * FROM ards.view_schema_info WHERE view_schema_info."Schema Name" = :'name';

-- END: eqsl.pgsql
