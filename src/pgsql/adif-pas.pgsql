/* 
    Project .............: Amateur Radio Data Serivce Tools
    Author ..............: Greg, Beam, KI7MT, <ki7mt@yahoo.com>
    Copyright ...........: Copyright (C) 2018-2019 Greg Beam, KI7MT
    License .............: GPL-3

    File ................: adif-pas.pgsql
    Description .........: ADIF Primary Administration Subdivisions
    Database Type .......: PostgreSQL v11 or later
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

-- -----------------------------------------------------------------------------
-- Primary Administration Subdivision Summary Tables
-- -----------------------------------------------------------------------------

-- Primary Administration Subdivision
-- TODO: Need CSV Table Data
CREATE TABLE adif.pas_summary
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    pas_subdivision_type_id INT NOT NULL,
    has_oblast BOOLEAN NOT NULL DEFAULT '0',
    has_sas BOOLEAN NOT NULL DEFAULT '0',
    sas_subdivision_type_id INT,
    CHECK ( NOT (has_sas AND sas_subdivision_type_id IS NULL) )
); 

-- Primary Administration Subdivision Type
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

-- Primary Administration Subdivision CQ Zone Link Table
CREATE TABLE adif.pas_cqzone
(
    id SERIAL PRIMARY KEY,
    pas_summary_id INT NOT NULL,
    cq_zone_id INT NOT NULL
);

-- Primary Administration Subdivision ITU Zone Link Table
CREATE TABLE adif.pas_ituzone
(
    id SERIAL PRIMARY KEY,
    pas_summary_id INT NOT NULL,
    itu_zone_id INT NOT NULL
);

-- Primary Administration Subdivision Oblast Link Table
-- TODO: FK for Oblast ID
CREATE TABLE adif.pas_oblast
(
    id SERIAL PRIMARY KEY,
    pas_summary_id INT NOT NULL,
    oblast_id INT NOT NULL
);

-- -----------------------------------------------------------------------------
-- Administration Lists
-- -----------------------------------------------------------------------------

-- Russian Oblast
CREATE TABLE adif.russian_oblast
(
    id SERIAL PRIMARY KEY,
    rdxc_code VARCHAR(2) NOT NULL,
    prefix VARCHAR(4) NOT NULL,
    oblast VARCHAR(60) NOT NULL 
    CONSTRAINT russian_oblast_uq UNIQUE (rdxc_codeoblast)
);

-- Russian Oblast Districts
CREATE TABLE adif.russian_oblast_district
(
    id SERIAL PRIMARY KEY,
    russian_oblast_id INT NOT NULL,
    code VARCHAR(5) NOT NULL,
    district VARCHAR(60),
    is_deleted BOOLEAN NOT NULL DEFAULT '0',
    replaced_by code VARCHAR(5) NOT NULL
    CONSTRAINT russian_district_oblast_uq UNIQUE (code,district)
);

-- -----------------------------------------------------------------------------
-- Primary Administration Subdivision Enumeration tables
-- -----------------------------------------------------------------------------

-- PAS 001 Canada --------------------------------------------------------------

-- TODO: FK dxcc_id REFERENCES adif.dxcc (id)
-- TODO: Needs CSV Data Table
CREATE TABLE adif.pas_001
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two letter code
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_001_uq UNIQUE (code,subdivision)
);

-- PAS-001 Canada CQ Zone
-- TODO: FK pas_001_id REFERENCES pas_001 (id)
-- TODO: FK cq_zone_id REFERENCES adif.cq_zone (id)
-- TODO: adif.view_pas_001
CREATE TABLE adif.pas_001_cqzone
(
    id SERIAL PRIMARY KEY,
    pas_001_id INT NOT NULL,
    cq_zone_id INT NOT NULL
);

-- PAS-001 Canada ITU Zone
-- TODO: FK pas_001_id REFERENCES pas
CREATE TABLE adif.pas_001_ituzone
(
    id SERIAL PRIMARY KEY,
    pas_001_id INT NOT NULL,
    itu_zone_id INT NOT NULL
);

-- 5 Aland Is. -----------------------------------------------------------------

-- TODO: FK dxcc_id REFERENCES adif.dxcc (id)
-- TODO: Need CSV data for pas_005 Aland Is. 
-- TODO: adif.view_pas_005
CREATE TABLE adif.pas_005
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(3) NOT NULL, -- three char 001, 002, 003
    subdivision VARCHAR(60) NOT NULL,
    is_deleted BOOLEAN NOT NULL DEFAULT '0',
    CONSTRAINT pas_005_uq UNIQUE (code,subdivision)
);

-- 6 Alaska --------------------------------------------------------------------

-- TODO: FK dxcc_id REFERENCES adif.dxcc (id)
-- TODO: Need CSV data for pas_006 Alaska 
-- TODO: adif.view_pas_006
CREATE TABLE adif.pas_006
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char AK
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_001_uq UNIQUE (code,subdivision)
);

-- 15 Asiatic Russia -----------------------------------------------------------

-- TODO: FK dxcc_id REFERENCES adif.dxcc (id)
-- TODO: Need CSV data for pas_015 Asiatic Russia
-- TODO: adif.view_pas_015
-- TODO: adif.view_pas_015_with_history
CREATE TABLE adif.pas_015
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char AA, BB, CC
    subdivision VARCHAR(80) NOT NULL,
    oblast VARCHAR(3) NOT NULL,
    CONSTRAINT pas_001_uq UNIQUE (code,subdivision)
);

-- TODO: FK pas_015_id REFERENCES pas_015 (id) 
-- TODO: Need CSV Data
CREATE TABLE adif.pas_015_history
(
    id SERIAL PRIMARY KEY,
    pas_015_id INT NOT NULL,
    previous_reference VARCHAR(80),
    before_date DATE
);

-- PAS-015 Asiatic Russia CQ Zone
-- TODO: FK pas_015_id REFERENCES pas_015 (id)
-- TODO: FK cq_zone_id REFERENCES adif.cq_zone (id)
-- TODO: adif.view_pas_015
-- TODO: Need CSV Data
CREATE TABLE adif.pas_015_cqzone
(
    id SERIAL PRIMARY KEY,
    pas_015_id INT NOT NULL,
    cq_zone_id INT NOT NULL
);

-- PAS-001 Canada ITU Zone
-- TODO: FK pas_015_id REFERENCES pas
-- TODO: Need CSV Data
CREATE TABLE adif.pas_015_ituzone
(
    id SERIAL PRIMARY KEY,
    pas_015_id INT NOT NULL,
    itu_zone_id INT NOT NULL
);

-- 21 Beleric Is. --------------------------------------------------------------

-- TODO: FK dxcc_id REFERENCES adif.dxcc (id)
-- TODO: Need CSV data for pas_021 Beleric Is. 
-- TODO: adif.view_pas_021
CREATE TABLE adif.pas_021
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char IB, IC,
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_021_uq UNIQUE (code,subdivision)
);

-- 27 Belarus ------------------------------------------------------------------

-- TODO: FK dxcc_id REFERENCES adif.dxcc (id)
-- TODO: Need CSV data for pas_027 Belarus
-- TODO: adif.view_pas_027
CREATE TABLE adif.pas_027
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, --two char MI, BR, HR
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_027_uq UNIQUE (code,subdivision)
);

-- 29 Canary Is. ---------------------------------------------------------------

-- TODO: FK dxcc_id REFERENCES adif.dxcc (id)
-- TODO: Need CSV data for pas_029 Canary Is.
-- TODO: adif.view_pas_029
CREATE TABLE adif.pas_029
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, --two hcar CG, TF, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_029_uq UNIQUE (code,subdivision)
);

-- 32 Cetua & Melilla ----------------------------------------------------------

-- TODO: FK dxcc_id REFERENCES adif.dxcc (id)
-- TODO: Need CSV data for pas_032 Cetua & Melilla
-- TODO: adif.view_pas_032
CREATE TABLE adif.pas_032
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char CE, ML, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_032_uq UNIQUE (code,subdivision)
);

-- 50 Mexico -------------------------------------------------------------------

-- TODO: FK dxcc_id REFERENCES adif.dxcc (id)
-- TODO: Need CSV data for pas_050 Mexico
-- TODO: adif.view_pas_050
CREATE TABLE adif.pas_050
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(3) NOT NULL, -- three char COL, DF, EMX, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_050_uq UNIQUE (code,subdivision)
);

-- 52 Estonia ------------------------------------------------------------------

-- NOTE: There are no known lists for Estonia
-- TODO: FK dxcc_id REFERENCES dxcc (id)
-- TODO: Need CSV Data
CREATE TABLE adif.pas_052
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(3) NOT NULL, -- assuming three char COL, DF, EMX, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_052_uq UNIQUE (code,subdivision)
);

-- 54 European Russia ----------------------------------------------------------

-- NOTE: There are no multiple itu or cq zones for EU Russia
-- TODO: FK cq_zone_id REFERENCES cq_zone (id)
-- TODO: FK itu_zone REFERENCES itu_zone (id)
-- TODO: Need CSV Data
CREATE TABLE adif.pas_054
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char SP, LO, KL, ...
    subdivision VARCHAR(60) NOT NULL,
    oblast CHAR(3) NOT NULL, -- three char all oblast numbers are 3 digits
    cq_zone_id INT NOT NULL,
    itu_xone_id INT NOT NULL,
    CONSTRAINT pas_054_uq UNIQUE (code,subdivision)
);

-- 61 Franz Josef Land ---------------------------------------------------------

-- TODO: FK dxcc_id REFERENCES dxcc (id)
-- TODO: Need CSV Data
CREATE TABLE adif.pas_061
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(3) NOT NULL, -- assuming three char AR, FJL, ...
    subdivision VARCHAR(60) NOT NULL,
    import_only BOOLEAN NOT NULL DEFAULT '0',
    CONSTRAINT pas_061_uq UNIQUE (code,subdivision)
);

-- 70 Cuba ---------------------------------------------------------------------

-- NOTE: There are no known lists for Cuba
-- TODO: FK dxcc_id REFERENCES dxcc (id)
CREATE TABLE adif.pas_070
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(3) NOT NULL, -- assuming three char AAA, BBB, CCC, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_070_uq UNIQUE (code,subdivision)
);

-- 74 El Salvador --------------------------------------------------------------

-- NOTE: There are no known lists for El Salvador
-- TODO: FK dxcc_id REFERENCES dxcc (id)
CREATE TABLE adif.pas_074
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(3) NOT NULL, -- assuming three char AAA, BBB, CCC, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_074_uq UNIQUE (code,subdivision)
);

-- 86 Nicaragua ----------------------------------------------------------------

-- NOTE: There are no known lists for El Nicaragua
-- TODO: FK dxcc_id REFERENCES dxcc (id)
CREATE TABLE adif.pas_086
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(3) NOT NULL, -- assuming three char AAA, BBB, CCC, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_086_uq UNIQUE (code,subdivision)
);

-- 100 Argintina ---------------------------------------------------------------

-- TODO: FK dxcc_id REFERENCES dxcc (id)
-- TODO: Need CSV Data
CREATE TABLE adif.pas_100
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(1) NOT NULL, -- assuming one char A, B, C, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_100_uq UNIQUE (code,subdivision)
);

-- 104 Bolivia -----------------------------------------------------------------

-- NOTE: There are no known lists for Bolivia
-- TODO: FK dxcc_id REFERENCES dxcc (id)
CREATE TABLE adif.pas_104
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(3) NOT NULL, -- assuming three char AAA, BBB, CCC, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_104_uq UNIQUE (code,subdivision)
);


-- 108 Brazil ------------------------------------------------------------------

-- TODO: FK dxcc_id REFERENCES dxcc (id)
-- TODO: Need CSV Data
CREATE TABLE adif.pas_108
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- assuming two char ES, GO, SC, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_108_uq UNIQUE (code,subdivision)
);

-- 110 Hawaii ------------------------------------------------------------------

-- TODO: FK dxcc_id REFERENCES dxcc (id)
-- TODO: Need CSV Data
CREATE TABLE adif.pas_110
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- assuming two char HI
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_110_uq UNIQUE (code,subdivision)
);

-- 112 Chile -------------------------------------------------------------------

-- NOTE: There are no known lists for Chile
-- TODO: FK dxcc_id REFERENCES dxcc (id)
CREATE TABLE adif.pas_112
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(3) NOT NULL, -- assuming three char AAA, BBB, CCC, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_112_uq UNIQUE (code,subdivision)
);

-- 126 Kalingrad ---------------------------------------------------------------

-- NOTE: There are no multiple itu or cq zones for EU Russia
-- TODO: FK cq_zone_id REFERENCES cq_zone (id)
-- TODO: FK itu_zone REFERENCES itu_zone (id)
-- TODO: Need CSV Data
CREATE TABLE adif.pas_126
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char KA, ...
    subdivision VARCHAR(60) NOT NULL,
    oblast CHAR(3) NOT NULL, -- three char all oblast numbers are 3 digits
    cq_zone_id INT NOT NULL,
    itu_xone_id INT NOT NULL,
    CONSTRAINT pas_126_uq UNIQUE (code,subdivision)
);

-- 130 Kazakhstan --------------------------------------------------------------

-- NOTE: There are no known lists for Kazakhstan
-- TODO: FK dxcc_id REFERENCES dxcc (id)
CREATE TABLE adif.pas_130
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(3) NOT NULL, -- assuming three char AAA, BBB, CCC, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_130_uq UNIQUE (code,subdivision)
);

-- 132 Paraguay ----------------------------------------------------------------

-- TODO: FK dxcc_id REFERENCES dxcc (id)
-- TODO: Need CSV Data
CREATE TABLE adif.pas_132
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(3) NOT NULL, -- assuming three char 16, ASU, 11 
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_132_uq UNIQUE (code,subdivision)
);

-- 137 Republic of Korea -------------------------------------------------------

-- TODO: FK dxcc_id REFERENCES dxcc (id)
-- TODO: Need CSV Data
CREATE TABLE adif.pas_137
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(1) NOT NULL, -- assuming one char 1, 9, 8, ... 
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_137_uq UNIQUE (code,subdivision)
);

-- 138 Kure --------------------------------------------------------------------

-- TODO: FK dxcc_id REFERENCES dxcc (id)
-- TODO: Need CSV Data
CREATE TABLE adif.pas_138
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- assuming two char KI, ... 
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_138_uq UNIQUE (code,subdivision)
);

-- 144 Uruguay -----------------------------------------------------------------

-- TODO: FK dxcc_id REFERENCES dxcc (id)
-- TODO: Need CSV Data
CREATE TABLE adif.pas_144
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- assuming two char MO, CA, SJ, ... 
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_144_uq UNIQUE (code,subdivision)
);

-- 147 Lord Howe Is. -----------------------------------------------------------

-- TODO: FK dxcc_id REFERENCES dxcc (id)
-- TODO: Need CSV Data
CREATE TABLE adif.pas_147
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- assuming two char LH, ... 
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_147_uq UNIQUE (code,subdivision)
);

-- 148 Venezuela ---------------------------------------------------------------

-- TODO: FK dxcc_id REFERENCES dxcc (id)
-- TODO: Need CSV Data
CREATE TABLE adif.pas_148
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- assuming two char AM, AN, AP, ... 
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_148_uq UNIQUE (code,subdivision)
);

-- 149 Azores ------------------------------------------------------------------

-- TODO: FK dxcc_id REFERENCES dxcc (id)
-- TODO: Need CSV Data
CREATE TABLE adif.pas_149
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- assuming two char AC, ... 
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_149_uq UNIQUE (code,subdivision)
);

-- 150 Australia ---------------------------------------------------------------

-- TODO: FK dxcc_id REFERENCES dxcc (id)
-- TODO: Need CSV Data
CREATE TABLE adif.pas_150
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(3) NOT NULL, -- assuming three char ACT, SA, NSW, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_150_uq UNIQUE (code,subdivision)
);

-- 151 Malyj Vysotski Is -------------------------------------------------------

-- TODO: FK dxcc_id REFERENCES dxcc (id)
-- TODO: Need CSV Data
CREATE TABLE adif.pas_151
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- assuming two char LO, MV, ...
    subdivision VARCHAR(60) NOT NULL,
    import_only BOOLEAN NOT NULL DEFAULT '0',
    CONSTRAINT pas_151_uq UNIQUE (code,subdivision)
);

-- 153 Macquarie Is. -----------------------------------------------------------

-- TODO: FK dxcc_id REFERENCES dxcc (id)
-- TODO: Need CSV Data
CREATE TABLE adif.pas_153
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- assuming two char MA, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_153_uq UNIQUE (code,subdivision)
);

-- 163 Papua New Guinea --------------------------------------------------------

-- TODO: FK dxcc_id REFERENCES dxcc (id)
-- TODO: Need CSV Data
CREATE TABLE adif.pas_163
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(3) NOT NULL, -- assuming three char NCD, CPM, CPK, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_163_uq UNIQUE (code,subdivision)
);

-- 170 New Zealand -------------------------------------------------------------

-- TODO: FK dxcc_id REFERENCES dxcc (id)
-- TODO: Need CSV Data
CREATE TABLE adif.pas_170
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(3) NOT NULL, -- assuming three char AUK, BUP, NTL, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_170_uq UNIQUE (code,subdivision)
);

-- 177 Minami Torishima --------------------------------------------------------

-- TODO: FK dxcc_id REFERENCES dxcc (id)
-- TODO: Need CSV Data
CREATE TABLE adif.pas_177
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- assuming two char MT, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_177_uq UNIQUE (code,subdivision)
);

-- 179 Moldova -----------------------------------------------------------------

-- NOTE: There are no known lists for Moldova
-- TODO: FK dxcc_id REFERENCES dxcc (id)
-- TODO: Need CSV Data
CREATE TABLE adif.pas_179
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(3) NOT NULL, -- assuming three char AAA, BBB, CCC, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_179_uq UNIQUE (code,subdivision)
);

-- 192 Ogasawara ---------------------------------------------------------------

-- TODO: FK dxcc_id REFERENCES dxcc (id)
-- TODO: Need CSV Data
CREATE TABLE adif.pas_192
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(1) NOT NULL, -- assuming one char O, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_192_uq UNIQUE (code,subdivision)
);

-- 206 Austria -----------------------------------------------------------------

-- NOTE: Austria has regions, as well as PAS Subdivisions
-- TODO: FK dxcc_id REFERENCES adif.dxcc (id)
-- TODO: Need CSV Data
CREATE TABLE adif.pas_206_region
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    region VARCHAR(40) NOT NULL,
    CONSTRAINT pas_206_region_uq UNIQUE (region)
);

-- TODO: FK dxcc_id REFERENCES dxcc (id)
-- TODO: FK pas_206_region_id REFERENCES adif.pas_206_region (id)
CREATE TABLE adif.pas_206_subdivision
(
    id SERIAL PRIMARY KEY,
    pas_206_region_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- assuming two char AM, BL, BN, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_206_subdivision_uq UNIQUE (code,subdivision)
);

-- 209 Belgium -----------------------------------------------------------------

-- TODO: FK dxcc_id REFERENCES dxcc (id)
-- TODO: Need CSV Data
CREATE TABLE adif.pas_209
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- assuming two char AN, BR, BW, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_209_uq UNIQUE (code,subdivision)
);

-- 212 Bulgaria ----------------------------------------------------------------

-- NOTE: Bulgaria has regions, as well as PAS Subdivisions
-- TODO: FK dxcc_id REFERENCES adif.dxcc (id)
-- TODO: Need CSV Data
CREATE TABLE adif.pas_212_region
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    region VARCHAR(40) NOT NULL,
    CONSTRAINT pas_212_region_uq UNIQUE (region)
);

-- TODO: FK dxcc_id REFERENCES dxcc (id)
-- TODO: FK pas_212_region_id REFERENCES adif.pas_212_region (id)
CREATE TABLE adif.pas_212_subdivision
(
    id SERIAL PRIMARY KEY,
    pas_212_region_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- assuming two char AM, BL, BN, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_212_subdivision_uq UNIQUE (code,subdivision)
);

-- 214 Corsica -----------------------------------------------------------------

-- TODO: FK dxcc_id REFERENCES dxcc (id)
-- TODO: Need CSV Data
CREATE TABLE adif.pas_214
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- assuming two char 2A, 2B, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_214_uq UNIQUE (code,subdivision)
);

-- 221 Denmark -----------------------------------------------------------------

-- TODO: FK dxcc_id REFERENCES dxcc (id)
-- TODO: Need CSV Data
CREATE TABLE adif.pas_221
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(3) NOT NULL, -- assuming three char 015, 025, 055, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_221_uq UNIQUE (code,subdivision)
);

-- 224 Finland -----------------------------------------------------------------

-- NOTE: Finland has regions, as well as PAS Subdivisions
-- TODO: FK dxcc_id REFERENCES adif.dxcc (id)
-- TODO: Need CSV Data
CREATE TABLE adif.pas_224_region
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    region VARCHAR(40) NOT NULL,
    CONSTRAINT pas_224_region_uq UNIQUE (region)
);

-- TODO: FK dxcc_id REFERENCES dxcc (id)
-- TODO: FK pas_224_region_id REFERENCES adif.pas_224_region (id)
-- TODO: Need CSV Data
CREATE TABLE adif.pas_224_subdivision
(
    id SERIAL PRIMARY KEY,
    pas_224_region_id INT NOT NULL,
    code CHAR(3) NOT NULL, -- assuming three char 105, 106, 107, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_224_subdivision_uq UNIQUE (code,subdivision)
);

-- 225 Sardinia ----------------------------------------------------------------

-- NOTE: Sardinia has regions, as well as PAS Subdivisions
-- NOTE: Sardinia has one Import Only Subdivision
-- TODO: FK dxcc_id REFERENCES adif.dxcc (id)
-- TODO: Need CSV Data
CREATE TABLE adif.pas_225_region
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    region VARCHAR(40) NOT NULL,
    CONSTRAINT pas_225_region_uq UNIQUE (region)
);

-- TODO: FK dxcc_id REFERENCES dxcc (id)
-- TODO: FK pas_225_region_id REFERENCES adif.pas_225_region (id)
-- TODO: Need CSV Data
CREATE TABLE adif.pas_225_subdivision
(
    id SERIAL PRIMARY KEY,
    pas_225_region_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- assuming two char CA, CI, MD, ...
    subdivision VARCHAR(60) NOT NULL,
    import_only BOOLEAN NOT NULL DEFAULT '0',
    CONSTRAINT pas_225_subdivision_uq UNIQUE (code,subdivision)
);

-- 227 France ------------------------------------------------------------------

-- TODO: FK dxcc_id REFERENCES dxcc (id)
-- TODO: Need CSV Data
CREATE TABLE adif.pas_227
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- assuming two char 01, 02, 03, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_227_uq UNIQUE (code,subdivision)
);

-- 230 Fed. Rep. of Germany ----------------------------------------------------

-- TODO: FK dxcc_id REFERENCES dxcc (id)
-- TODO: Need CSV Data
CREATE TABLE adif.pas_230
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- assuming two char BB, BW, BW, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_230_uq UNIQUE (code,subdivision)
);

-- 239 Hungary -----------------------------------------------------------------

-- TODO: FK dxcc_id REFERENCES dxcc (id)
-- TODO: Need CSV Data
CREATE TABLE adif.pas_239
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- assuming two char GY, VA, ZA, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_239_uq UNIQUE (code,subdivision)
);

-- 245 Ireland -----------------------------------------------------------------

-- TODO: FK dxcc_id REFERENCES dxcc (id)
-- TODO: Need CSV Data
CREATE TABLE adif.pas_245
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- assuming two char CW, CN, CE, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_245_uq UNIQUE (code,subdivision)
);

-- 248 Italy -------------------------------------------------------------------

-- NOTE: Italy has regions, as well as PAS Subdivisions
-- NOTE: Italy has multiple Import Only Subdivisions
-- TODO: FK dxcc_id REFERENCES adif.dxcc (id)
-- TODO: Need CSV Data
CREATE TABLE adif.pas_248_region
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    region VARCHAR(40) NOT NULL,
    CONSTRAINT pas_248_region_uq UNIQUE (region)
);

-- TODO: FK dxcc_id REFERENCES dxcc (id)
-- TODO: FK pas_248_region_id REFERENCES adif.pas_248_region (id)
-- TODO: Need CSV Data
CREATE TABLE adif.pas_248_subdivision
(
    id SERIAL PRIMARY KEY,
    pas_248_region_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- assuming two char BO, FE, FO, ...
    subdivision VARCHAR(60) NOT NULL,
    import_only BOOLEAN NOT NULL DEFAULT '0',
    CONSTRAINT pas_248_subdivision_uq UNIQUE (code,subdivision)
);

-- 256 Maderia Is. -------------------------------------------------------------

-- TODO: FK dxcc_id REFERENCES dxcc (id)
-- TODO: Need CSV Data
CREATE TABLE adif.pas_256
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- assuming two char MD, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_256_uq UNIQUE (code,subdivision)
);

-- 263 Netherlands -------------------------------------------------------------

-- TODO: FK dxcc_id REFERENCES dxcc (id)
-- TODO: Need CSV Data
CREATE TABLE adif.pas_263
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- assuming two char DR, FR, GR, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_263_uq UNIQUE (code,subdivision)
);

-- 269 Poland ------------------------------------------------------------------

-- TODO: FK dxcc_id REFERENCES dxcc (id)
-- TODO: Need CSV Data
CREATE TABLE adif.pas_269
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(1) NOT NULL, -- assuming one char Z, F, P, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_269_uq UNIQUE (code,subdivision)
);

-- 272 Portugal ----------------------------------------------------------------

-- TODO: FK dxcc_id REFERENCES dxcc (id)
-- TODO: Need CSV Data
CREATE TABLE adif.pas_272
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- assuming two char AV, BJ, BR, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_272_uq UNIQUE (code,subdivision)
);

-- 275 Romania -----------------------------------------------------------------

-- TODO: FK dxcc_id REFERENCES dxcc (id)
-- TODO: Need CSV Data
CREATE TABLE adif.pas_275
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- assuming two char AR, CS, HD, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_275_uq UNIQUE (code,subdivision)
);

-- 281 Spain -------------------------------------------------------------------

-- TODO: FK dxcc_id REFERENCES dxcc (id)
-- TODO: Need CSV Data
CREATE TABLE adif.pas_281
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- assuming two char AV, BU, C, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_281_uq UNIQUE (code,subdivision)
);

-- 284 Sweden ------------------------------------------------------------------

-- TODO: FK dxcc_id REFERENCES dxcc (id)
-- TODO: Need CSV Data
CREATE TABLE adif.pas_284
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- assuming two char AB, I, BD, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_284_uq UNIQUE (code,subdivision)
);

-- 287 Switzerland -------------------------------------------------------------

-- TODO: FK dxcc_id REFERENCES dxcc (id)
-- TODO: Need CSV Data
CREATE TABLE adif.pas_287
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- assuming two char AG, AR, AI, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_287_uq UNIQUE (code,subdivision)
);

-- 288 Ukraine -----------------------------------------------------------------

-- TODO: FK dxcc_id REFERENCES dxcc (id)
-- TODO: Need CSV Data
CREATE TABLE adif.pas_288
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- assuming two char SU, TE, CH, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_288_uq UNIQUE (code,subdivision)
);

-- 291 United States -----------------------------------------------------------

-- TODO: FK dxcc_id REFERENCES adif.dxcc (id)
-- TODO: Needs CSV Data
CREATE TABLE adif.pas_291
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two letter state code
    subdivision VARCHAR(60) NOT NULL, -- state name
    CONSTRAINT pas_291_uq UNIQUE (code,subdivision)
);

-- PAS-291 United States CQ Zone
-- TODO: FK pas_001_id REFERENCES pas_001 (id)
-- TODO: FK cq_zone_id REFERENCES adif.cq_zone (id)
-- TODO: adif.view_pas_291
-- TODO: Need CSV Data
CREATE TABLE adif.pas_291_cqzone
(
    id SERIAL PRIMARY KEY,
    pas_291_id INT NOT NULL,
    cq_zone_id INT NOT NULL
);

-- PAS-291 United States ITU Zone
-- TODO: FK pas_001_id REFERENCES pas
-- TODO Need CSV Data
CREATE TABLE adif.pas_291_ituzone
(
    id SERIAL PRIMARY KEY,
    pas_291_id INT NOT NULL,
    itu_zone_id INT NOT NULL
);

-- 318 China -------------------------------------------------------------------

-- TODO: FK dxcc_id REFERENCES dxcc (id)
-- TODO: Need CSV Data
CREATE TABLE adif.pas_318
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- assuming two char AH, BJ, CQ, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_318_uq UNIQUE (code,subdivision)
);

-- 327 Indonesia ---------------------------------------------------------------

-- TODO: FK dxcc_id REFERENCES dxcc (id)
-- TODO: Need CSV Data
CREATE TABLE adif.pas_327
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- assuming two char BA, BB, BT, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_327_uq UNIQUE (code,subdivision)
);

-- 339 Japan -------------------------------------------------------------------

-- NOTE: Japan has regions, as well as PAS Subdivisions
-- TODO: FK dxcc_id REFERENCES adif.dxcc (id)
-- TODO: Need CSV Data
CREATE TABLE adif.pas_339_region
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    region VARCHAR(20) NOT NULL,
    CONSTRAINT pas_339_region_uq UNIQUE (region)
);

-- TODO: FK dxcc_id REFERENCES dxcc (id)
-- TODO: FK pas_339_region_id REFERENCES adif.pas_339_region (id)
-- TODO: Need CSV Data
CREATE TABLE adif.pas_339_subdivision
(
    id SERIAL PRIMARY KEY,
    pas_339_region_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- assuming two char 01, 02, 03, ...
    subdivision VARCHAR(20) NOT NULL,
    CONSTRAINT pas_339_subdivision_uq UNIQUE (code,subdivision)
);

-- 375 Philippines -------------------------------------------------------------

-- NOTE: Philippines has regions, as well as PAS Subdivisions
-- TODO: FK dxcc_id REFERENCES adif.dxcc (id)
-- TODO: Need CSV Data
CREATE TABLE adif.pas_375_region
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    region VARCHAR(60) NOT NULL,
    CONSTRAINT pas_375_region_uq UNIQUE (region)
);

-- TODO: FK dxcc_id REFERENCES dxcc (id)
-- TODO: FK pas_375_region_id REFERENCES adif.pas_375_region (id)
-- TODO: Need CSV Data
CREATE TABLE adif.pas_375_subdivision
(
    id SERIAL PRIMARY KEY,
    pas_375_region_id INT NOT NULL,
    code CHAR(3) NOT NULL, -- assuming three char AUR, BTG, CAV, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_375_subdivision_uq UNIQUE (code,subdivision)
);

-- 386 Taiwan ------------------------------------------------------------------

-- TODO: FK dxcc_id REFERENCES dxcc (id)
-- TODO: Need CSV Data
CREATE TABLE adif.pas_386
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(3) NOT NULL, -- assuming two char DAS, DAO, CAM, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_386_uq UNIQUE (code,subdivision)
);

-- 387 Thailand ----------------------------------------------------------------

-- TODO: FK dxcc_id REFERENCES dxcc (id)
-- TODO: Need CSV Data
CREATE TABLE adif.pas_387
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- assuming two char 37, 25, 81, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_387_uq UNIQUE (code,subdivision)
);

-- 497 Crotia ------------------------------------------------------------------

-- TODO: FK dxcc_id REFERENCES dxcc (id)
-- TODO: Need CSV Data
CREATE TABLE adif.pas_497
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- assuming two char 01, 02, 03, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_497_uq UNIQUE (code,subdivision)
);

-- 503 Czech Republic ----------------------------------------------------------

-- NOTE: Czech Republic has regions, as well as PAS Subdivisions
-- TODO: FK dxcc_id REFERENCES adif.dxcc (id)
-- TODO: Need CSV Data
CREATE TABLE adif.pas_503_region
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    region VARCHAR(20) NOT NULL,
    CONSTRAINT pas_503_region_uq UNIQUE (region)
);

-- TODO: FK dxcc_id REFERENCES dxcc (id)
-- TODO: FK pas_503_region_id REFERENCES adif.pas_503_region (id)
-- TODO: Need CSV Data
CREATE TABLE adif.pas_503_subdivision
(
    id SERIAL PRIMARY KEY,
    pas_503_region_id INT NOT NULL,
    code CHAR(3) NOT NULL, -- assuming two char APA, APB, APC, ...
    subdivision VARCHAR(20) NOT NULL,
    CONSTRAINT pas_503_subdivision_uq UNIQUE (code,subdivision)
);

-- 504 Slovak Republic ---------------------------------------------------------

-- NOTE: Slovak Republic has regions, as well as PAS Subdivisions
-- TODO: FK dxcc_id REFERENCES adif.dxcc (id)
-- TODO: Need CSV Data
CREATE TABLE adif.pas_504_region
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    region VARCHAR(20) NOT NULL,
    CONSTRAINT pas_504_region_uq UNIQUE (region)
);

-- TODO: FK dxcc_id REFERENCES dxcc (id)
-- TODO: FK pas_504_region_id REFERENCES adif.pas_504_region (id)
-- TODO: Need CSV Data
CREATE TABLE adif.pas_504_subdivision
(
    id SERIAL PRIMARY KEY,
    pas_504_region_id INT NOT NULL,
    code CHAR(3) NOT NULL, -- assuming two char BAA, BAB, BAC, ...
    subdivision VARCHAR(20) NOT NULL,
    CONSTRAINT pas_504_subdivision_uq UNIQUE (code,subdivision)
);

-- *****************************************************************************
--  ADD CSV DATA BEFORE FK's and IDX
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

-- PSA Summary FK's
ALTER TABLE adif.psa_summary ADD CONSTRAINT pas_summary_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES adif.dxcc (id);

ALTER TABLE adif.psa_summary ADD CONSTRAINT pas_summary_pas_subdivision_type_fkey
    FOREIGN KEY (pas_subdivision_type_id) REFERENCES adif.pas_subdivision_type (id);

ALTER TABLE adif.psa_summary ADD CONSTRAINT pas_summary_sas_subdivision_type_fkey
    FOREIGN KEY (sas_subdivision_type_id) REFERENCES adif.sas_subdivision_type (id);

-- PAS CQ Zone FK
ALTER TABLE adif.pas_cqzone ADD CONSTRAINT pas_cqzone_pas_summary_fkey
    FOREIGN KEY (pas_summary_id) REFERENCES adif.pas_summary (id);

-- PAS ITU Zone FK
ALTER TABLE adif.pas_ituzone ADD CONSTRAINT pas_ituzone_pas_summary_fkey
    FOREIGN KEY (itu_zone_id) REFERENCES adif.itu_zone (id);


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