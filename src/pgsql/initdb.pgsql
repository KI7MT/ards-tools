/*
    Project .............: ARDS Tools
    Author ..............: Greg, Beam, KI7MT, <ki7mt@yahoo.com>
    Copyright ...........: Copyright (C) 2018 Greg Beam, KI7MT
    License .............: GPL-3

    File ................: initdb.pgsql
    Description .........: ARDS Databases and Users
    Database Type .......: PostgreSQL v11 or later
    Version .............: 0.0.1
    ADIF Specification ..: 0.0.0

    Usage

        This file creates the (ards) Role and Database:

            Role      =  ardsmaster
            Database  =  ardsmaster
            Password  =  Pass@Word

        * Clone the repository

            git clone https://github.com/KI7MT/ards-tools.git
        
        * Change directories and run the sql script

            cd ards-tools\src\pgsql

            psql -v ON_ERROR_STOP=1 -U postgres -f initdb.pgsql
*/

\echo ''
\echo '-----------------------------------------'
\echo  INITIALIZING ARDS DATABASE and ROLES
\echo '-----------------------------------------'
\echo ''

-- -----------------------------------------------------------------------------
-- SESSION TERMINATION
-- -----------------------------------------------------------------------------
SELECT
 pg_terminate_backend (pg_stat_activity.pid)
FROM
 pg_stat_activity
WHERE
 pg_stat_activity.datname = 'ards';

-- -----------------------------------------------------------------------------
-- DATABASE TERMINATION
-- -----------------------------------------------------------------------------
DROP DATABASE IF EXISTS ards;

-- -----------------------------------------------------------------------------
-- ROLE CREATION
-- -----------------------------------------------------------------------------
DROP USER IF EXISTS ards;

CREATE USER ards WITH
	LOGIN
	SUPERUSER
	CREATEDB
	CREATEROLE
	INHERIT
	REPLICATION
	CONNECTION LIMIT -1
	PASSWORD 'ards';
COMMENT ON ROLE ards IS 'Role for ARDS Tools';

-- -----------------------------------------------------------------------------
-- DATABASE CREATION
-- -----------------------------------------------------------------------------

-- ARDS ------------------------------------------------------------------------
CREATE DATABASE ards
    WITH 
    OWNER = ards
    ENCODING = 'UTF8'
    CONNECTION LIMIT = -1;
COMMENT ON DATABASE ards IS 'Database for ARDS Tools';

GRANT ALL ON DATABASE ards TO ards;

-- END DATABASE INITIALIZATION