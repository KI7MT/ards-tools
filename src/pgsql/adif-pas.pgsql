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
-- PAS Summary Table
-- -----------------------------------------------------------------------------

-- Primary Administration Subdivision
-- TODO: Need CSV Table Data
-- TODO: adif.view_pas_summary
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
    subdivision_type VARCHAR(20) NOT NULL,
    CONSTRAINT psa_subdivision_type_uq UNIQUE (subdivision_type)
);

-- Secondary Administration Subdivision
-- TODO: Need CSV Table
CREATE TABLE adif.sas_subdivision_type
(
    id SERIAL PRIMARY KEY,
    subdivision_type VARCHAR(20) NOT NULL,
    CONSTRAINT sas_subdivision_type_uq UNIQUE (subdivision_type)
);

-- -----------------------------------------------------------------------------
-- PAS Enumeration tables
-- -----------------------------------------------------------------------------

-- PAS 001 Canada --------------------------------------------------------------

-- TODO: Needs CSV Data Table
-- TODO: Need adif.view_pas_001
CREATE TABLE adif.pas_001
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two letter code
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_001_uq UNIQUE (code,subdivision)
);
-- PAS-001 Canada CQ Zone
CREATE TABLE adif.pas_001_cqzone
(
    id SERIAL PRIMARY KEY,
    pas_001_id INT NOT NULL,
    cq_zone_id INT NOT NULL
);

-- PAS-001 Canada ITU Zone
CREATE TABLE adif.pas_001_ituzone
(
    id SERIAL PRIMARY KEY,
    pas_001_id INT NOT NULL,
    itu_zone_id INT NOT NULL
);

-- 5 Aland Is. -----------------------------------------------------------------

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

-- TODO: Need CSV data for adif.pas_006 Alaska 
-- TODO: adif.view_pas_006
CREATE TABLE adif.pas_006
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char AK
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_006_uq UNIQUE (code,subdivision)
);

-- 15 Asiatic Russia -----------------------------------------------------------

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
    CONSTRAINT pas_015_uq UNIQUE (code,subdivision)
);

-- TODO: Need CSV Data (There is only One with Vrevious Before Date)
CREATE TABLE adif.pas_015_history
(
    id SERIAL PRIMARY KEY,
    pas_015_id INT NOT NULL,
    previous_reference VARCHAR(80),
    before_date DATE
);

-- PAS-015 Asiatic Russia CQ Zone
-- TODO: Need CSV Data
CREATE TABLE adif.pas_015_cqzone
(
    id SERIAL PRIMARY KEY,
    pas_015_id INT NOT NULL,
    cq_zone_id INT NOT NULL
);

-- PAS-015 Canada ITU Zone
-- TODO: Need CSV Data
CREATE TABLE adif.pas_015_ituzone
(
    id SERIAL PRIMARY KEY,
    pas_015_id INT NOT NULL,
    itu_zone_id INT NOT NULL
);

-- 21 Beleric Is. --------------------------------------------------------------

-- TODO: Need CSV data for pas_021 Beleric Is. 
-- TODO: adif.view_pas_021
CREATE TABLE adif.pas_021
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char IB, IC, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_021_uq UNIQUE (code,subdivision)
);

-- 27 Belarus ------------------------------------------------------------------

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

-- TODO: Need CSV Data
-- TODO: adif.view_pas_052
CREATE TABLE adif.pas_052
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- assuming two char 37, 39,44, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_052_uq UNIQUE (code,subdivision)
);

-- 54 European Russia ----------------------------------------------------------

-- NOTE: There are no multiple itu or cq zones for EU Russia
-- TODO: Need CSV Data
-- TODO: adif.view_pas_055
CREATE TABLE adif.pas_054
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char SP, LO, KL, ...
    subdivision VARCHAR(60) NOT NULL,
    oblast CHAR(3) NOT NULL, -- three char, all oblast numbers are 3 digits
    cq_zone_id INT NOT NULL,
    itu_xone_id INT NOT NULL,
    CONSTRAINT pas_054_uq UNIQUE (code,subdivision)
);

-- 61 Franz Josef Land ---------------------------------------------------------

-- TODO: Need CSV Data
-- TODO: adif.view_pas_061
CREATE TABLE adif.pas_061
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char AR, ...
    subdivision VARCHAR(60) NOT NULL,
    import_only BOOLEAN NOT NULL DEFAULT '0',
    CONSTRAINT pas_061_uq UNIQUE (code,subdivision)
);

-- 70 Cuba ---------------------------------------------------------------------

-- TODO: Need CSV Data
-- TODO: adif.view_pas_070
CREATE TABLE adif.pas_070
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char 09, 08, 06, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_070_uq UNIQUE (code,subdivision)
);

-- 74 El Salvador --------------------------------------------------------------

-- TODO: Need CSV Data
-- TODO: adif.view_pas_074
CREATE TABLE adif.pas_074
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char AH, CH, CA, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_074_uq UNIQUE (code,subdivision)
);

-- 86 Nicaragua ----------------------------------------------------------------

-- TODO: Need CSV Data
-- TODO: adif.view_pas_086
CREATE TABLE adif.pas_086
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char BO, CA, CI ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_086_uq UNIQUE (code,subdivision)
);

-- 100 Argintina ---------------------------------------------------------------

-- TODO: Need CSV Data
-- TODO: adif.view_pas_100
CREATE TABLE adif.pas_100
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(1) NOT NULL, -- one char A, B, C, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_100_uq UNIQUE (code,subdivision)
);

