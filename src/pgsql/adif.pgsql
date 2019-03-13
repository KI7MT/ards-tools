/* 
    Project .............: Amateur Radio Data Serivce Tools
    Author ..............: Greg, Beam, KI7MT, <ki7mt@yahoo.com>
    Copyright ...........: Copyright (C) 2018-2019 Greg Beam, KI7MT
    License .............: GPL-3

    File ................: pgsql
    Description .........: ADIF Database Initiation
    Database Type .......: PostgreSQL v11 or later
    Version .............: 0.0.1
    ADIF Specification ..: 3.0.9
    ADIF Refrence .......: http://www.org/309/ADIF_309.htm#Enumerations
    Bug Reports .........: https://github.com/KI7MT/ards-tools/issues'

    Comments
    
        This schema implements section III.B of the Amateur Data Interchange
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
    
        * Clone the repository

            git clone https://github.com/KI7MT/ards-tools.git
        
        * Change directories and run the sql script

            cd ards-tools\src\pgsql

            psql -v ON_ERROR_STOP=1 -U ards -f pgsql

    Development Activity and Coding

        Suffix Annotations
        _uq     = Unique Constraint
        _pkey   = Primary Key
        _fkey   = Foreign Key

*/

-- =============================================================================
--
--  ADIF MAIN SECTION
--
-- =============================================================================

-- ADIF Base Script Variables
\set name adif
\set ver 0.0.1
\set adifv 3.0.9
\echo Generating Schema for ( :name )
\echo '-----------------------------------'

-- Drop, and re-create schema
DROP SCHEMA IF EXISTS adif CASCADE;
DROP SCHEMA IF EXISTS adif_view CASCADE;

-- Create New Schema
CREATE SCHEMA adif;
CREATE SCHEMA adif_view;

-- Source Data Informaiton -----------------------------------------------------
CREATE TABLE adif.source_list -- FK Done
(
    source_list_id SERIAL PRIMARY KEY,
    source_name VARCHAR NOT NULL,
    source_date date NOT NULL,
    verified_date date NOT NULL,
    weblink_id INT NOT NULL,
    CONSTRAINT source_name_uq UNIQUE (source_name)
);

-- Antenna Path ----------------------------------------------------------------
CREATE TABLE adif.antenna_path -- No FK needed
(
    antenna_path_id SERIAL PRIMARY KEY,
    abbreviation VARCHAR(1) NOT NULL,
    meaning VARCHAR(15) NOT NULL,
    CONSTRAINT antenna_path_uq UNIQUE (abbreviation, meaning)
);

-- ARRL Section ----------------------------------------------------------------
CREATE TABLE adif.arrl_section -- FK Done
(
    arrl_section_id SERIAL PRIMARY KEY,
    abbreviation VARCHAR(4) NOT NULL,
    name VARCHAR(70) NOT NULL,
    dxcc_code INT NOT NULL,
    from_date date,
    deleted_date date
);

-- Award -----------------------------------------------------------------------
CREATE TABLE adif.award -- No FK needed
(
    award_id SERIAL PRIMARY KEY,
    name VARCHAR(15) NOT NULL,
    is_import_only BOOLEAN DEFAULT '1',
    CONSTRAINT award_name_uq UNIQUE (name)
);

-- BAND ------------------------------------------------------------------------
CREATE TABLE adif.band -- No FK Needed
(
    band_id SERIAL PRIMARY KEY,
    name VARCHAR(6) NOT NULL,
    lower_freq NUMERIC NOT NULL,
    upper_freq NUMERIC NOT NULL,
    CONSTRAINT band_name_uq UNIQUE (name)
);

-- Contest ---------------------------------------------------------------------
CREATE TABLE adif.contest -- FK Done
(
    contest_id SERIAL PRIMARY KEY,
    name VARCHAR(60),
    description VARCHAR(120),
    is_import_only BOOLEAN NOT NULL DEFAULT '0',
    weblink_id INT,
    CONSTRAINT contest_name_uq UNIQUE (name)
);

-- Continent -------------------------------------------------------------------
CREATE TABLE adif.continent -- No FK Needed
(
    continent_id SERIAL PRIMARY KEY,
    abbreviation VARCHAR(2),
    name VARCHAR(14),
    CONSTRAINT continent_name_uq UNIQUE (abbreviation, name)
);

-- Credit Sponsor --------------------------------------------------------------
CREATE TABLE adif.credit_sponsor -- No FK Needed
(
    credit_sponsor_id SERIAL PRIMARY KEY,
    name VARCHAR(20),
    CONSTRAINT credit_sponsor_name_uq UNIQUE (name)
);

-- Credit Award ----------------------------------------------------------------
CREATE TABLE adif.credit_award -- No FK needed
(
    credit_award_id SERIAL PRIMARY KEY,
    name VARCHAR(60),
    CONSTRAINT credit_award_name_uq UNIQUE (name)
);

-- Credit Facet ----------------------------------------------------------------
CREATE TABLE adif.credit_facet -- No FK needed
(
    credit_facet_id SERIAL PRIMARY KEY,
    name VARCHAR(20),
    CONSTRAINT credit_facet_name_uq UNIQUE (name)
);

-- Credit ----------------------------------------------------------------------
CREATE TABLE adif.credit -- FK Done
(
    credit_id SERIAL PRIMARY KEY,
    credit_for VARCHAR(24) NOT NULL,
    credit_sponsor_id INT NOT NULL,
    credit_award_id INT NOT NULL,
    credit_facet_id INT NOT NULL,
    CONSTRAINT credit_for_uq UNIQUE (credit_for)
);

-- DXCC ------------------------------------------------------------------------
-- (id) is a natureal PK matching the dxcc_id
CREATE TABLE adif.dxcc -- No FK needed
(
    dxcc_id INT PRIMARY KEY,
    code VARCHAR(4) NOT NULL,
    name VARCHAR(90) NOT NULL,
    is_deleted BOOLEAN DEFAULT '0',
    CONSTRAINT dxcc_code_name_uq UNIQUE (code, name)
);

-- CQ Zone ---------------------------------------------------------------------
CREATE TABLE adif.cqzone -- FK Done
(
    cqzone_id INT PRIMARY KEY,
    cqzone INT NOT NULL,
    description VARCHAR(60) NOT NULL,
    CONSTRAINT cqzone_cqzone_uq UNIQUE (cqzone)
);

-- ITU Zone --------------------------------------------------------------------
CREATE TABLE adif.ituzone -- FK Done
(
    ituzone_id INT PRIMARY KEY,
    ituzone INT NOT NULL,
    description VARCHAR(300),
    CONSTRAINT ituzone_ituzone_uq UNIQUE (ituzone)
);

-- IARU Region -----------------------------------------------------------------
CREATE TABLE adif.iaru_region -- FK Done
(
    iaru_region_id INT PRIMARY KEY,
    region INT NOT NULL,
    description VARCHAR(120),
    CONSTRAINT iaru_region_region_uq UNIQUE (region)
);

-- IARU Region Member ----------------------------------------------------------
CREATE TABLE adif.iaru_region_member -- FK Done
(
    iaru_region_member_id INT PRIMARY KEY,
    iaru_region_id INT NOT NULL,
    name VARCHAR(120),
    country_territory VARCHAR(60),
    CONSTRAINT iaru_region_name_uq UNIQUE (iaru_region_id,name)
);

-- Mode ------------------------------------------------------------------------
CREATE TABLE adif.mode -- FK Done
(
    mode_id SERIAL PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    mode_description_id INT,
    is_import_only BOOLEAN NOT NULL DEFAULT '0',
    CONSTRAINT mode_name_uq UNIQUE (name)
);

-- Submode ---------------------------------------------------------------------
CREATE TABLE adif.submode -- FK Done
(
    submode_id SERIAL PRIMARY KEY,
    mode_id INT NOT NULL,
    name VARCHAR(20) NOT NULL,
    mode_description_id INT,
    CONSTRAINT submode_name_uq UNIQUE (name)
);

-- Mode Description ------------------------------------------------------------
CREATE TABLE adif.mode_description
(
    mode_description_id SERIAL PRIMARY KEY,
    description VARCHAR(20) NOT NULL,
    weblink_id INT
);

-- State -----------------------------------------------------------------------
CREATE TABLE adif.state -- No FK Needed
(
    state_id SERIAL PRIMARY KEY,
    abbreviation VARCHAR(2) NOT NULL,
    name VARCHAR(20) NOT NULL,
    CONSTRAINT state_uq UNIQUE (abbreviation, name)
);

-- County Name -----------------------------------------------------------------
CREATE TABLE adif.county_name -- No FK Needed
(
    county_name_id SERIAL PRIMARY KEY,
    name VARCHAR(60) NOT NULL,
    CONSTRAINT county_name_uq UNIQUE (name)
);

-- State-County ----------------------------------------------------------------
CREATE TABLE adif.state_county -- FK Done
(
    state_county_id SERIAL PRIMARY KEY,
    state_id INT NOT NULL,
    county_name_id INT NOT NULL
);

-- Propogation -----------------------------------------------------------------
CREATE TABLE adif.propogation_mode -- No FK Needed
(
    propogation_mode_id SERIAL PRIMARY KEY,
    enumeration VARCHAR(20) NOT NULL,
    description VARCHAR(120) NOT NULL,
    CONSTRAINT propogation_mode_abbreviation_uq UNIQUE (enumeration)
);

-- QSL Medium ------------------------------------------------------------------
CREATE TABLE adif.qsl_medium -- No FK Needed
(
    qsl_medium_id SERIAL PRIMARY KEY,
    medium VARCHAR(10) NOT NULL,
    description VARCHAR(120) NOT NULL,
    CONSTRAINT qsl_medium_uq UNIQUE (medium)
);

-- QSL Recieved ----------------------------------------------------------------
CREATE TABLE adif.qsl_rcvd -- No FK needed
(
    qsl_rcvd_id SERIAL PRIMARY KEY,
    status VARCHAR(1) NOT NULL,
    meaning VARCHAR(20) NOT NULL,
    description VARCHAR(255),
    is_import_only BOOLEAN NOT NULL DEFAULT '0',
    CONSTRAINT qsl_rcvd_status_uq UNIQUE (status)
);

-- QSL Sent --------------------------------------------------------------------
CREATE TABLE adif.qsl_sent --- No FK Needed
(
    qsl_sent_id SERIAL PRIMARY KEY,
    status VARCHAR(1) NOT NULL,
    meaning VARCHAR(20) NOT NULL,
    description VARCHAR(255),
    CONSTRAINT qsl_sent_status_uq UNIQUE (status)
);

-- QSL Via ---------------------------------------------------------------------
CREATE TABLE adif.qsl_via -- No FK Needed
(
    qsl_via_id SERIAL PRIMARY KEY,
    via VARCHAR(1) NOT NULL,
    description VARCHAR(20) NOT NULL,
    is_import_only BOOLEAN NOT NULL DEFAULT '0',
    CONSTRAINT qsl_via_uq UNIQUE (via)
);

