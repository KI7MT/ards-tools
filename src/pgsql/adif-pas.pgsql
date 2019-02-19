/* 
    Project .............: Amateur Radio Data Serivce Tools
    Author ..............: Greg, Beam, KI7MT, <ki7mt@yahoo.com>
    Copyright ...........: Copyright (C) 2018-2019 Greg Beam, KI7MT
    License .............: GPL-3

    File ................: adif-pas.pgsql
    Description .........: ADIF Primary Administration Subdivisions
    Database Type .......: PostgreSQL v10 or later
    Version .............: 0.0.1
    ADIF Specification ..: 3.0.9
    ADIF Refrence .......: http://www.adif.org/309/ADIF_309.htm#Enumerations
    Bug Reports .........: https://github.com/KI7MT/ards-tools/issues'

    Comments
    
        This schema implements section III.B of the Amateur Data Interchange
        Format (ADIF) in a 3NF normalized fashion (or close to it). The intent
        is to keep the data-set static and in sync with specification revisions.
        Users should refrain from modifying the data directly unless you are
        willing to accept deviations from the spec.

    Tool Requirments:

        * PostgreSQL v10 or above
        * git for cloning the repository
        * adif uses the default database (postgres) and password (postgres)
          If you want to use a different Role / DB, adjust the commands as needed.

    Installation via pgsql scripts
    
        * Clone the repository

            git clone https://github.com/KI7MT/ards-tools.git
        
        * Change directories and run the sql script

            cd ards-tools\src\pgsql

            psql -v ON_ERROR_STOP=1 -U ards -f adif-pas.pgsql

    Development Activity and Coding

        Suffix Annotations
        _uq     = Unique Constraint
        _pkey   = Primary Key
        _fkey   = Foreign Key

        TODO: Need adif.pas and adif.sas CSV Data files
        TODO: Add adif.sas FK's after adif.pas has been populated.
        TODO: Add Japan JCC, JGC, KU Tables and List CSV Data
        TODO: Need JCC, JGC, and KU CSV Datafiles
        TODO: Add Source Data Table: souce_data_info

*/

-- Script Variables
\set name adif-pas
\set ver 0.0.1
\set adifv 3.0.9
\echo Generating Schema for ( :name )
\echo '-----------------------------------'

-- Drop, and re-create schema
DROP SCHEMA IF EXISTS :name CASCADE;

-- Create New Schema
CREATE SCHEMA :name;

INSERT INTO ards.schema_info(schema_name, schema_version, adif_spec, last_update)
VALUES(:'name', :'ver', :'adifv', CURRENT_TIMESTAMP)
ON CONFLICT (schema_name) DO UPDATE SET schema_version = :'ver',
                                        adif_spec = :'adifv',
                                        last_update = CURRENT_TIMESTAMP;

-- *****************************************************************************
--
-- PRIMARY ADMINISTRATIVE ENUMERATIONS
--
-- *****************************************************************************

-- Primary Administration Subdivision
-- id is the same as dxcc.id
-- TODO: FK pas_subdivision_type_id REFERENCES adif.pas_subdivision_type (id)
-- TOFO: FK sas_subdivision_type_id REFERENCED adif.sas_subdivision_type (id) 
-- TODO: Need CSV Table
--    CHECK ( NOT (has_oblast AND oblast_id IS NULL) )
--    CHECK ( NOT (has_sas AND sas_subdivision_type_id IS NULL) )
CREATE TABLE adif.pas_summary
(
    id INT PRIMARY KEY,
    dxcc_id INT NOT NULL,
    pas_subdivision_type_id INT NOT NULL,
    has_oblast BOOLEAN NOT NULL DEFAULT '0',
    has_sas BOOLEAN NOT NULL DEFAULT '0',
    sas_subdivision_type_id INT,
    CHECK ( NOT (has_sas AND sas_subdivision_type_id IS NULL) )
); 