-- 104 Bolivia -----------------------------------------------------------------

-- TODO: Need CSV Data
-- TODO: adif.view_pas_104
CREATE TABLE adif.pas_104
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(1) NOT NULL, -- two char A, B, C, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_104_uq UNIQUE (code,subdivision)
);

-- 108 Brazil ------------------------------------------------------------------

-- TODO: Need CSV Data
-- TODO: adif.view_pas_108
CREATE TABLE adif.pas_108
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- assuming two char ES, GO, SC, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_108_uq UNIQUE (code,subdivision)
);

-- 110 Hawaii ------------------------------------------------------------------

-- TODO: Need CSV Data
-- TODO: adif.view_pas_108
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
-- TODO: adif.view_pas_112
CREATE TABLE adif.pas_112
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(4) NOT NULL, -- four char XIII, XIV, XII, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_112_uq UNIQUE (code,subdivision)
);

-- 126 Kalingrad ---------------------------------------------------------------

-- NOTE: There are no multiple itu or cq zones for EU Russia
-- TODO: Need CSV Data
-- TODO: adif.view_pas_126
CREATE TABLE adif.pas_126
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char KA, ...
    subdivision VARCHAR(60) NOT NULL,
    oblast CHAR(3) NOT NULL, -- three char, oblast numbers are 3 digits
    cq_zone_id INT NOT NULL,
    itu_xone_id INT NOT NULL,
    CONSTRAINT pas_126_uq UNIQUE (code,subdivision)
);

-- 130 Kazakhstan --------------------------------------------------------------

-- TODO: Need CSV Data
-- TODO: adif.view_pas_130
CREATE TABLE adif.pas_130
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char AA, BB, CC, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_130_uq UNIQUE (code,subdivision)
);

-- 132 Paraguay ----------------------------------------------------------------

-- TODO: Need CSV Data
-- TODO: adif.view_pas_132
CREATE TABLE adif.pas_132
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(3) NOT NULL, -- three char 16, ASU, 11 
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_132_uq UNIQUE (code,subdivision)
);

-- 137 Republic of Korea -------------------------------------------------------

-- TODO: Need CSV Data
-- TODO: adif.view_pas_137
CREATE TABLE adif.pas_137
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(1) NOT NULL, -- one char 1, 9, 8, ... 
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_137_uq UNIQUE (code,subdivision)
);

-- 138 Kure Island -------------------------------------------------------------

-- TODO: Need CSV Data
-- TODO: adif.view_pas_138
CREATE TABLE adif.pas_138
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two two char KI, ... 
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_138_uq UNIQUE (code,subdivision)
);

-- 144 Uruguay -----------------------------------------------------------------

-- TODO: Need CSV Data
-- TODO: adif.view_pas_144
CREATE TABLE adif.pas_144
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two two char MO, CA, SJ, ... 
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_144_uq UNIQUE (code,subdivision)
);

-- 147 Lord Howe Is. -----------------------------------------------------------

-- TODO: Need CSV Data
-- TODO: adif.view_pas_147
CREATE TABLE adif.pas_147
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char LH, ... 
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_147_uq UNIQUE (code,subdivision)
);

-- 148 Venezuela ---------------------------------------------------------------

-- TODO: Need CSV Data
-- TODO: adif.view_pas_148
CREATE TABLE adif.pas_148
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char AM, AN, AP, ... 
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_148_uq UNIQUE (code,subdivision)
);

-- 149 Azores ------------------------------------------------------------------

-- TODO: Need CSV Data
-- TODO: adif.view_pas_149
CREATE TABLE adif.pas_149
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char AC, ... 
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_149_uq UNIQUE (code,subdivision)
);

-- 150 Australia ---------------------------------------------------------------

-- TODO: Need CSV Data
-- TODO: adif.view_pas_150
CREATE TABLE adif.pas_150
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(3) NOT NULL, -- three char ACT, SA, NSW, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_150_uq UNIQUE (code,subdivision)
);

-- 151 Malyj Vysotski Is -------------------------------------------------------

-- TODO: Need CSV Data
-- TODO: adif.view_pas_151
CREATE TABLE adif.pas_151
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char LO, MV, ...
    subdivision VARCHAR(60) NOT NULL,
    import_only BOOLEAN NOT NULL DEFAULT '0',
    CONSTRAINT pas_151_uq UNIQUE (code,subdivision)
);
ALTER TABLE adif.pas_153 ADD CONSTRAINT pas_153_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES adif.dxcc (id);

-- 153 Macquarie Is. -----------------------------------------------------------

-- TODO: Need CSV Data
-- TODO: adif.view_pas_153
CREATE TABLE adif.pas_153
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char MA, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_153_uq UNIQUE (code,subdivision)
);

-- 163 Papua New Guinea --------------------------------------------------------

-- TODO: Need CSV Data
-- TODO: adif.view_pas_163
CREATE TABLE adif.pas_163
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(3) NOT NULL, -- three char NCD, CPM, CPK, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_163_uq UNIQUE (code,subdivision)
);

-- 170 New Zealand -------------------------------------------------------------

-- TODO: Need CSV Data
-- TODO: adif.view_pas_170
CREATE TABLE adif.pas_170
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(3) NOT NULL, -- three char AUK, BUP, NTL, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_170_uq UNIQUE (code,subdivision)
);