-- QSO Complete ----------------------------------------------------------------
CREATE TABLE adif.qso_complete -- No FK Needed
(
    qso_complete_id SERIAL PRIMARY KEY,
    abbreviation VARCHAR(5) NOT NULL,
    meaning VARCHAR(20) NOT NULL,
    CONSTRAINT qso_complete_abbreviation_uq UNIQUE (abbreviation)
);

-- QSO Upload Status -----------------------------------------------------------
CREATE TABLE adif.qso_upload_status -- No FK Needed
(
    qso_upload_status_id SERIAL PRIMARY KEY,
    abbreviation VARCHAR(1) NOT NULL,
    description VARCHAR(120) NOT NULL,
    CONSTRAINT qso_upload_status_abbreviation_uq UNIQUE (abbreviation)
);

-- Region ----------------------------------------------------------------------
CREATE TABLE adif.region -- No FK Needed
(
    region_id SERIAL PRIMARY KEY,
    code VARCHAR(4),
    dxcc_code VARCHAR(4),
    region VARCHAR(120),
    prefix VARCHAR(10),
    CONSTRAINT region_code_uq UNIQUE (code)
);

-- Region Applicability --------------------------------------------------------
CREATE TABLE adif.region_applicability -- FK Done
(
    region_applicability_id SERIAL PRIMARY KEY,
    region_id INT NOT NULL,
    weblink_id INT NOT NULL
);

-- Web Link Section ------------------------------------------------------------
CREATE TABLE adif.weblink -- No FK needed
(
    weblink_id SERIAL PRIMARY KEY,
    display_text VARCHAR(120) NOT NULL,
    url VARCHAR(255) NOT NULL,
    CONSTRAINT weblink_display_text_uq UNIQUE (display_text)
);

-- Sponsored Award -------------------------------------------------------------
CREATE TABLE adif.sponsored_award
(
    sponsored_award_id SERIAL PRIMARY KEY,
    sponsor VARCHAR(20) NOT NULL,
    weblink_id INT NOT NULL,
    CONSTRAINT qso_sponsored_award_sponsor_uq UNIQUE (sponsor)
);

-- PAS Tables and Data ---------------------------------------------------------
CREATE TABLE adif.pas
(
    pas_id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,                           -- DXCC Country
    pas_region_id INT,                              -- Region, if applicable
    pas_code CHAR(4) NOT NULL,                      -- code for the subdivision
    subdivision VARCHAR(120) NOT NULL,              -- subdivision name
    oblast CHAR(4),                                 -- Oblast number
    referred_to_as VARCHAR(60),                     -- Alias Names
    is_deleted BOOLEAN DEFAULT '0',                 -- is a deleted subdivision
    is_import_only BOOLEAN DEFAULT '0',             -- Can only be imported
    before_date DATE,                               -- For QSO's Made BEFORE date
    after_date DATE,                                -- For QSO's made ON or AFTER date
    CONSTRAINT pas_uq UNIQUE (dxcc_id,pas_code,subdivision)
);

-- PAS Summary
CREATE TABLE adif.pas_summary
(
    pas_summary_id SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    pas_type_id INT NOT NULL,
    has_oblast BOOLEAN NOT NULL DEFAULT '0',
    has_sas BOOLEAN NOT NULL DEFAULT '0',
    sas_type_id INT,
    CHECK ( NOT (has_sas AND sas_type_id IS NULL) )
); 

-- Primary Administration Subdivision Type
CREATE TABLE adif.pas_type
(
    pas_type_id SERIAL PRIMARY KEY,
    pas_type VARCHAR(20) NOT NULL,
    CONSTRAINT pas_type_uq UNIQUE (pas_type)
);

-- PAS Region
CREATE TABLE adif.pas_region
(
    pas_region_id SERIAL PRIMARY KEY,
    region VARCHAR(120) NOT NULL,
    CONSTRAINT pas_region_uq UNIQUE (region)
);

-- PAS CQ Zone
CREATE TABLE adif.pas_cqzone
(
    pas_cqzone_id SERIAL PRIMARY KEY,
    pas_id INT NOT NULL,
    cqzone_id INT NOT NULL
);

-- PAS ITU Zone
CREATE TABLE adif.pas_ituzone
(
    pas_ituzone_id SERIAL PRIMARY KEY,
    pas_id INT NOT NULL,
    ituzone_id INT NOT NULL
);

-- JARL JCC (Ku) ---------------------------------------------------------------

-- Japan Century Cities (JCC), SWL - Japan Century Cites (SWL - JCC)
-- Info Link   : https://www.jarl.org/English/4_Library/A-4-2_Awards/Aw_jcc.htm
-- Source Link : https://www.jarl.org/English/4_Library/A-4-5_jcc-jcg/jcc-list.txt
-- Total Cout = 913, Current = 815, Deleted = 98

-- JARL JCC PREFECTURES
CREATE TABLE adif.jcc
(
    jcc_id SERIAL PRIMARY KEY,
    prefecture VARCHAR(30) NOT NULL,
    prefix CHAR(2) NOT NULL,
    CONSTRAINT jcc_uq UNIQUE(prefecture)
);

-- JARL JCC CITIES
CREATE TABLE adif.jcc_city
(
    jcc_city_id SERIAL PRIMARY KEY,
    jcc_id INT NOT NULL,
    number CHAR(6),
    city VARCHAR(30),
    is_deleted BOOLEAN NOT NULL DEFAULT '0',
    deleted_date date,
    CONSTRAINT jcc_city_uq UNIQUE(number,city)
);

-- JARL JCC FK
ALTER TABLE adif.jcc_city ADD CONSTRAINT jcc_city_jcc_fkey
    FOREIGN KEY (jcc_id) REFERENCES adif.jcc (jcc_id);

-- RDXC Oblasts ----------------------------------------------------------------

-- RDXC Table for Oblasts
CREATE TABLE adif.rdxc
(
    rdxc_id SERIAL PRIMARY KEY,
    prefix CHAR(4) NOT NULL,
    rdxc_code CHAR(4) NOT NULL,
    oblast VARCHAR(60) NOT NULL,
    is_deleted BOOLEAN NOT NULL DEFAULT '0',
    CONSTRAINT rdxc_uq UNIQUE(prefix,rdxc_code,oblast)
);

-- RDXC Table for Districts under each Oblast
CREATE TABLE adif.rdxc_district
(
    rdxc_district_id SERIAL PRIMARY KEY,
    rdxc_id INT NOT NULL,
    code CHAR(5) NOT NULL,
    district VARCHAR(120),
    valid_since DATE,
    is_deleted BOOLEAN NOT NULL DEFAULT '0',
    is_new_rda BOOLEAN NOT NULL DEFAULT '0',
    has_replacement BOOLEAN NOT NULL DEFAULT '0',
    migration_district CHAR(5),
    CONSTRAINT rdxc_district_uq UNIQUE(code,district)
);

-- Secondary Administration Subdivision ----------------------------------------
-- SAS Main Table
-- NEED FK to dxcc_id
CREATE TABLE adif.sas
(
    sas_id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    prefix VARCHAR(120),
    name VARCHAR(120),
    code VARCHAR(120),
    description VARCHAR(120),
    CONSTRAINT sas_uq UNIQUE (dxcc_id,prefix,name,code)
);

-- SAS Type
-- Need FK to dxcc_id
CREATE TABLE adif.sas_type
(
    sas_type_id SERIAL PRIMARY KEY,
    sas_type VARCHAR(20) NOT NULL,
    CONSTRAINT sas_type_uq UNIQUE (sas_type)
);

-- *****************************************************************************
--  ADD CSV DATA
-- *****************************************************************************

-- NOTE(s): 
-- Note: All CSV File use "|" as the delimiter.

\echo
\echo 'Importing CSV Files'
\echo '---------------------------'
\COPY adif.antenna_path FROM 'adif/antenna_path.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY adif.arrl_section FROM 'adif/arrl_section.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY adif.award FROM 'adif/award.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY adif.band FROM 'adif/band.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY adif.contest FROM 'adif/contest.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY adif.continent FROM 'adif/continent.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY adif.county_name FROM 'adif/county_name.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY adif.credit FROM 'adif/credit.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY adif.credit_award FROM 'adif/credit_award.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY adif.credit_facet FROM 'adif/credit_facet.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY adif.credit_sponsor FROM 'adif/credit_sponsor.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY adif.dxcc FROM 'adif/dxcc.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY adif.state FROM 'adif/state.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY adif.state_county FROM 'adif/state_county.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY adif.mode FROM 'adif/mode.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY adif.submode FROM 'adif/submode.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY adif.propogation_mode FROM 'adif/propogation_mode.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY adif.qsl_medium FROM 'adif/qsl_medium.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY adif.qsl_rcvd FROM 'adif/qsl_rcvd.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY adif.qsl_sent FROM 'adif/qsl_sent.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY adif.qsl_via FROM 'adif/qsl_via.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY adif.qso_complete FROM 'adif/qso_complete.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY adif.qso_upload_status FROM 'adif/qso_upload_status.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY adif.region FROM 'adif/region.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY adif.region_applicability FROM 'adif/region_applicability.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY adif.weblink FROM 'adif/weblink.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY adif.sponsored_award FROM 'adif/sponsored_award.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY adif.cqzone FROM 'adif/cqzone.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY adif.ituzone FROM 'adif/ituzone.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY adif.iaru_region FROM 'adif/iaru_region.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY adif.iaru_region_member FROM 'adif/iaru_region_member.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS Data
\COPY adif.pas_type FROM 'adif/pas_type.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY adif.pas_summary FROM 'adif/pas_summary.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY adif.pas FROM 'adif/pas.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY adif.pas_region FROM 'adif/pas_region.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY adif.pas_cqzone FROM 'adif/pas_cqzone.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY adif.pas_ituzone FROM 'adif/pas_ituzone.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- JARL JCC DATA
\COPY adif.jcc FROM 'adif/jcc.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY adif.jcc_city FROM 'adif/jcc_city.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- JARL JCG Data

-- JARL Ku Data

-- RDXC Data (Oblasts and Districts)
\COPY adif.rdxc FROM 'adif/rdxc.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY adif.rdxc_district FROM 'adif/rdxc_district.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- SASA Data
\COPY adif.sas_type FROM 'adif/sas_type.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY adif.sas FROM 'adif/sas.csv' DELIMITER '|' QUOTE '"' HEADER CSV;


-- *****************************************************************************
--  ADD FOREIGN KEYS
-- *****************************************************************************

\echo
\echo 'Adding Foreign Keys'
\echo '---------------------------'

