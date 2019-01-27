/*
    Project .............: ARDS Tools
    Author ..............: Greg, Beam, KI7MT, <ki7mt@yahoo.com>
    Copyright ...........: Copyright (C) 2018 Greg Beam, KI7MT
    License .............: GPL-3

    File ................: initdb.pgsql
    Description .........: ARDS Tables and Views
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

-- Script variables
\set name ards
\set user ards
\set ver 0.0.1
\set adifv 3.0.9

\echo ''
\echo '-----------------------------------------'
\echo Ctreating Database and Rols for ( :name )
\echo '-----------------------------------------'
\echo ''

-- terminate any current activity
SELECT
 pg_terminate_backend (pg_stat_activity.pid)
FROM
 pg_stat_activity
WHERE
 pg_stat_activity.datname = 'ards';

-- drop the db
DROP DATABASE IF EXISTS ards;

-- drop the user / role
DROP USER IF EXISTS ards;

-- create new role / user
CREATE USER ards WITH
	LOGIN
	SUPERUSER
	CREATEDB
	CREATEROLE
	INHERIT
	REPLICATION
	CONNECTION LIMIT -1
	PASSWORD 'Pass@Word';
COMMENT ON ROLE :name IS 'Role for ARDS Tools';

-- create database and assign privilages to ardsmaster
CREATE DATABASE ards
    WITH 
    OWNER = ards
    ENCODING = 'UTF8'
    CONNECTION LIMIT = -1;
COMMENT ON DATABASE :name IS 'Databases for ARDS Tools';

GRANT ALL ON DATABASE ards TO ards;