-- 177 Minami Torishima --------------------------------------------------------

-- TODO: Need CSV Data
-- TODO: adif.view_pas_177
CREATE TABLE adif.pas_177
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char MT, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_177_uq UNIQUE (code,subdivision)
);

-- 179 Moldova -----------------------------------------------------------------

-- TODO: Need CSV Data
-- TODO: adif.view_pas_179
CREATE TABLE adif.pas_179
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(3) NOT NULL, -- three char AAA, BBB, CCC, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_179_uq UNIQUE (code,subdivision)
);

-- 192 Ogasawara ---------------------------------------------------------------

-- TODO: Need CSV Data
-- TODO: adif.view_pas_179
CREATE TABLE adif.pas_192
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(1) NOT NULL, -- one char O, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_192_uq UNIQUE (code,subdivision)
);

-- 206 Austria -----------------------------------------------------------------

-- NOTE: Austria has Regions and Subdivisions
-- TODO: Need CSV Data
-- TODO: adif.view_pas_206_region
CREATE TABLE adif.pas_206_region
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    region VARCHAR(40) NOT NULL,
    CONSTRAINT pas_206_region_uq UNIQUE (region)
);

-- TODO: Need CSV Data
-- TODO: adif.view_pas_206_subdivision
CREATE TABLE adif.pas_206_subdivision
(
    id SERIAL PRIMARY KEY,
    pas_206_region_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char AM, BL, BN, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_206_subdivision_uq UNIQUE (code,subdivision)
);

-- 209 Belgium -----------------------------------------------------------------

-- TODO: Need CSV Data
-- TODO: adif.view_pas_209
CREATE TABLE adif.pas_209
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char AN, BR, BW, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_209_uq UNIQUE (code,subdivision)
);
ALTER TABLE adif.pas_209 ADD CONSTRAINT pas_209_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES adif.dxcc (id);

-- 212 Bulgaria ----------------------------------------------------------------

-- NOTE: Bulgaria has Regions and Subdivisions
-- TODO: Need CSV Data
-- TODO: adif.view_pas_212_region
CREATE TABLE adif.pas_212_region
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    region VARCHAR(40) NOT NULL,
    CONSTRAINT pas_212_region_uq UNIQUE (region)
);

-- TODO: Need CSV Data
-- TODO: adif.view_pas_212_subdivision
CREATE TABLE adif.pas_212_subdivision
(
    id SERIAL PRIMARY KEY,
    pas_212_region_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char AM, BL, BN, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_212_subdivision_uq UNIQUE (code,subdivision)
);
ALTER TABLE adif.pas_212_subdivision ADD CONSTRAINT pas_212_subdivision_pas_212_region_fkey
    FOREIGN KEY (pas_212_region_id) REFERENCES adif.pas_212_region (id);


-- 214 Corsica -----------------------------------------------------------------

-- TODO: Need CSV Data
-- TODO: adif.view_pas_214
CREATE TABLE adif.pas_214
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char 2A, 2B, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_214_uq UNIQUE (code,subdivision)
);

-- 221 Denmark -----------------------------------------------------------------

-- TODO: Need CSV Data
-- TODO: adif.view_pas_221
CREATE TABLE adif.pas_221
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(3) NOT NULL, -- three char 015, 025, 055, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_221_uq UNIQUE (code,subdivision)
);

-- 224 Finland -----------------------------------------------------------------

-- NOTE: Finland has Regions and Subdivisions
-- TODO: Need CSV Data
-- TODO: adif.view_pas_224_region
CREATE TABLE adif.pas_224_region
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    region VARCHAR(40) NOT NULL,
    CONSTRAINT pas_224_region_uq UNIQUE (region)
);

-- TODO: Need CSV Data
-- TODO: adif.view_pas_224_subdivision
CREATE TABLE adif.pas_224_subdivision
(
    id SERIAL PRIMARY KEY,
    pas_224_region_id INT NOT NULL,
    code CHAR(3) NOT NULL, -- three char 105, 106, 107, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_224_subdivision_uq UNIQUE (code,subdivision)
);

-- 225 Sardinia ----------------------------------------------------------------

-- NOTE: Sardinia has Regions and Subdivisions
-- NOTE: Sardinia has one Import Only Subdivision
-- TODO: Need CSV Data
-- TODO: adif.view_pas_225_region
CREATE TABLE adif.pas_225_region
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    region VARCHAR(40) NOT NULL,
    CONSTRAINT pas_225_region_uq UNIQUE (region)
);

-- TODO: Need CSV Data
-- TODO: adif.view_pas_225_subdivision
CREATE TABLE adif.pas_225_subdivision
(
    id SERIAL PRIMARY KEY,
    pas_225_region_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char CA, CI, MD, ...
    subdivision VARCHAR(60) NOT NULL,
    import_only BOOLEAN NOT NULL DEFAULT '0',
    CONSTRAINT pas_225_subdivision_uq UNIQUE (code,subdivision)
);

-- 227 France ------------------------------------------------------------------

-- TODO: Need CSV Data
-- TODO: adif.view_pas_227
CREATE TABLE adif.pas_227
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char 01, 02, 03, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_227_uq UNIQUE (code,subdivision)
);

-- 230 Fed. Rep. of Germany ----------------------------------------------------

-- TODO: Need CSV Data
-- TODO: adif.view_pas_230
CREATE TABLE adif.pas_230
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- assuming two char BB, BW, BW, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_230_uq UNIQUE (code,subdivision)
);

