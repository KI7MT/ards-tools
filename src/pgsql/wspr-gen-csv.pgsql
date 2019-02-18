/* 

    Project .............: ARDS Tools
    Author ..............: Greg, Beam, KI7MT, <ki7mt@yahoo.com>
    Copyright ...........: Copyright (C) 2018 Greg Beam, KI7MT
    License .............: GPL-3

    File ................: wspr-gen-csv.pgsql
    Description .........: Generate csv's for: callsign, grid, band SW version
    Database Type .......: PostgreSQL v10 or later
    Version .............: 0.0.1
    ADIF Specification ..: 3.0.9

    Tool Requirments:

    * PostgreSQL v10 or above
    * Access to Curl (Native Linux, WSL, Powershell, WinSSL, other)

    Installation and Usage Instrucitons

    COMMENTS: In order for this script to work and actually generate csv data
              data files, you must have first run the following scripts:

              1. wspr.pgsql         -- Creates tables
              2. wspr-raw.pgsql     -- adds raw csv data from WSPRnet
              3. wspr-unique.pgsql  -- Parse Unique vaues into tables

              After running the above scripts, you can then generate CSV files
              for the following tables:

              1. callsign           -- Unique Callsignes found WSPRNet CSV files
              2. grid               -- Unique Gridsquares found WSPRNet CSV files
              3. band               -- Unique Bands found in WSPRNet CSV files
              4. software_version   -- Ubuque SW Versions found in WSPRnet files

    1. Download and update table for wsprspots-year-month.csv

        * Clone the repository

            git clone https://github.com/KI7MT/ards-tools.git

    2. In the Terminal, run the following command:

       psql -v ON_ERROR_STOP=1 -U postgres -f wspr-gen-csv.pgsql

    3. After installation, run the following query to test the installation:

       psql -U postgres -c "select * from wspr.wspr_test_view"

*/
\set name wspr
\set ver 0.0.1
\set adifv 0.0.0

\! clear
\echo ''
\echo '-------------------------------------'
\echo Generating CSV Files for ( :name )
\echo '-------------------------------------'
\echo ''
\echo 'Callsigns'
\COPY wspr.callsign TO 'wspr/wspr-callsign.csv' WITH (FORMAT CSV, HEADER);
\echo ''
\echo 'Gridsquares'
\COPY wspr.grid TO 'wspr/wspr-grid.csv' WITH (FORMAT CSV, HEADER);
\echo ''
\echo 'Band'
\COPY wspr.band TO 'wspr/wspr-band.csv' WITH (FORMAT CSV, HEADER);
\echo ''
\echo 'SW Version'
\COPY wspr.software_version TO 'wspr/wspr-software.csv' WITH (FORMAT CSV, HEADER);
\echo ''
\echo 'Finished'