-- Source List -----------------------------------------------------------------
ALTER TABLE adif.source_list ADD CONSTRAINT source_list_weblink_fkey
    FOREIGN KEY (weblink_id) REFERENCES adif.weblink (weblink_id);

-- Contest ---------------------------------------------------------------------
ALTER TABLE adif.contest ADD CONSTRAINT contest_weblink_fkey
    FOREIGN KEY (weblink_id) REFERENCES adif.weblink (weblink_id);

-- Credit ----------------------------------------------------------------------
ALTER TABLE adif.credit ADD CONSTRAINT credit_credit_sponsor_fkey
    FOREIGN KEY (credit_sponsor_id) REFERENCES adif.credit_sponsor (credit_sponsor_id);

ALTER TABLE adif.credit ADD CONSTRAINT credit_credit_award_fkey
    FOREIGN KEY (credit_award_id) REFERENCES adif.credit_award (credit_award_id);

ALTER TABLE adif.credit ADD CONSTRAINT credit_credit_facet_fkey
    FOREIGN KEY (credit_facet_id) REFERENCES adif.credit_facet (credit_facet_id);

-- IARU Region Member ----------------------------------------------------------
ALTER TABLE adif.iaru_region_member ADD CONSTRAINT iaru_region_member_iaru_region_fkey
    FOREIGN KEY (iaru_region_id) REFERENCES adif.iaru_region (iaru_region_id);

-- State County ----------------------------------------------------------------
ALTER TABLE adif.state_county ADD CONSTRAINT state_county_state_fkey
    FOREIGN KEY (state_id) REFERENCES adif.state (state_id);

ALTER TABLE adif.state_county ADD CONSTRAINT state_county_county_name_fkey
    FOREIGN KEY (county_name_id) REFERENCES adif.county_name (county_name_id);

-- Mode ------------------------------------------------------------------------
ALTER TABLE adif.mode ADD CONSTRAINT mode_mode_description_fkey
    FOREIGN KEY (mode_description_id) REFERENCES adif.mode_description (mode_description_id);

-- Submode ---------------------------------------------------------------------
ALTER TABLE adif.submode ADD CONSTRAINT submode_mode_fkey
    FOREIGN KEY (mode_id) REFERENCES adif.mode (mode_id);

ALTER TABLE adif.submode ADD CONSTRAINT submode_mode_description_fkey
    FOREIGN KEY (mode_description_id) REFERENCES adif.mode_description (mode_description_id);

-- Mode Description ------------------------------------------------------------
ALTER TABLE adif.mode_description ADD CONSTRAINT mode_description_weblink_fkey
    FOREIGN KEY (weblink_id) REFERENCES adif.weblink (weblink_id);

-- Region Applicabiility -------------------------------------------------------
ALTER TABLE adif.region_applicability ADD CONSTRAINT region_applicability_region_fkey
    FOREIGN KEY (region_id) REFERENCES adif.region (region_id);

ALTER TABLE adif.region_applicability ADD CONSTRAINT region_applicability_weblink_fkey
    FOREIGN KEY (weblink_id) REFERENCES adif.weblink (weblink_id);

-- Sponsored Award -------------------------------------------------------------
ALTER TABLE adif.sponsored_award ADD CONSTRAINT sponsored_award_weblink_fkey
    FOREIGN KEY (weblink_id) REFERENCES adif.weblink (weblink_id);

-- PAS Summary FK's
ALTER TABLE adif.pas_summary ADD CONSTRAINT pas_summary_pas_type_fkey
    FOREIGN KEY (pas_type_id) REFERENCES adif.pas_type (pas_type_id);

ALTER TABLE adif.pas_summary ADD CONSTRAINT pas_summary_sas_type_fkey
    FOREIGN KEY (sas_type_id) REFERENCES adif.sas_type (sas_type_id);

-- RDXC District FK
ALTER TABLE adif.rdxc_district ADD CONSTRAINT rdxc_district_rdxc_fkey
    FOREIGN KEY (rdxc_id) REFERENCES adif.rdxc (rdxc_id);

-- *****************************************************************************
--
--
--                           ALL VIEW TABLES
--
--
-- *****************************************************************************

\echo
\echo 'Creating Views'
\echo '-----------------------------'

-- antenna_path ----------------------------------------------------------------
CREATE TABLE adif_view.antenna_path AS
    SELECT
        antenna_path.antenna_path_id,
        antenna_path.abbreviation,
        antenna_path.meaning
    FROM adif.antenna_path
    ORDER BY adif.antenna_path.abbreviation;

ALTER TABLE adif_view.antenna_path
ADD CONSTRAINT antenna_path_pkey PRIMARY KEY (antenna_path_id);


-- arrl_section ----------------------------------------------------------------
CREATE TABLE adif_view.arrl_section AS
    SELECT
        arrl_section.arrl_section_id,
        arrl_section.abbreviation,
        arrl_section.name AS section_name,
        dxcc.code AS dxcc_code,
        dxcc.name AS dxcc_name,
        arrl_section.from_date AS from_date,
        arrl_section.deleted_date AS deleted_on
    FROM adif.arrl_section
        JOIN adif.dxcc ON 
            adif.dxcc.dxcc_id = adif.arrl_section.dxcc_code
    ORDER BY arrl_section.name;

ALTER TABLE adif_view.arrl_section
ADD CONSTRAINT arrl_section_pkey PRIMARY KEY (arrl_section_id);

-- award -----------------------------------------------------------------------
CREATE TABLE adif_view.award AS
    SELECT
        award.award_id,
        award.name AS award_name,
        award.is_import_only
    FROM adif.award
    ORDER BY award.name;

ALTER TABLE adif_view.award
ADD CONSTRAINT award_pkey PRIMARY KEY (award_id);

-- band ------------------------------------------------------------------------
CREATE TABLE adif_view.band AS
    SELECT
        band.band_id,
        band.name AS band,
        band.lower_freq AS lower_freq,
        band.upper_freq AS upper_freq
    FROM adif.band
    ORDER BY band.lower_freq;

ALTER TABLE adif_view.band
ADD CONSTRAINT band_pkey PRIMARY KEY (band_id);

-- contest ---------------------------------------------------------------------
CREATE TABLE adif_view.contest AS
    SELECT
        contest.contest_id,
        contest.name AS contest_name,
        contest.description,
        contest.is_import_only,
        weblink.url AS weblink_url
    FROM adif.contest
        LEFT JOIN adif.weblink ON
            adif.weblink.weblink_id = adif.contest.weblink_id
    ORDER BY contest.name;

ALTER TABLE adif_view.contest
ADD CONSTRAINT contest_pkey PRIMARY KEY (contest_id);

-- continent -------------------------------------------------------------------
CREATE TABLE adif_view.continent AS
    SELECT
        continent.continent_id,
        continent.abbreviation,
        continent.name AS continent
    FROM adif.continent
    ORDER BY continent.abbreviation;

ALTER TABLE adif_view.continent
ADD CONSTRAINT continent_pkey PRIMARY KEY (continent_id);

-- county_name -----------------------------------------------------------------
CREATE TABLE adif_view.county_name AS
    SELECT
        county_name.county_name_id,
        county_name.name AS county_name
    FROM adif.county_name
    ORDER BY county_name.name;

ALTER TABLE adif_view.county_name
ADD CONSTRAINT county_name_pkey PRIMARY KEY (county_name_id);

-- cqzone ----------------------------------------------------------------------
CREATE TABLE adif_view.cqzone AS
    SELECT
    cqzone.cqzone_id,
       cqzone.cqzone,
       cqzone.description
    FROM adif.cqzone
    ORDER BY cqzone.cqzone;

ALTER TABLE adif_view.cqzone
ADD CONSTRAINT cqzone_pkey PRIMARY KEY (cqzone_id);

-- credit__award ---------------------------------------------------------------
CREATE TABLE adif_view.credit_award AS
    SELECT
        credit_award.credit_award_id,
        credit_award.name AS award_name
    FROM adif.credit_award
    ORDER BY credit_award.name;

ALTER TABLE adif_view.credit_award 
ADD CONSTRAINT credit_award_pkey PRIMARY KEY (credit_award_id);

-- credit_facet ----------------------------------------------------------------
CREATE TABLE adif_view.credit_facet AS
    SELECT
        credit_facet.credit_facet_id,
        credit_facet.name AS facet
    FROM adif.credit_facet
    ORDER BY credit_facet.name;

ALTER TABLE adif_view.credit_facet
ADD CONSTRAINT credit_facet_pkey PRIMARY KEY (credit_facet_id);

-- credit_sponsor --------------------------------------------------------------
CREATE TABLE adif_view.credit_sponsor AS
    SELECT
        credit_sponsor.credit_sponsor_id,
        credit_sponsor.name AS sponsor
    FROM adif.credit_sponsor
    ORDER BY credit_sponsor.name;

ALTER TABLE adif_view.credit_sponsor 
ADD CONSTRAINT credit_sponsor_pkey PRIMARY KEY (credit_sponsor_id);

-- credit ----------------------------------------------------------------------
CREATE TABLE adif_view.credit AS
    SELECT
        credit.credit_id,
        credit.credit_for,
        credit_sponsor.name AS sponsor,
        credit_award.name AS award,
        credit_facet.name AS facet
    FROM adif.credit
        LEFT JOIN adif.credit_sponsor ON
            adif.credit_sponsor.credit_sponsor_id = adif.credit.credit_sponsor_id
        LEFT JOIN adif.credit_award ON
            adif.credit_award.credit_award_id = adif.credit.credit_award_id
        LEFT JOIN adif.credit_facet ON
            adif.credit_facet.credit_facet_id = adif.credit.credit_facet_id
    ORDER BY credit_for;

ALTER TABLE adif_view.credit 
ADD CONSTRAINT credit_pkey PRIMARY KEY (credit_id);

-- dxcc ------------------------------------------------------------------------
CREATE TABLE adif_view.dxcc AS
    SELECT
        dxcc.dxcc_id,
        dxcc.code AS dxcc_code,
        dxcc.name AS dxcc_name,
        dxcc.is_deleted
    FROM adif.dxcc
    ORDER BY dxcc.code;

ALTER TABLE adif_view.dxcc 
ADD CONSTRAINT dxcc_pkey PRIMARY KEY (dxcc_id);

-- iaru_region_member-----------------------------------------------------------
CREATE TABLE adif_view.iaru_region_member AS
    SELECT
        iaru_region_member.iaru_region_member_id,
        iaru_region.region,
        iaru_region_member.name AS name,
        iaru_region_member.country_territory AS territory
    FROM adif.iaru_region_member
        JOIN adif.iaru_region ON
            iaru_region.iaru_region_id = iaru_region_member.iaru_region_id
    ORDER BY iaru_region.region, iaru_region_member.name;

ALTER TABLE adif_view.iaru_region_member 
ADD CONSTRAINT iaru_region_member_pkey PRIMARY KEY (iaru_region_member_id);