-- 239 Hungary -----------------------------------------------------------------

-- TODO: Need CSV Data
-- TODO: adif.view_pas_239
CREATE TABLE adif.pas_239
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- assuming two char GY, VA, ZA, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_239_uq UNIQUE (code,subdivision)
);

-- 245 Ireland -----------------------------------------------------------------

-- TODO: Need CSV Data
-- TODO: adif.view_pas_245
CREATE TABLE adif.pas_245
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- assuming two char CW, CN, CE, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_245_uq UNIQUE (code,subdivision)
);

-- 248 Italy -------------------------------------------------------------------

-- NOTE: Italy has Regions and Subdivisions
-- NOTE: Italy has multiple Import Only Subdivisions
-- TODO: Need CSV Data
-- TODO: adif.view_pas_248_region
CREATE TABLE adif.pas_248_region
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    region VARCHAR(40) NOT NULL,
    CONSTRAINT pas_248_region_uq UNIQUE (region)
);

-- TODO: Need CSV Data
-- TODO: adif.view_pas_245_subdivision
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

-- TODO: Need CSV Data
-- TODO: adif.view_pas_256
CREATE TABLE adif.pas_256
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- assuming two char MD, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_256_uq UNIQUE (code,subdivision)
);

-- 263 Netherlands -------------------------------------------------------------

-- TODO: Need CSV Data
-- TODO: adif.view_pas_263
CREATE TABLE adif.pas_263
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char DR, FR, GR, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_263_uq UNIQUE (code,subdivision)
);

-- 269 Poland ------------------------------------------------------------------

-- TODO: Need CSV Data
-- TODO: adif.view_pas_269
CREATE TABLE adif.pas_269
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(1) NOT NULL, -- one char Z, F, P, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_269_uq UNIQUE (code,subdivision)
);

-- 272 Portugal ----------------------------------------------------------------

-- TODO: Need CSV Data
-- TODO: adif.view_pas_272
CREATE TABLE adif.pas_272
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char AV, BJ, BR, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_272_uq UNIQUE (code,subdivision)
);

-- 275 Romania -----------------------------------------------------------------

-- TODO: Need CSV Data
-- TODO: adif.view_pas_275
CREATE TABLE adif.pas_275
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char AR, CS, HD, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_275_uq UNIQUE (code,subdivision)
);

-- 281 Spain -------------------------------------------------------------------

-- TODO: Need CSV Data
-- TODO: adif.view_pas_281
CREATE TABLE adif.pas_281
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char AV, BU, C, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_281_uq UNIQUE (code,subdivision)
);

-- 284 Sweden ------------------------------------------------------------------

-- TODO: Need CSV Data
-- TODO: adif.view_pas_284
CREATE TABLE adif.pas_284
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char AB, I, BD, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_284_uq UNIQUE (code,subdivision)
);

-- 287 Switzerland -------------------------------------------------------------

-- TODO: Need CSV Data
-- TODO: adif.view_pas_287
CREATE TABLE adif.pas_287
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char AG, AR, AI, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_287_uq UNIQUE (code,subdivision)
);

-- 288 Ukraine -----------------------------------------------------------------

-- TODO: Need CSV Data
-- TODO: adif.view_pas_287
CREATE TABLE adif.pas_288
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char SU, TE, CH, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_288_uq UNIQUE (code,subdivision)
);

-- 291 United States -----------------------------------------------------------

-- TODO: Needs CSV Data
-- TODO: adif.view_pas_291
CREATE TABLE adif.pas_291
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two letter state code
    subdivision VARCHAR(60) NOT NULL, -- state name
    CONSTRAINT pas_291_uq UNIQUE (code,subdivision)
);

-- PAS-291 United States CQ Zone
-- TODO: Need CSV Data
CREATE TABLE adif.pas_291_cqzone
(
    id SERIAL PRIMARY KEY,
    pas_291_id INT NOT NULL,
    cq_zone_id INT NOT NULL
);

-- PAS-291 United States ITU Zone
-- TODO Need CSV Data
CREATE TABLE adif.pas_291_ituzone
(
    id SERIAL PRIMARY KEY,
    pas_291_id INT NOT NULL,
    itu_zone_id INT NOT NULL
);

-- 318 China -------------------------------------------------------------------

-- TODO: Need CSV Data
-- TODO: adif.view_pas_287
CREATE TABLE adif.pas_318
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char AH, BJ, CQ, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_318_uq UNIQUE (code,subdivision)
);

-- 327 Indonesia ---------------------------------------------------------------

-- TODO: Need CSV Data
-- TODO: adif.view_pas_327
CREATE TABLE adif.pas_327
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char BA, BB, BT, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_327_uq UNIQUE (code,subdivision)
);

-- 339 Japan -------------------------------------------------------------------

-- NOTE: Japan has Regions and Subdivisions
-- TODO: Need CSV Data
-- TODO: adif.view_pas_327_region
CREATE TABLE adif.pas_339_region
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    region VARCHAR(20) NOT NULL,
    CONSTRAINT pas_339_region_uq UNIQUE (region)
);

-- TODO: Need CSV Data
-- TODO: adif.view_pas_327_subdivision
CREATE TABLE adif.pas_339_subdivision
(
    id SERIAL PRIMARY KEY,
    pas_339_region_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char 01, 02, 03, ...
    subdivision VARCHAR(20) NOT NULL,
    CONSTRAINT pas_339_subdivision_uq UNIQUE (code,subdivision)
);

