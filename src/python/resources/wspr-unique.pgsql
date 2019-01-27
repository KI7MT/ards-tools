/* 

    Project .............: ARDS Tools
    Author ..............: Greg, Beam, KI7MT, <ki7mt@yahoo.com>
    Copyright ...........: Copyright (C) 2018 Greg Beam, KI7MT
    License .............: GPL-3

    File ................: wspr-unique.pgsql
    Description .........: Parse unique values from wspr.raw_csv data table
    Database Type .......: PostgreSQL v10 or later
    Version .............: 0.0.1
    ADIF Specification ..: 3.0.9

    Tool Requirments:

    * PostgreSQL v10 or above
    * Access to Curl (Native Linux, WSL, Powershell, WinSSL, other)

    Installation and Usage Instrucitons

    COMMENTS: In order for this script to work and actually generate csv data
              data files, you must have first run the following scripts:

              1. wspr.pgscl         -- Creates tables
              2. wspr-raw.pgsql     -- adds raw csv data from WSPRnet

    1. Clone the repository and generate data tables

        * Clone the repository

            git clone https://github.com/KI7MT/ards-tools.git

    2. In the Terminal, run the following command:

        Win32:
            cd ards-tools\src\pgsql
        
        Linux:
            cd ards-tools/src/pgsql

        Command:
            psql -v ON_ERROR_STOP=1 -U postgres -f wspr-unique.pgsql

*/
\! clear
\echo ''
\echo '----------------------------------------------------'
\echo 'Parse Unique Values (be patient it takes a while)'
\echo '----------------------------------------------------'
\echo ''

-- Callsigns
\echo 'Updating Callsigns'
call wspr.update_rxcall();
call wspr.update_txcall();

-- Grid Squares
\echo ''
\echo 'Updating Gridsquares'
call wspr.update_rxgrid();
call wspr.update_txgrid();

-- Bands
\echo ''
\echo 'Updating Bands'
call wspr.update_band();

-- Software Versions
\echo ''
\echo 'Updating Software Versions'
call wspr.update_software_version();
\echo ''

-- Call the stats view
\echo ''
\echo 'Unique Stats for Extracted Table Data'
\echo ''
select * from wspr.unique_stats;

-- END wsrp-unique.pgsql