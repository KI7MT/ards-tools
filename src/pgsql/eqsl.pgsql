/* 

    Project .............: ARDS Tools
    Author ..............: Greg, Beam, KI7MT, <ki7mt@yahoo.com>
    Copyright ...........: Copyright (C) 2018 Greg Beam, KI7MT
    License .............: GPL-3

    File ................: eqsl
    Description .........: Script to import eqsl text file
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
                set url=http://www.eqsl.cc/qslcard/DownloadedFiles/AGMemberListDated.txt
                curl -o eqsl/AGMemberListDated.txt %url%
                awk -F '[[:space:]]*,[[:space:]]*' '{$1=$1}1' OFS=, eqsl\AGMemberListDated.txt > eqsl\tmp.txt
                sed -i -e 's/0000\-00\-00/1900\-01\-01/' eqsl\tmp.txt

            Linux | MacOS | Posix
                cd ards-tools/src/pgsql
                url="http://www.eqsl.cc/qslcard/DownloadedFiles/AGMemberListDated.txt"
                curl -o eqsl/AGMemberListDated.txt "$url"
                awk -F '[[:space:]]*,[[:space:]]*' '{$1=$1}1' OFS=, eqsl/AGMemberListDated.txt > eqsl/tmp.txt

    2. In the Terminal, run the following command:

       psql -v ON_ERROR_STOP=1 -U postgres -f eqsl.pgsql

    3. After installation, run the following query to test the installaiton:

       psql -U postgres -c "select * from eqsl.eqsl_test_view"

*/

-- *****************************************************************************
--  BEGIN TABLE GENERATION and IMPORT
-- *****************************************************************************


\echo ''
\echo '-----------------------------------'
\echo 'Regenerating eQSL Schema'
\echo '-----------------------------------'

-- Drop, and re-create schema
DROP SCHEMA IF EXISTS eqsl CASCADE;

-- Create New Schema
CREATE SCHEMA eqsl;

-- LoTW Active Users
CREATE TABLE eqsl.eqsl_ag
(
    callsign TEXT NOT NULL,
    last_update DATE NOT NULL,
    CONSTRAINT leqsl_ag_callsign_pkey PRIMARY KEY (callsign)
);

-- Copy the CSV into LOTW Schema
\COPY eqsl.eqsl_ag FROM 'eqsl/tmp.txt' DELIMITER ',' CSV HEADER;

-- Create Test View: eqsl.eqsl_test_view
CREATE OR REPLACE VIEW eqsl.eqsl_test_view AS
    SELECT
        eqsl_ag.callsign AS "Callsign",
        eqsl_ag.last_update AS "Last Update"
    FROM eqsl.eqsl_ag
        WHERE last_update > '2018-12-1' AND last_update < '2019-01-31'
        ORDER BY last_update DESC
        LIMIT 10;

\echo ''
\echo '-----------------------------------'
\echo 'Running Query eqsl.eqsl_test_view'
\echo '-----------------------------------'
\echo ''
select * from eqsl.eqsl_test_view;
\echo 'Finished !!'

-- END: eqsl.sql