-- 375 Philippines -------------------------------------------------------------

-- NOTE: Philippines has Regions and Subdivisions
-- TODO: Need CSV Data
-- TODO: adif.view_pas_375_region
CREATE TABLE adif.pas_375_region
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    region VARCHAR(60) NOT NULL,
    CONSTRAINT pas_375_region_uq UNIQUE (region)
);

-- TODO: Need CSV Data
-- TODO: adif.view_pas_375_subdivision
CREATE TABLE adif.pas_375_subdivision
(
    id SERIAL PRIMARY KEY,
    pas_375_region_id INT NOT NULL,
    code CHAR(3) NOT NULL, -- three char AUR, BTG, CAV, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_375_subdivision_uq UNIQUE (code,subdivision)
);

-- 386 Taiwan ------------------------------------------------------------------

-- TODO: Need CSV Data
-- TODO: adif.view_pas_386
CREATE TABLE adif.pas_386
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(3) NOT NULL, -- two char DAS, DAO, CAM, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_386_uq UNIQUE (code,subdivision)
);

-- 387 Thailand ----------------------------------------------------------------

-- TODO: Need CSV Data
-- TODO: adif.view_pas_387
CREATE TABLE adif.pas_387
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char 37, 25, 81, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_387_uq UNIQUE (code,subdivision)
);

-- 497 Crotia ------------------------------------------------------------------

-- TODO: Need CSV Data
-- TODO: adif.view_pas_497
CREATE TABLE adif.pas_497
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char 01, 02, 03, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_497_uq UNIQUE (code,subdivision)
);

-- 503 Czech Republic ----------------------------------------------------------

-- TODO: Need CSV Data
-- TODO: adif.view_pas_503_region
CREATE TABLE adif.pas_503_region
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    region VARCHAR(20) NOT NULL,
    CONSTRAINT pas_503_region_uq UNIQUE (region)
);

-- TODO: Need CSV Data
-- TODO: adif.view_pas_503_subdivision
CREATE TABLE adif.pas_503_subdivision
(
    id SERIAL PRIMARY KEY,
    pas_503_region_id INT NOT NULL,
    code CHAR(3) NOT NULL, -- two char APA, APB, APC, ...
    subdivision VARCHAR(20) NOT NULL,
    CONSTRAINT pas_503_subdivision_uq UNIQUE (code,subdivision)
);

-- 504 Slovak Republic ---------------------------------------------------------

-- TODO: Need CSV Data
-- TODO: adif.view_pas_504_region
CREATE TABLE adif.pas_504_region
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    region VARCHAR(20) NOT NULL,
    CONSTRAINT pas_504_region_uq UNIQUE (region)
);

