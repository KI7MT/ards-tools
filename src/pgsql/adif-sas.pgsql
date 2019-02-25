/* 
    Project .............: Amateur Radio Data Serivce Tools
    Author ..............: Greg, Beam, KI7MT, <ki7mt@yahoo.com>
    Copyright ...........: Copyright (C) 2018-2019 Greg Beam, KI7MT
    License .............: GPL-3

    File ................: adif-pas.pgsql
    Description .........: ADIF Secondary Administration Subdivisions
    Database Type .......: PostgreSQL v11 or later
    Version .............: 0.0.1
    ADIF Specification ..: 3.0.9
    ADIF Refrence .......: http://www.adif.org/309/ADIF_309.htm#Enumerations
    Bug Reports .........: https://github.com/KI7MT/ards-tools/issues'

    Comments
    
        This schema implements section III.B.11 of the Amateur Data Interchange
        Format (ADIF) in a 3NF normalized fashion (or close to it). The intent
        is to keep the data-set static and in sync with specification revisions.
        Users should refrain from modifying the data directly unless you are
        willing to accept deviations from the spec.

    Tool Requirments:

        * PostgreSQL v11 or above
        * git for cloning the repository
        * adif uses the default database (postgres) and password (postgres)
          If you want to use a different Role / DB, adjust the commands as needed.

    Installation via pgsql scripts
    
        * Important: This script needs to be run "after" the main
          adif.pgsql script as it does not drop and re-create
          the adif scema.

        * Clone the repository

            git clone https://github.com/KI7MT/ards-tools.git
        
        * Change directories and run the sql script

            cd ards-tools\src\pgsql

            psql -v ON_ERROR_STOP=1 -U ards -f adif-sas.pgsql

    Development Activity and Coding

        Suffix Annotations
        _uq     = Unique Constraint
        _pkey   = Primary Key
        _fkey   = Foreign Key

*/

-- Script Variables
\set name adifsas
\set ver 0.0.1
\set adifv 3.0.9
\echo Generating Schema for ( :name )
\echo '-----------------------------------'

INSERT INTO ards.schema_info(schema_name, schema_version, adif_spec, last_update)
VALUES(:'name', :'ver', :'adifv', CURRENT_TIMESTAMP)
ON CONFLICT (schema_name) DO UPDATE SET schema_version = :'ver',
                                        adif_spec = :'adifv',
                                        last_update = CURRENT_TIMESTAMP;

-- JARL Ku ---------------------------------------------------------------------
-- Japan Century Cities (JCC), SWL - Japan Century Cites (SWL - JCC)
-- Info Link   : https://www.jarl.org/English/4_Library/A-4-2_Awards/Aw_jcc.htm
-- Source Link : https://www.jarl.org/English/4_Library/A-4-5_jcc-jcg/jcc-list.txt
CREATE TABLE adif.jarl_jcc
(
id SERIAL PRIMARY KEY,
prefecture VARCHAR(30) NOT NULL,
CONSTRAINT jarl_jcc_uq UNIQUE(prefecture)
);

CREATE TABLE adif.jarl_jcc_city
(
id SERIAL PRIMARY KEY,
jcc_id INT NOT NULL,
number CHAR(6),
city VARCHAR(30),
is_deleted BOOLEAN NOT NULL DEFAULT '0',
deleted_date date,
CONSTRAINT jarl_jcc_city_uq UNIQUE(number,city)
);
ALTER TABLE adif.jarl_jcc_city ADD CONSTRAINT jarl_jcc_city_jarl_jcc_fkey
    FOREIGN KEY (jcc_id) REFERENCES adif.jarl_jcc (id);

-- RDXC Oblasts ----------------------------------------------------------------
CREATE TABLE adif.rdxc
(
    id SERIAL PRIMARY KEY,
    prefix CHAR(4)
    rdxc_code CHAR(2) NOT NULL,
    oblast VARCHAR(120) NOT NULL,
    id_deleted BOOLEAN NOT NULL DEFAULT '0',
    CONSTRAINT rdxc_uq UNIQUE(prefix,rdxc_code,oblast)
);

CREATE TABLE adif.rdxc_district
(
    id SERIAL PRIMARY KEY,
    rdxc_id INT NOT NULL,
    code CHAR(5) NOT NULL,
    district VARCHAR(120),
    valid_since DATE,
    is_deleted BOOLEAN NOT NULL DEFAULT '0',
    id_new_rda BOOLEAN NOT NULL DEFAULT '0',
    has_replacement BOOLEAN NOT NULL DEFAULT '0',
    migration_district CHAR(5)
    CONSTRAINT rdxc_uq UNIQUE(code,district)
);
ALTER TABLE adif.rdxc_district ADD CONSTRAINT rdxc_district_rdxc_fkey
    FOREIGN KEY (rdxc_id) REFERENCES adif.rdxc (id);