-- iaru_region -----------------------------------------------------------------
CREATE TABLE adif_view.iaru_region AS
    SELECT
        iaru_region.iaru_region_id,
        iaru_region.region,
        iaru_region.description
    FROM adif.iaru_region
    ORDER BY iaru_region.region;

ALTER TABLE adif_view.iaru_region 
ADD CONSTRAINT iaru_region_pkey PRIMARY KEY (iaru_region_id);

-- ituzone ---------------------------------------------------------------------
CREATE TABLE adif_view.ituzone AS
    SELECT
    ituzone.ituzone_id,
       ituzone.ituzone,
       ituzone.description
    FROM adif.ituzone
    ORDER BY ituzone.ituzone;

ALTER TABLE adif_view.ituzone
ADD CONSTRAINT ituuzone_pkey PRIMARY KEY (ituzone_id);

-- mode ------------------------------------------------------------------------
CREATE TABLE adif_view.mode AS
    SELECT
        mode.mode_id,
        mode.name AS mode,
        mode.is_import_only
    FROM adif.mode
    ORDER BY mode.name;

ALTER TABLE adif_view.mode
ADD CONSTRAINT mode_pkey PRIMARY KEY (mode_id);

-- propogation_mode ------------------------------------------------------------
CREATE TABLE adif_view.propogation_mode AS
    SELECT
        propogation_mode.propogation_mode_id,
        propogation_mode.enumeration,
        propogation_mode.description
    FROM adif.propogation_mode
    ORDER BY propogation_mode.enumeration;

ALTER TABLE adif_view.propogation_mode
ADD CONSTRAINT propogation_mode_pkey PRIMARY KEY (propogation_mode_id);

-- qsl_medium ------------------------------------------------------------------
CREATE TABLE adif_view.qsl_medium AS
    SELECT
        qsl_medium.qsl_medium_id,
        qsl_medium.medium,
        qsl_medium.description
    FROM adif.qsl_medium
    ORDER BY qsl_medium.medium;

ALTER TABLE adif_view.qsl_medium
ADD CONSTRAINT qsl_medium_pkey PRIMARY KEY (qsl_medium_id);

-- qsl_rcvd --------------------------------------------------------------------
CREATE TABLE adif_view.qsl_rcvd AS
    SELECT
        qsl_rcvd.qsl_rcvd_id,
        qsl_rcvd.status,
        qsl_rcvd.meaning,
        qsl_rcvd.description,
        qsl_rcvd.is_import_only
    FROM adif.qsl_rcvd
    ORDER BY qsl_rcvd.status;

ALTER TABLE adif_view.qsl_rcvd
ADD CONSTRAINT qsl_rcvd_pkey PRIMARY KEY (qsl_rcvd_id);

-- qsl_sent --------------------------------------------------------------------
CREATE TABLE adif_view.qsl_sent AS
    SELECT
        qsl_sent.qsl_sent_id,
        qsl_sent.status,
        qsl_sent.meaning,
        qsl_sent.description
    FROM adif.qsl_sent
    ORDER BY qsl_sent.status;

ALTER TABLE adif_view.qsl_sent
ADD CONSTRAINT qsl_sent_pkey PRIMARY KEY (qsl_sent_id);

-- qsl_via ---------------------------------------------------------------------
CREATE TABLE adif_view.qsl_via AS
    SELECT
        qsl_via.qsl_via_id,
        qsl_via.via,
        qsl_via.description,
        qsl_via.is_import_only
    FROM adif.qsl_via
    ORDER BY qsl_via.via;

ALTER TABLE adif_view.qsl_via
ADD CONSTRAINT qsl_via_pkey PRIMARY KEY (qsl_via_id);

-- qso_complete ----------------------------------------------------------------
CREATE TABLE adif_view.qso_complete AS
    SELECT
        qso_complete.qso_complete_id,
        qso_complete.abbreviation,
        qso_complete.meaning
    FROM adif.qso_complete
    ORDER BY qso_complete.Abbreviation;

ALTER TABLE adif_view.qso_complete
ADD CONSTRAINT qso_complete_pkey PRIMARY KEY (qso_complete_id);

-- qso_upload_status -----------------------------------------------------------
CREATE TABLE adif_view.qso_upload_status AS
    SELECT
        qso_upload_status.qso_upload_status_id,
        qso_upload_status.abbreviation,
        qso_upload_status.description
    FROM adif.qso_upload_status
    ORDER BY qso_upload_status.Abbreviation;

ALTER TABLE adif_view.qso_upload_status
ADD CONSTRAINT qso_upload_status_pkey PRIMARY KEY (qso_upload_status_id);

-- region applicability --------------------------------------------------------
CREATE TABLE adif_view.region_applicability AS
    SELECT
        region_applicability.region_applicability_id,
        region.code,
        region.dxcc_code,
        region.region,
        region.prefix,
        STRING_AGG(DISTINCT adif.weblink.display_text::text,', ') AS applicability
    FROM adif.region_applicability
        JOIN adif.region ON
            adif.region.region_id = adif.region_applicability.region_id
        JOIN adif.weblink ON
            adif.weblink.weblink_id = adif.region_applicability.weblink_id
    GROUP BY region_applicability.region_applicability_id, region.code, region.dxcc_code, region.region, region.prefix
    ORDER by region.code;

ALTER TABLE adif_view.region_applicability
ADD CONSTRAINT region_applicability_pkey PRIMARY KEY (region_applicability_id);

-- region ----------------------------------------------------------------------
CREATE TABLE adif_view.region AS
    SELECT
        region.region_id,
        region.code,
        region.dxcc_code,
        region.region,
        region.prefix
    FROM adif.region
    ORDER BY region.Code;

ALTER TABLE adif_view.region
ADD CONSTRAINT region_pkey PRIMARY KEY (region_id);

-- sponsored_award -------------------------------------------------------------
CREATE TABLE adif_view.sponsored_award AS
    SELECT
        sponsored_award.sponsored_award_id,
        sponsored_award.sponsor,
        weblink.display_text AS orginization
    FROM adif.sponsored_award
        JOIN adif.weblink ON
            adif.weblink.weblink_id = adif.sponsored_award.weblink_id
    GROUP BY sponsored_award.sponsored_award_id, sponsored_award.sponsor, weblink.display_text
    ORDER by sponsored_award.sponsor;

ALTER TABLE adif_view.sponsored_award
ADD CONSTRAINT sponsored_award_pkey PRIMARY KEY (sponsored_award_id);

-- state_county ----------------------------------------------------------------
CREATE TABLE adif_view.state_county AS
    SELECT
        state_county.state_county_id,
        state.abbreviation,
        state.name AS state_name,
        county_name.name AS county
    FROM adif.state_county
        JOIN adif.state ON
            adif.state.state_id = adif.state_county.state_id
        JOIN adif.county_name ON
            adif.county_name.county_name_id = adif.state_county.county_name_id
    ORDER by state.name;

ALTER TABLE adif_view.state_county
ADD CONSTRAINT state_county_pkey PRIMARY KEY (state_county_id);

-- state -----------------------------------------------------------------------
CREATE TABLE adif_view.state AS
    SELECT
        state.state_id,
        state.abbreviation,
        state.name AS state_name
    FROM adif.state
    ORDER BY state.name;

ALTER TABLE adif_view.state
ADD CONSTRAINT state_pkey PRIMARY KEY (state_id);

-- submode ---------------------------------------------------------------------
CREATE TABLE adif_view.submode AS
    SELECT
        submode.submode_id,
        mode.name AS mode,
        submode.name AS submode
    FROM adif.submode
        JOIN adif.mode ON
            mode.mode_id = submode.mode_id
    ORDER BY submode.name;

ALTER TABLE adif_view.submode
ADD CONSTRAINT submode_pkey PRIMARY KEY (submode_id);

-- weblink ---------------------------------------------------------------------
CREATE TABLE adif_view.weblink AS
    SELECT
        weblink.weblink_id,
        weblink.display_text AS orginization,
        weblink.url AS weblink_url
    FROM adif.weblink
    ORDER BY weblink.display_text;

ALTER TABLE adif_view.weblink
ADD CONSTRAINT weblink_pkey PRIMARY KEY (weblink_id);

-- Schema Information View (this is designed to be a table)
CREATE OR REPLACE VIEW view_schema_info AS
    SELECT
        schema_info.schema_name AS "Schema Name",
        schema_info.schema_version AS "Schema Version",
        schema_info.adif_spec AS "ADIF Spec",
        date_trunc('second', schema_info.last_update::TIMESTAMP) AS "Create Date"
    FROM schema_info
    ORDER BY  schema_info.schema_name;

-- pas_summary -----------------------------------------------------------------
CREATE TABLE adif_view.pas_summary AS
    SELECT
        pas_summary.pas_summary_id,
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas_type.pas_type AS pri_subdivision,
        pas_summary.has_oblast AS has_oblast,
        pas_summary.has_sas AS has_secondary,
        sas_type.sas_type AS sec_subdivision
    FROM adif.pas_summary
        LEFT JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas_summary.dxcc_code
        LEFT JOIN adif.pas_type ON
            adif.pas_summary.pas_type_id = adif.pas_type.pas_type_id
        LEFT JOIN adif.sas_type ON
            adif.pas_summary.sas_type_id = adif.sas_type.sas_type_id
    ORDER BY adif.pas_summary.pas_summary_id;

ALTER TABLE adif_view.pas_summary
ADD CONSTRAINT pas_summary_pkey PRIMARY KEY (pas_summary_id);

-- pas_type
CREATE TABLE adif_view.pas_type AS
    SELECT
        pas_type.pas_type_id,
        pas_type AS pri_subdivision_type
    FROM adif.pas_type
    ORDER BY pas_type;

ALTER TABLE adif_view.pas_type
ADD CONSTRAINT pas_type_pkey PRIMARY KEY (pas_type_id);

-- sas_type 
CREATE TABLE adif_view.sas_type AS
    SELECT
        sas_type.sas_type_id,
        sas_type AS sec_subdivision
    FROM adif.sas_type
    ORDER BY sas_type;

ALTER TABLE adif_view.sas_type
ADD CONSTRAINT sas_type_pkey PRIMARY KEY (sas_type_id);

-- PAS 1 Canada ----------------------------------------------------------------

CREATE TABLE adif_view.pas1 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision AS subdivision,
		STRING_AGG(DISTINCT pas_cqzone.cqzone_id::text,', ') AS cq_zone,
		STRING_AGG(DISTINCT pas_ituzone.ituzone_id::text,', ') AS itu_zone
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
		JOIN adif.pas_cqzone ON
		    adif.pas_cqzone.pas_id = pas.pas_id
		JOIN adif.pas_ituzone ON
		    adif.pas_ituzone.pas_id = pas.pas_id
    WHERE dxcc.dxcc_id = '1'
	GROUP BY dxcc.dxcc_id, pas.pas_code, pas.subdivision
	ORDER BY adif.pas.pas_code;