-- TODO: Need CSV Data
-- TODO: adif.view_pas_504_subdivision
CREATE TABLE adif.pas_504_subdivision
(
    id SERIAL PRIMARY KEY,
    pas_504_region_id INT NOT NULL,
    code CHAR(3) NOT NULL, -- two char BAA, BAB, BAC, ...
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

-- PAS Summary FK's ------------------------------------------------------------
ALTER TABLE adif.pas_summary ADD CONSTRAINT pas_summary_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES adif.dxcc (id);

ALTER TABLE adif.pas_summary ADD CONSTRAINT pas_summary_pas_subdivision_type_fkey
    FOREIGN KEY (pas_subdivision_type_id) REFERENCES adif.pas_subdivision_type (id);

ALTER TABLE adif.pas_summary ADD CONSTRAINT pas_summary_sas_subdivision_type_fkey
    FOREIGN KEY (sas_subdivision_type_id) REFERENCES adif.sas_subdivision_type (id);

-- PAS-001 Canada FK's ---------------------------------------------------------
ALTER TABLE adif.pas_001 ADD CONSTRAINT pas_001_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES adif.dxcc (id);

ALTER TABLE adif.pas_001_cqzone ADD CONSTRAINT pas_001_cqzone_pas_001_fkey
    FOREIGN KEY (pas_001_id) REFERENCES adif.pas_001 (id);

ALTER TABLE adif.pas_001_cqzone ADD CONSTRAINT pas_001_cqzone_cq_zone_fkey
    FOREIGN KEY (cq_zone_id) REFERENCES adif.cq_zone (id);

ALTER TABLE adif.pas_001_ituzone ADD CONSTRAINT pas_001_ituzone_pas_001_fkey
    FOREIGN KEY (pas_001_id) REFERENCES adif.pas_001 (id);

ALTER TABLE adif.pas_001_ituzone ADD CONSTRAINT pas_001_ituzone_itu_zone_fkey
    FOREIGN KEY (itu_zone_id) REFERENCES adif.itu_zone (id);

-- PAS-005 Aland Is. FK's ------------------------------------------------------
ALTER TABLE adif.pas_005 ADD CONSTRAINT pas_005_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES adif.dxcc (id);

-- 6 Alaska --------------------------------------------------------------------
ALTER TABLE adif.pas_006 ADD CONSTRAINT pas_006_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES adif.dxcc (id);

-- PAS-015 Asiatic Russia ------------------------------------------------------
ALTER TABLE adif.pas_015 ADD CONSTRAINT pas_015_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES adif.dxcc (id);

ALTER TABLE adif.pas_015_history ADD CONSTRAINT pas_015_history_pas_015_fkey
    FOREIGN KEY (pas_015_id) REFERENCES adif.pas_015 (id);

ALTER TABLE adif.pas_015_cqzone ADD CONSTRAINT pas_015_cqzone_pas_015_fkey
    FOREIGN KEY (pas_015_id) REFERENCES adif.pas_015 (id);

ALTER TABLE adif.pas_015_cqzone ADD CONSTRAINT pas_015_cqzone_cq_zone_fkey
    FOREIGN KEY (cq_zone_id) REFERENCES adif.cq_zone (id);

ALTER TABLE adif.pas_015_ituzone ADD CONSTRAINT pas_015_ituzone_pas_015_fkey
    FOREIGN KEY (pas_015_id) REFERENCES adif.pas_015 (id);

ALTER TABLE adif.pas_015_ituzone ADD CONSTRAINT pas_015_ituzone_itu_zone_fkey
    FOREIGN KEY (itu_zone_id) REFERENCES adif.itu_zone (id);

-- PAS-021 Beleric Is. ---------------------------------------------------------
ALTER TABLE adif.pas_021 ADD CONSTRAINT pas_021_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES adif.dxcc (id);

-- PAS-027 Belarus -------------------------------------------------------------
ALTER TABLE adif.pas_027 ADD CONSTRAINT pas_027_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES adif.dxcc (id);

-- PAS-029 Canary Is. ----------------------------------------------------------
ALTER TABLE adif.pas_029 ADD CONSTRAINT pas_029_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES adif.dxcc (id);

-- PAS-032 Cetua & Melilla -----------------------------------------------------
ALTER TABLE adif.pas_032 ADD CONSTRAINT pas_032_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES adif.dxcc (id);

-- PAS-050 Mexico --------------------------------------------------------------
ALTER TABLE adif.pas_050 ADD CONSTRAINT pas_050_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES adif.dxcc (id);

-- PAS-052 Estonia -------------------------------------------------------------
ALTER TABLE adif.pas_052 ADD CONSTRAINT pas_052_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES adif.dxcc (id);

-- PAS-054 European Russia -----------------------------------------------------
ALTER TABLE adif.pas_054 ADD CONSTRAINT pas_054_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES adif.dxcc (id);

ALTER TABLE adif.pas_054 ADD CONSTRAINT pas_054_cq_zone_fkey
    FOREIGN KEY (cq_zone_id) REFERENCES adif.cq_zone (id);

ALTER TABLE adif.pas_054 ADD CONSTRAINT pas_054_itu_zone_fkey
    FOREIGN KEY (itu_xone_id) REFERENCES adif.itu_zone (id);

-- PAS-061 Franz Josef Land ----------------------------------------------------
ALTER TABLE adif.pas_061 ADD CONSTRAINT pas_061_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES adif.dxcc (id);

-- PAS-070 Cuba ----------------------------------------------------------------
ALTER TABLE adif.pas_070 ADD CONSTRAINT pas_070_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES adif.dxcc (id);

-- PAS-074 El Salvador ---------------------------------------------------------
ALTER TABLE adif.pas_074 ADD CONSTRAINT pas_074_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES adif.dxcc (id);

-- PAS-086 Nicaragua -----------------------------------------------------------
ALTER TABLE adif.pas_086 ADD CONSTRAINT pas_086_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES adif.dxcc (id);

-- PAS-100 Argintina -----------------------------------------------------------
ALTER TABLE adif.pas_100 ADD CONSTRAINT pas_100_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES adif.dxcc (id);

-- PAS-104 Bolivia -------------------------------------------------------------
ALTER TABLE adif.pas_104 ADD CONSTRAINT pas_104_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES adif.dxcc (id);

-- PAS-108 Brazil --------------------------------------------------------------
ALTER TABLE adif.pas_108 ADD CONSTRAINT pas_108_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES adif.dxcc (id);

-- PAS-110 Hawaii --------------------------------------------------------------
ALTER TABLE adif.pas_110 ADD CONSTRAINT pas_110_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES adif.dxcc (id);

-- PAS-112 Chile ---------------------------------------------------------------
ALTER TABLE adif.pas_112 ADD CONSTRAINT pas_112_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES adif.dxcc (id);

-- PAS-126 Kalingrad -----------------------------------------------------------
ALTER TABLE adif.pas_126 ADD CONSTRAINT pas_126_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES adif.dxcc (id);

ALTER TABLE adif.pas_126 ADD CONSTRAINT pas_126_cq_zone_fkey
    FOREIGN KEY (cq_zone_id) REFERENCES adif.cq_zone (id);

ALTER TABLE adif.pas_126 ADD CONSTRAINT pas_126_itu_zone_fkey
    FOREIGN KEY (itu_xone_id) REFERENCES adif.itu_zone (id);

-- PAS-130 Kazakhstan ----------------------------------------------------------
ALTER TABLE adif.pas_130 ADD CONSTRAINT pas_130_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES adif.dxcc (id);

-- PAS-132 Paraguay ------------------------------------------------------------
ALTER TABLE adif.pas_132 ADD CONSTRAINT pas_132_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES adif.dxcc (id);

-- PAS-137 Republic of Korea ---------------------------------------------------
ALTER TABLE adif.pas_137 ADD CONSTRAINT pas_137_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES adif.dxcc (id);

-- PAS-138 Kure Island ---------------------------------------------------------
ALTER TABLE adif.pas_138 ADD CONSTRAINT pas_138_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES adif.dxcc (id);

-- PAS-144 Uruguay -------------------------------------------------------------
ALTER TABLE adif.pas_144 ADD CONSTRAINT pas_144_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES adif.dxcc (id);

-- PAS-147 Lord Howe Is. -------------------------------------------------------
ALTER TABLE adif.pas_147 ADD CONSTRAINT pas_147_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES adif.dxcc (id);

-- PAS-148 Venezuela ---------------------------------------------------------------
ALTER TABLE adif.pas_148 ADD CONSTRAINT pas_148_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES adif.dxcc (id);

-- PAS-149 Azores --------------------------------------------------------------
ALTER TABLE adif.pas_149 ADD CONSTRAINT pas_149_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES adif.dxcc (id);

-- PAS-150 Australia -----------------------------------------------------------
ALTER TABLE adif.pas_150 ADD CONSTRAINT pas_150_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES adif.dxcc (id);

-- 151 Malyj Vysotski Is -------------------------------------------------------
ALTER TABLE adif.pas_151 ADD CONSTRAINT pas_151_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES adif.dxcc (id);

-- PAS-153 Macquarie Is. -------------------------------------------------------
ALTER TABLE adif.pas_153 ADD CONSTRAINT pas_153_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES adif.dxcc (id);

-- PAS-163 Papua New Guinea ----------------------------------------------------
ALTER TABLE adif.pas_163 ADD CONSTRAINT pas_163_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES adif.dxcc (id);

-- PAS-170 New Zealand ---------------------------------------------------------
ALTER TABLE adif.pas_170 ADD CONSTRAINT pas_170_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES adif.dxcc (id);

-- PAS-177 Minami Torishima ----------------------------------------------------
ALTER TABLE adif.pas_177 ADD CONSTRAINT pas_177_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES adif.dxcc (id);

-- PAS-179 Moldova -----------------------------------------------------------------
ALTER TABLE adif.pas_179 ADD CONSTRAINT pas_179_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES adif.dxcc (id);

-- PAS-192 Ogasawara -----------------------------------------------------------
ALTER TABLE adif.pas_192 ADD CONSTRAINT pas_192_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES adif.dxcc (id);

-- PAS-206 Austria -------------------------------------------------------------
ALTER TABLE adif.pas_206_region ADD CONSTRAINT pas_206_region_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES adif.dxcc (id);

ALTER TABLE adif.pas_206_subdivision ADD CONSTRAINT pas_206_subdivision_pas_206_region_fkey
    FOREIGN KEY (pas_206_region_id) REFERENCES adif.pas_206_region (id);

-- PAS-209 Belgium -----------------------------------------------------------------
ALTER TABLE adif.pas_209 ADD CONSTRAINT pas_209_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES adif.dxcc (id);

-- PAS-212 Bulgaria ------------------------------------------------------------
ALTER TABLE adif.pas_212_region ADD CONSTRAINT pas_212_region_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES adif.dxcc (id);

ALTER TABLE adif.pas_212_subdivision ADD CONSTRAINT pas_212_subdivision_pas_212_region_fkey
    FOREIGN KEY (pas_212_region_id) REFERENCES adif.pas_212_region (id);

-- PAS-214 Corsica -------------------------------------------------------------
ALTER TABLE adif.pas_214 ADD CONSTRAINT pas_214_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES adif.dxcc (id);

-- PAS-221 Denmark -------------------------------------------------------------
ALTER TABLE adif.pas_221 ADD CONSTRAINT pas_221_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES adif.dxcc (id);

-- PAS-224 Finland -------------------------------------------------------------
ALTER TABLE adif.pas_224_region ADD CONSTRAINT pas_224_region_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES adif.dxcc (id);

ALTER TABLE adif.pas_224_subdivision ADD CONSTRAINT pas_224_subdivision_pas_224_region_fkey
    FOREIGN KEY (pas_224_region_id) REFERENCES adif.pas_224_region (id);

-- PAS-225 Sardinia ------------------------------------------------------------
ALTER TABLE adif.pas_225_region ADD CONSTRAINT pas_225_region_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES adif.dxcc (id);

ALTER TABLE adif.pas_225_subdivision ADD CONSTRAINT pas_225_subdivision_pas_225_region_fkey
    FOREIGN KEY (pas_225_region_id) REFERENCES adif.pas_225_region (id);

-- PAS-227 France --------------------------------------------------------------
ALTER TABLE adif.pas_227 ADD CONSTRAINT pas_227_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES adif.dxcc (id);

-- PAS-230 Fed. Rep. of Germany ------------------------------------------------
ALTER TABLE adif.pas_230 ADD CONSTRAINT pas_230_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES adif.dxcc (id);

-- PAS-239 Hungary -------------------------------------------------------------
ALTER TABLE adif.pas_239 ADD CONSTRAINT pas_239_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES adif.dxcc (id);

-- PAS-245 Ireland -------------------------------------------------------------
ALTER TABLE adif.pas_245 ADD CONSTRAINT pas_245_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES adif.dxcc (id);

-- PAS-248 Italy ---------------------------------------------------------------
ALTER TABLE adif.pas_248_region ADD CONSTRAINT pas_248_region_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES adif.dxcc (id);

ALTER TABLE adif.pas_248_subdivision ADD CONSTRAINT pas_248_subdivision_pas_248_region_fkey
    FOREIGN KEY (pas_248_region_id) REFERENCES adif.pas_248_region (id);

-- PAS-256 Maderia Is. ---------------------------------------------------------
ALTER TABLE adif.pas_256 ADD CONSTRAINT pas_256_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES adif.dxcc (id);

-- PAS-263 Netherlands ---------------------------------------------------------
ALTER TABLE adif.pas_263 ADD CONSTRAINT pas_263_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES adif.dxcc (id);

-- PAS-269 Poland --------------------------------------------------------------
ALTER TABLE adif.pas_269 ADD CONSTRAINT pas_269_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES adif.dxcc (id);

-- PAS-272 Portugal ------------------------------------------------------------
ALTER TABLE adif.pas_272 ADD CONSTRAINT pas_272_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES adif.dxcc (id);

-- PAS-275 Romania -------------------------------------------------------------
ALTER TABLE adif.pas_275 ADD CONSTRAINT pas_275_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES adif.dxcc (id);

-- PAS-281 Spain ---------------------------------------------------------------
ALTER TABLE adif.pas_281 ADD CONSTRAINT pas_281_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES adif.dxcc (id);

-- 284 Sweden ------------------------------------------------------------------
ALTER TABLE adif.pas_284 ADD CONSTRAINT pas_284_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES adif.dxcc (id);

-- 287 Switzerland -------------------------------------------------------------
ALTER TABLE adif.pas_287 ADD CONSTRAINT pas_287_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES adif.dxcc (id);

-- 288 Ukraine -----------------------------------------------------------------
ALTER TABLE adif.pas_288 ADD CONSTRAINT pas_288_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES adif.dxcc (id);

-- 291 United States -----------------------------------------------------------
ALTER TABLE adif.pas_291 ADD CONSTRAINT pas_291_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES adif.dxcc (id);

ALTER TABLE adif.pas_291_cqzone ADD CONSTRAINT pas_291_cqzone_pas_291_fkey
    FOREIGN KEY (pas_291_id) REFERENCES adif.pas_291 (id);

ALTER TABLE adif.pas_291_cqzone ADD CONSTRAINT pas_291_cqzone_cq_zone_fkey
    FOREIGN KEY (cq_zone_id) REFERENCES adif.cq_zone (id);

ALTER TABLE adif.pas_291_ituzone ADD CONSTRAINT pas_291_ituzone_pas_291_fkey
    FOREIGN KEY (pas_291_id) REFERENCES adif.pas_291 (id);

ALTER TABLE adif.pas_291_ituzone ADD CONSTRAINT pas_291_ituzone_itu_zone_fkey
    FOREIGN KEY (itu_zone_id) REFERENCES adif.itu_zone (id);

-- PAS-318 China ---------------------------------------------------------------
ALTER TABLE adif.pas_318 ADD CONSTRAINT pas_318_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES adif.dxcc (id);

-- PAS-327 Indonesia -----------------------------------------------------------
ALTER TABLE adif.pas_327 ADD CONSTRAINT pas_327_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES adif.dxcc (id);

-- PAS-339 Japan ---------------------------------------------------------------
ALTER TABLE adif.pas_339_region ADD CONSTRAINT pas_339_region_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES adif.dxcc (id);

ALTER TABLE adif.pas_339_subdivision ADD CONSTRAINT pas_339_subdivision_pas_339_region_fkey
    FOREIGN KEY (pas_339_region_id) REFERENCES adif.pas_339_region (id);

-- PAS-375 Philippines ---------------------------------------------------------
ALTER TABLE adif.pas_375_region ADD CONSTRAINT pas_375_region_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES adif.dxcc (id);

ALTER TABLE adif.pas_375_subdivision ADD CONSTRAINT pas_375_subdivision_pas_375_region_fkey
    FOREIGN KEY (pas_375_region_id) REFERENCES adif.pas_375_region (id);

-- PAS-386 Taiwan --------------------------------------------------------------
ALTER TABLE adif.pas_386 ADD CONSTRAINT pas_386_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES adif.dxcc (id);

-- PAS-387 Thailand ------------------------------------------------------------
ALTER TABLE adif.pas_387 ADD CONSTRAINT pas_387_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES adif.dxcc (id);

-- PAS-497 Crotia ------------------------------------------------------------------
ALTER TABLE adif.pas_497 ADD CONSTRAINT pas_497_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES adif.dxcc (id);


-- 503 Czech Republic ----------------------------------------------------------
ALTER TABLE adif.pas_503_region ADD CONSTRAINT pas_503_region_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES adif.dxcc (id);

ALTER TABLE adif.pas_503_subdivision ADD CONSTRAINT pas_503_subdivision_pas_503_region_fkey
    FOREIGN KEY (pas_503_region_id) REFERENCES adif.pas_503_region (id);

-- 504 Slovak Republic ---------------------------------------------------------
ALTER TABLE adif.pas_504_region ADD CONSTRAINT pas_504_region_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES adif.dxcc (id);

ALTER TABLE adif.pas_504_subdivision ADD CONSTRAINT pas_504_subdivision_pas_504_region_fkey
    FOREIGN KEY (pas_504_region_id) REFERENCES adif.pas_504_region (id);


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