-- Primary Administration Subdivision
-- TODO: Need CSV Table
CREATE TABLE adif.pas_subdivision_type
(
    id SERIAL PRIMARY KEY,
    subdivision VARCHAR(20) NOT NULL,
    CONSTRAINT psa_subdivision_type_uq UNIQUE (subdivision)
);

-- Secondary Administration Subdivision
-- TODO: Need CSV Table
CREATE TABLE adif.sas_subdivision_type
(
    id SERIAL PRIMARY KEY,
    subdivision VARCHAR(20) NOT NULL,
    CONSTRAINT sas_subdivision_type_uq UNIQUE (subdivision)
);

-- 1 Canada
-- 5 Aland Is.
-- 6 Alaska
-- 15 Asiatic Russia
-- 21 Beleric Is.
-- 27 Belarus
-- 29 Canary Is.
-- 32 Cetua & Melilla
-- 50 Mexico
-- 52 Estonia
-- 54 European Russia
-- 61 Franz Josef Land
-- 70 Cuba
-- 74 El Salvador
-- 86 Nicaragua
-- 100 Argintina
-- 104 Bolivia
-- 108 Brazil
-- 110 Hawaii
-- 112 Chile
-- 126 Kalingrad
-- 130 Kazakhstan
-- 132 Paraguay
-- 137 Republic of Korea
-- 138 Kure
-- 144 Uruguay
-- 147 Lord Howe Is.
-- 148 Venezuela
-- 149 Azores
-- 150 Australia
-- 151 Malyj Vysotski Is
-- 153 Macquarie Is.
-- 163 Papua New Guinea
-- 170 New Zeland
-- 177 Minami Torishima
-- 179 Moldova
-- 192 Ogasawara
-- 206 Austria
-- 209 Belgium
-- 212 Bulgaria
-- 214 Corsica
-- 221 Denmark
-- 224 Finland
-- 225 Sardinia
-- 227 France
-- 230 Fed. Rep. of Germany
-- 239 Hungary
-- 245 Finland
-- 248 Italy
-- 256 Maderia Is.
-- 263 

-- *****************************************************************************
--  ADD CSV DATA
-- *****************************************************************************

-- NOTE(s): 
--  1. Delimiter for dxc_entity is "|" due to comma's in 'name' column
--  2. All other CSV files use ',' delimiters with double-quote escapes

\echo
\echo 'Importing CSV Files'
\echo '---------------------------'

-- *****************************************************************************
--  ADD FOREIGN KEYS
-- *****************************************************************************

\echo
\echo 'Adding Foreign Keys'
\echo '---------------------------'


-- *****************************************************************************
--  ADD INDEXES based on z-tools\index-reccomend2.sql
-- *****************************************************************************

\echo
\echo 'Creating Foreign Key Indexes'
\echo '-----------------------------'


-- *****************************************************************************
--  VIEWS
-- *****************************************************************************

\echo
\echo 'Creating Views'
\echo '-----------------------------'

-- View: adif.vw_contest
-- Note: the pas_summary.id is the dxcc.id
CREATE OR REPLACE VIEW adif.view_psa_summary AS
    SELECT
        pas_summary.id AS "DXCC Code",
        dxcc.name AS "Country",
        pas_subdivision_type.subdivision AS "Pri. Subdivision",
        pas_summary.has_oblast AS "Has Oblast",
        pas_summary.has_sas AS "Has Secondary",
        sas_subdivision_type.subdivision AS "Sec. Subdivision"
    FROM adif.pas_summary
        LEFT JOIN adif.dxcc ON
            adif.dxcc.id = adif.pas_summary.id
        LEFT JOIN adif.pas_subdivision_type ON
            adif.pas_summary.id = adif.pas_subdivision_type.id
        LEFT JOIN adif.sas_subdivision_type ON
            adif.pas_summary.id = adif.sas_subdivision_type.id
    ORDER BY pas_summary.id;


-- *****************************************************************************
--  FOOTER
-- *****************************************************************************
\echo
SELECT * FROM ards.view_schema_info WHERE view_schema_info."Schema Name" = :'name';

-- END adif.sql