ALTER TABLE adif_view.pas1 ADD COLUMN pas1_id SERIAL PRIMARY KEY;

-- PAS 5 Aland Is. -------------------------------------------------------------

CREATE TABLE adif_view.pas5 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision,
        pas.is_deleted AS is_deleted
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '5'
	ORDER BY adif.pas.pas_code;

ALTER TABLE adif_view.pas5 ADD COLUMN pas5_id SERIAL PRIMARY KEY;

-- PAS 6 Alaska ----------------------------------------------------------------

CREATE TABLE adif_view.pas6 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '6'
	ORDER BY adif.pas.pas_code;

ALTER TABLE adif_view.pas6 ADD COLUMN pas6_id SERIAL PRIMARY KEY;

-- 15 Asiatic Russia -----------------------------------------------------------

-- PAS-15 View Full Table
-- PAS-15 Partial List where Before Date IS NOT NULL
-- PAS-15 Current List where Before Date IS NULL
-- PAD-15 Stats

-- PAS-15 View Full Table
CREATE TABLE adif_view.pas15 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision,
		STRING_AGG(DISTINCT pas_cqzone.cqzone_id::text,', ') AS cqzone,
		STRING_AGG(DISTINCT pas_ituzone.ituzone_id::text,', ') AS ituzone,
        pas.oblast AS oblast,
        pas.before_date AS before_date,
        pas.referred_to_as AS referred_to_as
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
		JOIN adif.pas_cqzone ON
		    adif.pas_cqzone.pas_id = pas.pas_id
		JOIN adif.pas_ituzone ON
		    adif.pas_ituzone.pas_id = pas.pas_id
	WHERE dxcc.dxcc_id = '15'
	GROUP BY dxcc.dxcc_id, pas.pas_code, pas.subdivision, pas.oblast, pas.before_date, pas.referred_to_as
	ORDER BY adif.pas.pas_code;

ALTER TABLE adif_view.pas15 ADD COLUMN pas15_id SERIAL PRIMARY KEY;

-- Before (test table)
CREATE TABLE adif_view.pas15_before AS
    SELECT * FROM adif_view.pas15 WHERE before_date IS NOT NULL;

ALTER TABLE adif_view.pas15_before ADD COLUMN pas15_before_id SERIAL PRIMARY KEY;

-- Current (test table)
CREATE TABLE adif_view.pas15_current AS
    SELECT * FROM adif_view.pas15 WHERE before_date IS NULL;

ALTER TABLE adif_view.pas15_current ADD COLUMN pas15_current_id SERIAL PRIMARY KEY;

-- PAD-15 Stats
CREATE TABLE adif_view.pas15_stats AS
    SELECT  (
            SELECT COUNT(*)
                FROM adif_view.pas15
            ) AS "Total Count",
            (
            SELECT COUNT(*)
                FROM adif_view.pas15 WHERE before_date IS NOT NULL
            ) AS "Before Count",
            (
            SELECT COUNT(*)
                FROM adif_view.pas15 WHERE before_date IS NULL
            ) AS "Current Count";

ALTER TABLE adif_view.pas15_stats ADD COLUMN pas15_stats_id SERIAL PRIMARY KEY;

-- 21 Beleric Is. --------------------------------------------------------------

CREATE TABLE adif_view.pas21 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '21'
	ORDER BY adif.pas.pas_code;

ALTER TABLE adif_view.pas21 ADD COLUMN pas21_id SERIAL PRIMARY KEY;

-- 27 Belarus ------------------------------------------------------------------
CREATE TABLE adif_view.pas27 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '27'
	ORDER BY adif.pas.pas_code;

ALTER TABLE adif_view.pas27 ADD COLUMN pas27_id SERIAL PRIMARY KEY;

-- 29 Canary Is. ---------------------------------------------------------------

CREATE TABLE adif_view.pas29 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '29'
	ORDER BY adif.pas.pas_code;

ALTER TABLE adif_view.pas29 ADD COLUMN pas29_id SERIAL PRIMARY KEY;

-- 32 Cetua & Melilla ----------------------------------------------------------

CREATE TABLE adif_view.pas32 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '32'
	ORDER BY adif.pas.pas_code;

ALTER TABLE adif_view.pas32 ADD COLUMN pas32_id SERIAL PRIMARY KEY;

-- 50 Mexico -------------------------------------------------------------------

CREATE TABLE adif_view.pas50 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '50'
	ORDER BY adif.pas.pas_code;

ALTER TABLE adif_view.pas50 ADD COLUMN pas50_id SERIAL PRIMARY KEY;

-- 52 Estonia ------------------------------------------------------------------

CREATE TABLE adif_view.pas52 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '52'
	ORDER BY adif.pas.pas_code;

ALTER TABLE adif_view.pas52 ADD COLUMN pas52_id SERIAL PRIMARY KEY;

-- 54 European Russia ----------------------------------------------------------

-- NOTE: There are no multiple itu or cq zones for EU Russia. Therefore, no
--       need for it's own cqzone or ituzone tables nor aggregate's
CREATE TABLE adif_view.pas54 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision,
        pas.oblast,
		pas_cqzone.cqzone_id AS cqzone,
        pas_ituzone.ituzone_id AS ituzone
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
		JOIN adif.pas_cqzone ON
		    adif.pas_cqzone.pas_id = pas.pas_id
		JOIN adif.pas_ituzone ON
		    adif.pas_ituzone.pas_id = pas.pas_id
	WHERE dxcc.dxcc_id = '54'
	ORDER BY adif.pas.pas_code;

ALTER TABLE adif_view.pas54 ADD COLUMN pas54_id SERIAL PRIMARY KEY;

-- 61 Franz Josef Land ---------------------------------------------------------

CREATE TABLE adif_view.pas61 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision,
        pas.is_import_only
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '61'
	ORDER BY adif.pas.pas_code;

ALTER TABLE adif_view.pas61 ADD COLUMN pas61_id SERIAL PRIMARY KEY;

-- 70 Cuba ---------------------------------------------------------------------

CREATE TABLE adif_view.pas70 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '70'
	ORDER BY adif.pas.pas_code;

ALTER TABLE adif_view.pas70 ADD COLUMN pas70_id SERIAL PRIMARY KEY;

-- 74 El Salvador --------------------------------------------------------------

CREATE TABLE adif_view.pas74 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '74'
	ORDER BY adif.pas.pas_code;

ALTER TABLE adif_view.pas74 ADD COLUMN pas74_id SERIAL PRIMARY KEY;

-- 86 Nicaragua ----------------------------------------------------------------
CREATE TABLE adif_view.pas86 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '86'
	ORDER BY adif.pas.pas_code;

ALTER TABLE adif_view.pas86 ADD COLUMN pas86_id SERIAL PRIMARY KEY;

-- 100 Argentina ---------------------------------------------------------------

CREATE TABLE adif_view.pas100 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '100'
	ORDER BY adif.pas.pas_code;

ALTER TABLE adif_view.pas100 ADD COLUMN pas100_id SERIAL PRIMARY KEY;

-- 104 Bolivia -----------------------------------------------------------------

CREATE TABLE adif_view.pas104 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '104'
	ORDER BY adif.pas.pas_code;

ALTER TABLE adif_view.pas104 ADD COLUMN pas104_id SERIAL PRIMARY KEY;

-- 108 Brazil ------------------------------------------------------------------

CREATE TABLE adif_view.pas108 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '108'
	ORDER BY adif.pas.pas_code;

ALTER TABLE adif_view.pas108 ADD COLUMN pas108_id SERIAL PRIMARY KEY;

-- 110 Hawaii ------------------------------------------------------------------

CREATE TABLE adif_view.pas110 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '110'
	ORDER BY adif.pas.pas_code;

ALTER TABLE adif_view.pas110 ADD COLUMN pas110_id SERIAL PRIMARY KEY;

-- 112 Hawaii ------------------------------------------------------------------

CREATE TABLE adif_view.pas112 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '112'
	ORDER BY adif.pas.pas_code;

ALTER TABLE adif_view.pas112 ADD COLUMN pas112_id SERIAL PRIMARY KEY;

-- 126 Kalingrad ---------------------------------------------------------------

-- NOTE: There are no multiple itu or cq zones for Kalingrad. Therefore, no
--       need for it's own cqzone or ituzone tables nor aggregate's
CREATE TABLE adif_view.pas126 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision,
        pas.oblast AS oblast,
		pas_cqzone.cqzone_id AS cqzone,
        pas_ituzone.ituzone_id AS ituzone
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
		JOIN adif.pas_cqzone ON
		    adif.pas_cqzone.pas_id = pas.pas_id
		JOIN adif.pas_ituzone ON
		    adif.pas_ituzone.pas_id = pas.pas_id
	WHERE dxcc.dxcc_id = '126'
	ORDER BY adif.pas.pas_code;

ALTER TABLE adif_view.pas126 ADD COLUMN pas126_id SERIAL PRIMARY KEY;

-- 130 Kazakhstan --------------------------------------------------------------

CREATE TABLE adif_view.pas130 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision,
        pas.oblast as oblast
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '130'
	ORDER BY adif.pas.pas_code;

ALTER TABLE adif_view.pas130 ADD COLUMN pas130_id SERIAL PRIMARY KEY;

-- 132 Paraguay ----------------------------------------------------------------

CREATE TABLE adif_view.pas132 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '132'
	ORDER BY adif.pas.pas_code;

ALTER TABLE adif_view.pas132 ADD COLUMN pas132_id SERIAL PRIMARY KEY;

-- 137 Republic of Korea -------------------------------------------------------

CREATE TABLE adif_view.pas137 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '137'
	ORDER BY adif.pas.pas_code;

ALTER TABLE adif_view.pas137 ADD COLUMN pas137_id SERIAL PRIMARY KEY;

-- 138 Kure Island -------------------------------------------------------------

CREATE TABLE adif_view.pas138 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '138'
	ORDER BY adif.pas.pas_code;

ALTER TABLE adif_view.pas138 ADD COLUMN pas138_id SERIAL PRIMARY KEY;

-- 144 Uruguay -----------------------------------------------------------------

CREATE TABLE adif_view.pas144 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '144'
	ORDER BY adif.pas.pas_code;

ALTER TABLE adif_view.pas144 ADD COLUMN pas144_id SERIAL PRIMARY KEY;

-- 147 Lord Howe Is. -----------------------------------------------------------

CREATE TABLE adif_view.pas147 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '147'
	ORDER BY adif.pas.pas_code;

ALTER TABLE adif_view.pas147 ADD COLUMN pas147_id SERIAL PRIMARY KEY;

-- 148 Venezuela ---------------------------------------------------------------

CREATE TABLE adif_view.pas148 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '148'
	ORDER BY adif.pas.pas_code;

