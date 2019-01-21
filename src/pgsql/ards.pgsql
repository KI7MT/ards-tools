
/*
    Project .............: ARDS Tools
    Author ..............: Greg, Beam, KI7MT, <ki7mt@yahoo.com>
    Copyright ...........: Copyright (C) 2018 Greg Beam, KI7MT
    License .............: GPL-3

    File ................: utils.sql
    Description .........: Database Utility Views
    Database Type .......: PostgreSQL v10 or later
    Version .............: 0.0.1
    ADIF Specification ..: 3.0.8

    Installation
    
        * Clone the repository

            git clone https://github.com/KI7MT/ards-tools.git
        
        * Change directories and run the sql script

            cd ards-tools\src\pgsql

            psql -v ON_ERROR_STOP=1 -U postgres -f ards.pgsql

*/

--******************************************************************************
-- Enum Schema Utility Views
--******************************************************************************

\echo ''
\echo '-----------------------------------'
\echo 'Reproducing Schema Infor Table'
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

\echo ''
\echo '-----------------------------'
\echo 'Creating Views'
\echo '-----------------------------'

-- Create Test View: adif.adif_table_info_view
CREATE OR REPLACE VIEW ards.schema_info_view AS
    SELECT
        schema_info.schema_name AS "Schema Name",
        schema_info.schema_version AS "Schema Version",
        schema_info.adif_spec AS "ADIF Spec",
        date_trunc('second', schema_info.last_update::TIMESTAMP) AS "Revision Date"
    FROM ards.schema_info;