ALTER TABLE adif_view.pas148 ADD COLUMN pas148_id SERIAL PRIMARY KEY;

-- 149 Azores ------------------------------------------------------------------

CREATE TABLE adif_view.pas149 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '149'
	ORDER BY adif.pas.pas_code;

ALTER TABLE adif_view.pas149 ADD COLUMN pas149_id SERIAL PRIMARY KEY;

-- 150 Australia ---------------------------------------------------------------

CREATE TABLE adif_view.pas150 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '150'
	ORDER BY adif.pas.pas_code;

ALTER TABLE adif_view.pas150 ADD COLUMN pas150_id SERIAL PRIMARY KEY;

-- 151 Malyj Vysotski Is -------------------------------------------------------

CREATE TABLE adif_view.pas151 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision,
        pas.is_import_only
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '151'
	ORDER BY adif.pas.pas_code;

ALTER TABLE adif_view.pas151 ADD COLUMN pas151_id SERIAL PRIMARY KEY;

-- 153 Macquarie Is. -----------------------------------------------------------

CREATE TABLE adif_view.pas153 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '153'
	ORDER BY adif.pas.pas_code;

ALTER TABLE adif_view.pas153 ADD COLUMN pas153_id SERIAL PRIMARY KEY;

-- 163 Papua New Guinea --------------------------------------------------------

CREATE TABLE adif_view.pas163 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '163'
	ORDER BY adif.pas.pas_code;

ALTER TABLE adif_view.pas163 ADD COLUMN pas163_id SERIAL PRIMARY KEY;

-- 170 New Zealand -------------------------------------------------------------

CREATE TABLE adif_view.pas170 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '170'
	ORDER BY adif.pas.pas_code;

ALTER TABLE adif_view.pas170 ADD COLUMN pas170_id SERIAL PRIMARY KEY;

-- 177 Minami Torishima --------------------------------------------------------

CREATE TABLE adif_view.pas177 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '177'
	ORDER BY adif.pas.pas_code;

ALTER TABLE adif_view.pas177 ADD COLUMN pas177_id SERIAL PRIMARY KEY;

-- 179 Moldova -----------------------------------------------------------------

CREATE TABLE adif_view.pas179 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '179'
	ORDER BY adif.pas.pas_code;

ALTER TABLE adif_view.pas179 ADD COLUMN pas179_id SERIAL PRIMARY KEY;

-- 192 Ogasawara ---------------------------------------------------------------

CREATE TABLE adif_view.pas192 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '192'
	ORDER BY adif.pas.pas_code;

ALTER TABLE adif_view.pas192 ADD COLUMN pas192_id SERIAL PRIMARY KEY;

-- 206 Austria -----------------------------------------------------------------

-- Regions and Subdivisions
CREATE TABLE adif_view.pas206 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas_region.region,
        pas.pas_code AS code,
        pas.subdivision,
        pas.before_date,
        pas.after_date
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
        JOIN adif.pas_region ON
            adif.pas.pas_region_id = pas_region.pas_region_id
        WHERE dxcc.dxcc_id = '206'
	ORDER BY adif.pas_region.region, pas.pas_code;

ALTER TABLE adif_view.pas206 ADD COLUMN pas206_id SERIAL PRIMARY KEY;

-- PAS 206 Regions Only
CREATE TABLE adif_view.pas206_region AS
    SELECT DISTINCT region FROM adif_view.pas206;

ALTER TABLE adif_view.pas206_region ADD COLUMN pas206_region_id SERIAL PRIMARY KEY;

-- PAS206 Stats
CREATE TABLE adif_view.pas206_stats AS
    SELECT
        region,
        COUNT (subdivision) AS subdivision_count
    FROM
        adif_view.pas206
    GROUP BY
        region
    ORDER BY
        region;

ALTER TABLE adif_view.pas206_stats ADD COLUMN pas206_stats_id SERIAL PRIMARY KEY;

-- 209 Belgium -----------------------------------------------------------------

CREATE TABLE adif_view.pas209 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '209'
	ORDER BY adif.pas.pas_code;

ALTER TABLE adif_view.pas209 ADD COLUMN pas209_id SERIAL PRIMARY KEY;

-- 212 Bulgaria ----------------------------------------------------------------

-- Regions and Subdivisions
CREATE TABLE adif_view.pas212 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas_region.region,
        pas.pas_code AS code,
        pas.subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
        JOIN adif.pas_region ON
            adif.pas.pas_region_id = pas_region.pas_region_id
        WHERE dxcc.dxcc_id = '212'
	ORDER BY adif.pas_region.region, pas.pas_code;

ALTER TABLE adif_view.pas212 ADD COLUMN pas212_id SERIAL PRIMARY KEY;

-- PAS 206 Regions Only
CREATE TABLE adif_view.pas212_region AS
    SELECT DISTINCT region FROM adif_view.pas212;

ALTER TABLE adif_view.pas212_region ADD COLUMN pas212_region_id SERIAL PRIMARY KEY;

-- PAS-212 Stats
CREATE TABLE adif_view.pas212_stats AS
    SELECT
        region,
        COUNT (subdivision) AS subdivision_count
    FROM
        adif_view.pas212
    GROUP BY
        region
    ORDER BY
        region;

ALTER TABLE adif_view.pas212_stats ADD COLUMN pas212_stats_id SERIAL PRIMARY KEY;

-- 214 Corsica -----------------------------------------------------------------

CREATE TABLE adif_view.pas214 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '214'
	ORDER BY adif.pas.pas_code;

ALTER TABLE adif_view.pas214 ADD COLUMN pas214_id SERIAL PRIMARY KEY;

-- 221 Denmark -----------------------------------------------------------------

CREATE TABLE adif_view.pas221 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '221'
	ORDER BY adif.pas.pas_code;

ALTER TABLE adif_view.pas221 ADD COLUMN pas221_id SERIAL PRIMARY KEY;

-- 224 Finland -----------------------------------------------------------------

-- Regions and Subdivisions
CREATE TABLE adif_view.pas224 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas_region.region as region,
        pas.pas_code AS code,
        pas.subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
        JOIN adif.pas_region ON
            adif.pas.pas_region_id = pas_region.pas_region_id
        WHERE dxcc.dxcc_id = '224'
	ORDER BY adif.pas_region.region, pas.pas_code;

ALTER TABLE adif_view.pas224 ADD COLUMN pas224_id SERIAL PRIMARY KEY;

-- PAS 224 Regions Only
CREATE TABLE adif_view.pas224_region AS
    SELECT DISTINCT region FROM adif_view.pas224;

ALTER TABLE adif_view.pas224_region ADD COLUMN pas224_region_id SERIAL PRIMARY KEY;

-- PAS 224 Stats
CREATE TABLE adif_view.pas224_stats AS
    SELECT
        region,
        COUNT (subdivision) AS subdivision_count
    FROM
        adif_view.pas224
    GROUP BY
        region
    ORDER BY
        region;

ALTER TABLE adif_view.pas224_stats ADD COLUMN pas224_stats_id SERIAL PRIMARY KEY;

-- 225 Sardinia ----------------------------------------------------------------

-- Regions and Subdivisions
CREATE TABLE adif_view.pas225 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas_region.region,
        pas.pas_code,
        pas.subdivision,
        pas.is_import_only
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
        JOIN adif.pas_region ON
            adif.pas.pas_region_id = pas_region.pas_region_id
        WHERE dxcc.dxcc_id = '225'
	ORDER BY adif.pas_region.region, pas.pas_code;

ALTER TABLE adif_view.pas225 ADD COLUMN pas225_id SERIAL PRIMARY KEY;

-- PAS 225 Regions Only
CREATE TABLE adif_view.pas225_region AS
    SELECT DISTINCT region FROM adif_view.pas225;

ALTER TABLE adif_view.pas225_region ADD COLUMN pas225_region_id SERIAL PRIMARY KEY;

-- PAS 225 Stats
CREATE TABLE adif_view.pas225_stats AS
    SELECT
        region,
        COUNT (subdivision) AS subdivision_count
    FROM
        adif_view.pas225
    GROUP BY
        region
    ORDER BY
        region;

ALTER TABLE adif_view.pas225_stats ADD COLUMN pas225_stats_id SERIAL PRIMARY KEY;

-- 227 France ------------------------------------------------------------------

CREATE TABLE adif_view.pas227 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '227'
	ORDER BY adif.pas.pas_code;

ALTER TABLE adif_view.pas227 ADD COLUMN pas227_id SERIAL PRIMARY KEY;

-- 230 Fed. Rep. of Germany ----------------------------------------------------

CREATE TABLE adif_view.pas230 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision AS subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '230'
	ORDER BY adif.pas.pas_code;

ALTER TABLE adif_view.pas230 ADD COLUMN pas230_id SERIAL PRIMARY KEY;

-- 239 Hungary -----------------------------------------------------------------

CREATE TABLE adif_view.pas239 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '239'
	ORDER BY adif.pas.pas_code;

ALTER TABLE adif_view.pas239 ADD COLUMN pas239_id SERIAL PRIMARY KEY;

-- 245 Ireland -----------------------------------------------------------------

CREATE TABLE adif_view.pas245 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision AS subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '245'
	ORDER BY adif.pas.pas_code;

ALTER TABLE adif_view.pas245 ADD COLUMN pas245_id SERIAL PRIMARY KEY;

-- 248 Italy -------------------------------------------------------------------

-- Regions and Subdivisions
CREATE TABLE adif_view.pas248 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas_region.region,
        pas.pas_code AS code,
        pas.subdivision,
        pas.is_import_only
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
        JOIN adif.pas_region ON
            adif.pas.pas_region_id = pas_region.pas_region_id
        WHERE dxcc.dxcc_id = '248'
	ORDER BY adif.pas_region.region, pas.pas_code;

ALTER TABLE adif_view.pas248 ADD COLUMN pas248_id SERIAL PRIMARY KEY;

-- PAS 248 Regions Only
CREATE TABLE adif_view.pas248_region AS
    SELECT DISTINCT region FROM adif_view.pas248;

ALTER TABLE adif_view.pas248_region ADD COLUMN pas248_region_id SERIAL PRIMARY KEY;

-- PAS 248 Stats
CREATE TABLE adif_view.pas248_stats AS
    SELECT
        region,
        COUNT (subdivision) AS subdivision_count
    FROM
        adif_view.pas248
    GROUP BY
        region
    ORDER BY
        region;

ALTER TABLE adif_view.pas248_stats ADD COLUMN pas248_stats_id SERIAL PRIMARY KEY;

-- 256 Maderia Is. -------------------------------------------------------------

CREATE TABLE adif_view.pas256 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '256'
	ORDER BY adif.pas.pas_code;

ALTER TABLE adif_view.pas256 ADD COLUMN pas256_id SERIAL PRIMARY KEY;

-- 263 Netherlands -------------------------------------------------------------

CREATE TABLE adif_view.pas263 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '263'
	ORDER BY adif.pas.pas_code;

ALTER TABLE adif_view.pas263 ADD COLUMN pas263_id SERIAL PRIMARY KEY;

-- 269 Poland ------------------------------------------------------------------

CREATE TABLE adif_view.pas269 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '269'
	ORDER BY adif.pas.pas_code;

ALTER TABLE adif_view.pas269 ADD COLUMN pas269_id SERIAL PRIMARY KEY;

-- 272 Portugal ----------------------------------------------------------------

CREATE TABLE adif_view.pas272 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '272'
	ORDER BY adif.pas.pas_code;

ALTER TABLE adif_view.pas272 ADD COLUMN pas272_id SERIAL PRIMARY KEY;

-- 275 Romania -----------------------------------------------------------------

CREATE TABLE adif_view.pas275 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '275'
	ORDER BY adif.pas.pas_code;

ALTER TABLE adif_view.pas275 ADD COLUMN pas275_id SERIAL PRIMARY KEY;

-- 281 Spain -------------------------------------------------------------------

CREATE TABLE adif_view.pas281 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '281'
	ORDER BY adif.pas.pas_code;

ALTER TABLE adif_view.pas281 ADD COLUMN pas281_id SERIAL PRIMARY KEY;

-- 284 Sweden ------------------------------------------------------------------

CREATE TABLE adif_view.pas284 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '284'
	ORDER BY adif.pas.pas_code;

ALTER TABLE adif_view.pas284 ADD COLUMN pas284_id SERIAL PRIMARY KEY;

-- 287 Switzerland -------------------------------------------------------------

CREATE TABLE adif_view.pas287 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '287'
	ORDER BY adif.pas.pas_code;

ALTER TABLE adif_view.pas287 ADD COLUMN pas287_id SERIAL PRIMARY KEY;

-- 288 Ukraine -----------------------------------------------------------------

CREATE TABLE adif_view.pas288 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision AS subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '288'
	ORDER BY adif.pas.pas_code;

ALTER TABLE adif_view.pas288 ADD COLUMN pas288_id SERIAL PRIMARY KEY;

-- 291 United States -----------------------------------------------------------

CREATE TABLE adif_view.pas291 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision,
		STRING_AGG(DISTINCT pas_cqzone.cqzone_id::text,', ') AS cq_zone,
		STRING_AGG(DISTINCT pas_ituzone.ituzone_id::text,', ') AS itu_zone
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
		JOIN adif.pas_cqzone ON
		    adif.pas_cqzone.pas_id = pas.pas_id
		JOIN adif.pas_ituzone ON
		    adif.pas_ituzone.pas_id = pas.pas_id
    WHERE dxcc.dxcc_id = '291'
	GROUP BY dxcc.dxcc_id, pas.pas_code, pas.subdivision
	ORDER BY adif.pas.pas_code;

ALTER TABLE adif_view.pas291 ADD COLUMN pas291_id SERIAL PRIMARY KEY;

-- 318 China -------------------------------------------------------------------

CREATE TABLE adif_view.pas318 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '318'
	ORDER BY adif.pas.pas_code;

ALTER TABLE adif_view.pas318 ADD COLUMN pas318_id SERIAL PRIMARY KEY;

-- 327 Indonesia ---------------------------------------------------------------

CREATE TABLE adif_view.pas327 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '327'
	ORDER BY adif.pas.pas_code;

ALTER TABLE adif_view.pas327 ADD COLUMN pas327_id SERIAL PRIMARY KEY;

-- 339 Japan -------------------------------------------------------------------

-- Regions and Subdivisions
CREATE TABLE adif_view.pas339 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas_region.region,
        pas.pas_code AS code,
        pas.subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
        JOIN adif.pas_region ON
            adif.pas.pas_region_id = pas_region.pas_region_id
        WHERE dxcc.dxcc_id = '339'
	ORDER BY adif.pas_region.region, pas.pas_code;

ALTER TABLE adif_view.pas339 ADD COLUMN pas339_id SERIAL PRIMARY KEY;

-- PAS 225 Regions Only
CREATE TABLE adif_view.pas339_region AS
    SELECT DISTINCT region FROM adif_view.pas339;

ALTER TABLE adif_view.pas339_region ADD COLUMN pas339_region_id SERIAL PRIMARY KEY;

-- PAS 339 Stats
CREATE TABLE adif_view.pas339_stats AS
    SELECT
        region,
        COUNT (subdivision) AS subdivision_count
    FROM
        adif_view.pas339
    GROUP BY
        region
    ORDER BY
        region;

ALTER TABLE adif_view.pas339_stats ADD COLUMN pas339_stats_id SERIAL PRIMARY KEY;

-- 375 Philippines -------------------------------------------------------------

-- Regions and Subdivisions
CREATE TABLE adif_view.pas375 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas_region.region as region,
        pas.pas_code AS code,
        pas.subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
        JOIN adif.pas_region ON
            adif.pas.pas_region_id = pas_region.pas_region_id
        WHERE dxcc.dxcc_id = '375'
	ORDER BY adif.pas_region.region, pas.pas_code;

ALTER TABLE adif_view.pas375 ADD COLUMN pas375_id SERIAL PRIMARY KEY;

-- PAS 225 Regions Only
CREATE TABLE adif_view.pas375_region AS
    SELECT DISTINCT region FROM adif_view.pas375;

ALTER TABLE adif_view.pas375_region ADD COLUMN pas375_region_id SERIAL PRIMARY KEY;

-- PAS 225 Stats
CREATE TABLE adif_view.pas375_stats AS
    SELECT
        region,
        COUNT (subdivision) AS subdivision_count
    FROM
        adif_view.pas375
    GROUP BY
        region
    ORDER BY
        region;

ALTER TABLE adif_view.pas375_stats ADD COLUMN pas375_stats_id SERIAL PRIMARY KEY;

-- 386 Taiwan ------------------------------------------------------------------

CREATE TABLE adif_view.pas386 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '386'
	ORDER BY adif.pas.pas_code;

ALTER TABLE adif_view.pas386 ADD COLUMN pas386_id SERIAL PRIMARY KEY;

-- 387 Thailand ----------------------------------------------------------------

CREATE TABLE adif_view.pas387 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '387'
	ORDER BY adif.pas.pas_code;

ALTER TABLE adif_view.pas387 ADD COLUMN pas387_id SERIAL PRIMARY KEY;

-- 497 Croatia -----------------------------------------------------------------

CREATE TABLE adif_view.pas497 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '497'
	ORDER BY adif.pas.pas_code;

ALTER TABLE adif_view.pas497 ADD COLUMN pas497_id SERIAL PRIMARY KEY;

-- 503 Czech Republic ----------------------------------------------------------

-- Regions and Subdivisions
CREATE TABLE adif_view.pas503 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas_region.region,
        pas.pas_code AS code,
        pas.subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
        JOIN adif.pas_region ON
            adif.pas.pas_region_id = pas_region.pas_region_id
        WHERE dxcc.dxcc_id = '503'
	ORDER BY adif.pas_region.region, pas.pas_code;

ALTER TABLE adif_view.pas503 ADD COLUMN pas503_id SERIAL PRIMARY KEY;

-- PAS 225 Regions Only
CREATE TABLE adif_view.pas503_region AS
    SELECT DISTINCT region FROM adif_view.pas503;

ALTER TABLE adif_view.pas503_region ADD COLUMN pas503_region_id SERIAL PRIMARY KEY;

-- PAS 503 Stats
CREATE TABLE adif_view.pas503_stats AS
    SELECT
        region,
        COUNT (subdivision) AS subdivision_count
    FROM
        adif_view.pas503
    GROUP BY
        region
    ORDER BY
        region;

ALTER TABLE adif_view.pas503_stats ADD COLUMN pas503_stats_id SERIAL PRIMARY KEY;

-- 504 Slovak Republic ---------------------------------------------------------

-- Regions and Subdivisions
CREATE TABLE adif_view.pas504 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas_region.region,
        pas.pas_code AS code,
        pas.subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
        JOIN adif.pas_region ON
            adif.pas.pas_region_id = pas_region.pas_region_id
        WHERE dxcc.dxcc_id = '504'
	ORDER BY adif.pas_region.region, pas.pas_code;

ALTER TABLE adif_view.pas504 ADD COLUMN pas504_id SERIAL PRIMARY KEY;

-- PAS 225 Regions Only
CREATE TABLE adif_view.pas504_region AS
    SELECT DISTINCT region FROM adif_view.pas503;

ALTER TABLE adif_view.pas504_region ADD COLUMN pas504_region_id SERIAL PRIMARY KEY;

-- PAS 503 Stats
CREATE TABLE adif_view.pas504_stats AS
    SELECT
        region,
        COUNT (subdivision) AS subdivision_count
    FROM
        adif_view.pas504
    GROUP BY
        region
    ORDER BY
        region;

ALTER TABLE adif_view.pas504_stats ADD COLUMN pas504_stats_id SERIAL PRIMARY KEY;

-- JCC Prefectures and Cities --------------------------------------------------
CREATE TABLE adif_view.jcc AS
    SELECT
        jcc.prefecture,
        jcc_city.number,
        jcc_city.city,
        jcc_city.is_deleted,
        jcc_city.deleted_date
    FROM adif.jcc
        JOIN adif.jcc_city ON
            adif.jcc_city.jcc_id = jcc.jcc_id
	ORDER BY jcc_city.number;

ALTER TABLE adif_view.jcc ADD COLUMN jcc_id SERIAL PRIMARY KEY;

-- JCC City County by Prefectture Stats
CREATE TABLE adif_view.jcc_prefecture_stats AS
    SELECT 
        adif.jcc.prefecture,
        count(*) AS city_count
    FROM adif.jcc
        JOIN adif.jcc_city ON
            adif.jcc_city.jcc_id = jcc.jcc_id
    GROUP BY jcc.prefecture
    ORDER BY jcc.prefecture;

ALTER TABLE adif_view.jcc_prefecture_stats ADD COLUMN jcc_prefecture_stats_id SERIAL PRIMARY KEY;

-- City Stats
-- Should Return: Prefectures = 47, Total Cout = 913, Current = 815, Deleted = 98
CREATE TABLE adif_view.jcc_full_stats AS
    SELECT  
            (
            SELECT COUNT(*)
                FROM adif.jcc
            ) AS prefecture_count,    
            (
            SELECT COUNT(*)
                FROM adif.jcc_city
            ) AS total_cities,
            (
            SELECT COUNT(*)
                FROM adif.jcc_city WHERE is_deleted = FALSE
            ) AS current_cities,
            (
            SELECT COUNT(*)
                FROM adif.jcc_city WHERE is_deleted = TRUE
            ) AS deleted_cities;

ALTER TABLE adif_view.jcc_full_stats ADD COLUMN jcc_full_stats_id SERIAL PRIMARY KEY;


-- RDXC Full RDA List ----------------------------------------------------------
CREATE TABLE adif_view.rdxc_district_list AS
    SELECT
        rdxc.rdxc_code,
        rdxc.oblast,
        rdxc.prefix,
        rdxc.is_deleted as oblast_is_deleted,
        code,
        district,
        valid_since,
        rdxc_district.is_deleted as district_is_deleted,
        is_new_rda,
        has_replacement,
        migration_district
    FROM adif.rdxc_district
        JOIN adif.rdxc ON 
            rdxc.rdxc_id = rdxc_district.rdxc_district_id;

ALTER TABLE adif_view.rdxc_district_list ADD COLUMN rdxc_district_list_id SERIAL PRIMARY KEY;

-- RDXC Oblast Stats
-- RDXC Oblasts Numbers do not match the 3.0.9 Spec
-- RDXC Number from the source dont match what's published by v3.0.9 Spec Either
-- ADIF Spec states: Current = 2644, Deleted = +180
CREATE TABLE adif_view.rdxc_oblast_count AS
SELECT 
    rdxc.rdxc_code,
    rdxc.prefix, 
    rdxc.oblast, 
    count(*) AS total_count
FROM adif.rdxc
    JOIN adif.rdxc_district ON 
        rdxc_district.rdxc_id = rdxc.rdxc_id
GROUP BY rdxc.oblast, rdxc.rdxc_code, rdxc.prefix 
ORDER BY rdxc.rdxc_code;

ALTER TABLE adif_view.rdxc_oblast_count ADD COLUMN rdxc_oblast_count_id SERIAL PRIMARY KEY;

-- Summary Count
CREATE TABLE adif_view.rdxc_oblast_stats AS
    SELECT  
        (
        SELECT COUNT(*)
            FROM adif.rdxc
        ) AS oblast_count,    
        (
        SELECT COUNT(*)
            FROM adif.rdxc_district
        ) AS total_districts,
        (
        SELECT COUNT(*)
            FROM adif.rdxc_district WHERE is_deleted = FALSE
        ) AS current_districts,
        (
        SELECT COUNT(*)
            FROM adif.rdxc_district WHERE is_new_rda = TRUE
        ) AS new_districts,	
        (
        SELECT COUNT(*)
            FROM adif.rdxc_district WHERE is_deleted = TRUE
        ) AS deleted_districts;

ALTER TABLE adif_view.rdxc_oblast_stats ADD COLUMN rdxc_oblast_stats_id SERIAL PRIMARY KEY;

-- SAS 6 Alaska ----------------------------------------------------------------
CREATE TABLE adif_view.sas6 AS
    SELECT
        sas.dxcc_id AS dxcc_code,
        dxcc.name as dxcc_name,
        sas.prefix,
        sas.name,
        sas.code,
        sas.description as description
    FROM adif.sas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = sas.dxcc_id
    WHERE dxcc.dxcc_id = '6'
    ORDER BY adif.sas.code;

ALTER TABLE adif_view.sas6 ADD COLUMN sas6_id SERIAL PRIMARY KEY;

-- SAS 15 ASIATIC RUSSIA -------------------------------------------------------

CREATE TABLE adif_view.sas15 AS
    SELECT
        sas.dxcc_id AS dxcc_code,
        dxcc.name as dxcc_name,
        sas.prefix,
        sas.name,
        sas.code,
        sas.description as description
    FROM adif.sas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = sas.dxcc_id
    WHERE dxcc.dxcc_id = '15'
    ORDER BY adif.sas.code;

ALTER TABLE adif_view.sas15 ADD COLUMN sas15_id SERIAL PRIMARY KEY;

-- SAS 54 EUROPEAN RUSSIA ------------------------------------------------------

CREATE TABLE adif_view.sas54 AS
    SELECT
        sas.dxcc_id AS dxcc_code,
        dxcc.name as dxcc_name,
        sas.prefix,
        sas.name,
        sas.code,
        sas.description as description
    FROM adif.sas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = sas.dxcc_id
    WHERE dxcc.dxcc_id = '54'
    ORDER BY adif.sas.code;

ALTER TABLE adif_view.sas54 ADD COLUMN sas54_id SERIAL PRIMARY KEY;

-- SAS 61 FRANZ JOSEF LAND -----------------------------------------------------

CREATE TABLE adif_view.sas61 AS
    SELECT
        sas.dxcc_id AS dxcc_code,
        dxcc.name as dxcc_name,
        sas.prefix,
        sas.name,
        sas.code,
        sas.description as description
    FROM adif.sas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = sas.dxcc_id
    WHERE dxcc.dxcc_id = '61'
    ORDER BY adif.sas.code;

ALTER TABLE adif_view.sas61 ADD COLUMN sas61_id SERIAL PRIMARY KEY;

-- SAS 110 HAWAII --------------------------------------------------------------

CREATE TABLE adif_view.sas110 AS
    SELECT
        sas.dxcc_id AS dxcc_code,
        dxcc.name as dxcc_name,
        sas.prefix,
        sas.name,
        sas.code,
        sas.description as description
    FROM adif.sas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = sas.dxcc_id
    WHERE dxcc.dxcc_id = '110'
    ORDER BY adif.sas.code;

ALTER TABLE adif_view.sas110 ADD COLUMN sas110_id SERIAL PRIMARY KEY;

-- SAS 126 KALININGRAD ---------------------------------------------------------

CREATE TABLE adif_view.sas126 AS
    SELECT
        sas.dxcc_id AS dxcc_code,
        dxcc.name as dxcc_name,
        sas.prefix,
        sas.name,
        sas.code,
        sas.description as description
    FROM adif.sas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = sas.dxcc_id
    WHERE dxcc.dxcc_id = '126'
    ORDER BY adif.sas.code;

ALTER TABLE adif_view.sas126 ADD COLUMN sas126_id SERIAL PRIMARY KEY;

-- SAS 137 REPUBLIC OF KOREA ---------------------------------------------------

CREATE TABLE adif_view.sas137 AS
    SELECT
        sas.dxcc_id AS dxcc_code,
        dxcc.name as dxcc_name,
        sas.prefix,
        sas.name,
        sas.code,
        sas.description as description
    FROM adif.sas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = sas.dxcc_id
    WHERE dxcc.dxcc_id = '137'
    ORDER BY adif.sas.code;

ALTER TABLE adif_view.sas137 ADD COLUMN sas137_id SERIAL PRIMARY KEY;

-- SAS 151 MALYJ VYSOTSKIJ I. --------------------------------------------------

CREATE TABLE adif_view.sas151 AS
    SELECT
        sas.dxcc_id AS dxcc_code,
        dxcc.name as dxcc_name,
        sas.prefix,
        sas.name,
        sas.code,
        sas.description as description
    FROM adif.sas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = sas.dxcc_id
    WHERE dxcc.dxcc_id = '151'
    ORDER BY adif.sas.code;

ALTER TABLE adif_view.sas151 ADD COLUMN sas151_id SERIAL PRIMARY KEY;

-- SAS 170 NEW ZEALAND ---------------------------------------------------------

CREATE TABLE adif_view.sas170 AS
    SELECT
        sas.dxcc_id AS dxcc_code,
        dxcc.name as dxcc_name,
        sas.prefix,
        sas.name,
        sas.code,
        sas.description as description
    FROM adif.sas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = sas.dxcc_id
    WHERE dxcc.dxcc_id = '170'
    ORDER BY adif.sas.code;

ALTER TABLE adif_view.sas170 ADD COLUMN sas170_id SERIAL PRIMARY KEY;

-- SAS 177 MINAMI TORISHIMA ----------------------------------------------------

CREATE TABLE adif_view.sas177 AS
    SELECT
        sas.dxcc_id AS dxcc_code,
        dxcc.name as dxcc_name,
        sas.prefix,
        sas.name,
        sas.code,
        sas.description as description
    FROM adif.sas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = sas.dxcc_id
    WHERE dxcc.dxcc_id = '177'
    ORDER BY adif.sas.code;

ALTER TABLE adif_view.sas177 ADD COLUMN sas177_id SERIAL PRIMARY KEY;

-- SAS 192 OGASAWARA -----------------------------------------------------------

CREATE TABLE adif_view.sas192 AS
    SELECT
        sas.dxcc_id AS dxcc_code,
        dxcc.name as dxcc_name,
        sas.prefix,
        sas.name,
        sas.code,
        sas.description as description
    FROM adif.sas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = sas.dxcc_id
    WHERE dxcc.dxcc_id = '192'
    ORDER BY adif.sas.code;

ALTER TABLE adif_view.sas192 ADD COLUMN sas192_id SERIAL PRIMARY KEY;

-- SAS 288 UKRAINE -------------------------------------------------------------

CREATE TABLE adif_view.sas288 AS
    SELECT
        sas.dxcc_id AS dxcc_code,
        dxcc.name as dxcc_name,
        sas.prefix,
        sas.name,
        sas.code,
        sas.description as description
    FROM adif.sas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = sas.dxcc_id
    WHERE dxcc.dxcc_id = '288'
    ORDER BY adif.sas.code;

ALTER TABLE adif_view.sas288 ADD COLUMN sas288_id SERIAL PRIMARY KEY;

-- SAS 291 UNITED STATES OF AMERICA --------------------------------------------

CREATE TABLE adif_view.sas291 AS
    SELECT
        sas.dxcc_id AS dxcc_code,
        dxcc.name as dxcc_name,
        sas.prefix,
        sas.name,
        sas.code,
        sas.description as description
    FROM adif.sas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = sas.dxcc_id
    WHERE dxcc.dxcc_id = '291'
    ORDER BY adif.sas.code;

ALTER TABLE adif_view.sas291 ADD COLUMN sas291_id SERIAL PRIMARY KEY;

-- SAS 339 JAPAN ---------------------------------------------------------------

CREATE TABLE adif_view.sas339 AS
    SELECT
        sas.dxcc_id AS dxcc_code,
        dxcc.name as dxcc_name,
        sas.prefix,
        sas.name,
        sas.code,
        sas.description as description
    FROM adif.sas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = sas.dxcc_id
    WHERE dxcc.dxcc_id = '339'
    ORDER BY adif.sas.code;

ALTER TABLE adif_view.sas339 ADD COLUMN sas339_id SERIAL PRIMARY KEY;

-- *****************************************************************************
-- ADD SCHEMA INFORMATION
-- *****************************************************************************

INSERT INTO schema_info(schema_name, schema_version, adif_spec, last_update)
VALUES('adif', :'ver', :'adifv', CURRENT_TIMESTAMP)
ON CONFLICT (schema_name) DO UPDATE SET schema_version = :'ver',
                                        adif_spec = :'adifv',
                                        last_update = CURRENT_TIMESTAMP;
