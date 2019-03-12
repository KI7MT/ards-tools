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
    import_only BOOLEAN DEFAULT '1',
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
    import_only BOOLEAN NOT NULL DEFAULT '0',
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
    import_only BOOLEAN NOT NULL DEFAULT '0',
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
    import_only BOOLEAN NOT NULL DEFAULT '0',
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
    import_only BOOLEAN NOT NULL DEFAULT '0',
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
        antenna_path.abbreviation AS "Abbreviation",
        antenna_path.meaning AS "Meaning"
    FROM adif.antenna_path
    ORDER BY adif.antenna_path.abbreviation;

-- arrl_section ----------------------------------------------------------------
CREATE TABLE adif_view.arrl_section AS
    SELECT 
        arrl_section.abbreviation AS "Abbreviation",
        arrl_section.name AS "Section Name",
        dxcc.code AS "DXCC Code",
        dxcc.name AS "DXCC Name",
        arrl_section.from_date AS "From Date",
        arrl_section.deleted_date AS "Deleted On"
    FROM adif.arrl_section
        JOIN adif.dxcc ON 
            adif.dxcc.dxcc_id = adif.arrl_section.dxcc_code
    ORDER BY arrl_section.name;

-- award -----------------------------------------------------------------------
CREATE TABLE adif_view.award AS
    SELECT
        award.name AS "Award Name",
        award.import_only AS "Import Only"
    FROM adif.award
    ORDER BY award.name;

-- band ------------------------------------------------------------------------
CREATE TABLE adif_view.band AS
    SELECT
        band.name AS "Band",
        band.lower_freq AS "Lower Freq (MHZ)",
        band.upper_freq AS "Upper Freq (MHZ)"
    FROM adif.band
    ORDER BY band.lower_freq;

-- contest ---------------------------------------------------------------------
CREATE TABLE adif_view.contest AS
    SELECT
        contest.name AS "Contest Name",
        contest.description AS "Description",
        contest.import_only AS "Import Only",
        weblink.url AS "Weblink URL"
    FROM adif.contest
        LEFT JOIN adif.weblink ON
            adif.weblink.weblink_id = adif.contest.weblink_id
    ORDER BY contest.name;

-- continent -------------------------------------------------------------------
CREATE TABLE adif_view.continent AS
    SELECT
        continent.abbreviation AS "Abbreviation",
        continent.name AS "Continent"
    FROM adif.continent
    ORDER BY continent.abbreviation;

-- county_name -----------------------------------------------------------------
CREATE TABLE adif_view.county_name AS
    SELECT
        county_name.name AS "County Name"
    FROM adif.county_name
    ORDER BY county_name.name;

-- cqzone ----------------------------------------------------------------------
CREATE TABLE adif_view.cqzone AS
    SELECT
       cqzone.cqzone AS "CQ Zone",
       cqzone.description AS "Description"
    FROM adif.cqzone
    ORDER BY cqzone.cqzone;

-- credit__award ---------------------------------------------------------------
CREATE TABLE adif_view.credit_award AS
    SELECT
        credit_award.name AS "Award Name"
    FROM adif.credit_award
    ORDER BY credit_award.name;

-- credit_facet ----------------------------------------------------------------
CREATE TABLE adif_view.credit_facet AS
    SELECT
        credit_facet.name AS "Facet"
    FROM adif.credit_facet
    ORDER BY credit_facet.name;

-- credit_sponsor --------------------------------------------------------------
CREATE TABLE adif_view.credit_sponsor AS
    SELECT
        credit_sponsor.name AS "Sponsor"
    FROM adif.credit_sponsor
    ORDER BY credit_sponsor.name;

-- credit ----------------------------------------------------------------------
CREATE TABLE adif_view.credit AS
    SELECT
        credit_for AS "Credit For",
        credit_sponsor.name AS "Sponsor",
        credit_award.name AS "Award",
        credit_facet.name AS "Facet"
    FROM adif.credit
        LEFT JOIN adif.credit_sponsor ON
            adif.credit_sponsor.credit_sponsor_id = adif.credit.credit_sponsor_id
        LEFT JOIN adif.credit_award ON
            adif.credit_award.credit_award_id = adif.credit.credit_award_id
        LEFT JOIN adif.credit_facet ON
            adif.credit_facet.credit_facet_id = adif.credit.credit_facet_id
    ORDER BY credit_for;

-- dxcc ------------------------------------------------------------------------
CREATE TABLE adif_view.dxcc AS
    SELECT
        dxcc.code AS "DXCC Code",
        dxcc.name AS "DXCC Name",
        dxcc.is_deleted as "Deleted"
    FROM adif.dxcc
    ORDER BY dxcc.code;

-- iaru_region_member-----------------------------------------------------------
CREATE TABLE adif_view.iaru_region_member AS
    SELECT
        iaru_region.region AS "Region",
        iaru_region_member.name AS "Name",
        iaru_region_member.country_territory AS "Territory"
    FROM adif.iaru_region_member
        JOIN adif.iaru_region ON
            iaru_region.iaru_region_id = iaru_region_member.iaru_region_id
    ORDER BY iaru_region.region, iaru_region_member.name;

-- iaru_region -----------------------------------------------------------------
CREATE TABLE adif_view.iaru_region AS
    SELECT
        iaru_region.region AS "Region",
        iaru_region.description AS "Description"
    FROM adif.iaru_region
    ORDER BY iaru_region.region;

-- ituzone ---------------------------------------------------------------------
CREATE TABLE adif_view.ituzone AS
    SELECT
       ituzone.ituzone AS "ITU Zone",
       ituzone.description AS "Description"
    FROM adif.ituzone
    ORDER BY ituzone.ituzone;

-- mode ------------------------------------------------------------------------
CREATE TABLE adif_view.mode AS
    SELECT
        mode.name AS "Mode",
        mode.import_only AS "Import Only"
    FROM adif.mode
    ORDER BY mode.name;

-- propogation_mode ------------------------------------------------------------
CREATE TABLE adif_view.propogation_mode AS
    SELECT
        propogation_mode.enumeration AS "Enumeration",
        propogation_mode.description AS "Description"
    FROM adif.propogation_mode
    ORDER BY propogation_mode.enumeration;

-- qsl_medium ------------------------------------------------------------------
CREATE TABLE adif_view.qsl_medium AS
    SELECT
        qsl_medium.medium AS "Medium",
        qsl_medium.description AS "Description"
    FROM adif.qsl_medium
    ORDER BY qsl_medium.medium;

-- qsl_rcvd --------------------------------------------------------------------
CREATE TABLE adif_view.qsl_rcvd AS
    SELECT
        qsl_rcvd.status AS "Status",
        qsl_rcvd.meaning AS "Meaning",
        qsl_rcvd.description AS "Description",
        qsl_rcvd.import_only AS "Import Only"
    FROM adif.qsl_rcvd
    ORDER BY qsl_rcvd.status;

-- qsl_sent --------------------------------------------------------------------
CREATE TABLE adif_view.qsl_sent AS
    SELECT
        qsl_sent.status AS "Status",
        qsl_sent.meaning AS "Meaning",
        qsl_sent.description AS "Description"
    FROM adif.qsl_sent
    ORDER BY qsl_sent.status;

-- qsl_via ---------------------------------------------------------------------
CREATE TABLE adif_view.qsl_via AS
    SELECT
        qsl_via.via AS "Abbreviation",
        qsl_via.description AS "Description",
        qsl_via.import_only as "Import Only"
    FROM adif.qsl_via
    ORDER BY qsl_via.via;

-- qso_complete ----------------------------------------------------------------
CREATE TABLE adif_view.qso_complete AS
    SELECT
        qso_complete.abbreviation AS "Abbreviation",
        qso_complete.meaning AS "Meaning"
    FROM adif.qso_complete
    ORDER BY qso_complete.Abbreviation;

-- qso_upload_status -----------------------------------------------------------
CREATE TABLE adif_view.qso_upload_status AS
    SELECT
        qso_upload_status.abbreviation AS "Abbreviation",
        qso_upload_status.description AS "Description"
    FROM adif.qso_upload_status
    ORDER BY qso_upload_status.Abbreviation;

-- region applicability --------------------------------------------------------
CREATE TABLE adif_view.region_applicability AS
    SELECT
        region.code AS "Code",
        region.dxcc_code AS "DXCC Code",
        region.region AS "Region",
        region.prefix AS "Prefix",
        STRING_AGG(DISTINCT adif.weblink.display_text::text,', ') AS "Applicability"
    FROM adif.region_applicability
        JOIN adif.region ON
            adif.region.region_id = adif.region_applicability.region_id
        JOIN adif.weblink ON
            adif.weblink.weblink_id = adif.region_applicability.weblink_id
    GROUP BY region.code, region.dxcc_code, region.region, region.prefix
    ORDER by region.code;

-- region ----------------------------------------------------------------------
CREATE TABLE adif_view.region AS
    SELECT
        region.code AS "Code",
        region.dxcc_code AS "DXCC Code",
        region.region AS "Region",
        region.prefix AS "Prefix"
    FROM adif.region
    ORDER BY region.Code;

-- sponsored_award -------------------------------------------------------------
CREATE TABLE adif_view.sponsored_award AS
    SELECT
        sponsored_award.sponsor AS "Sponsor",
        weblink.display_text AS "Orginization"
    FROM adif.sponsored_award
        JOIN adif.weblink ON
            adif.weblink.weblink_id = adif.sponsored_award.weblink_id
    GROUP BY sponsored_award.sponsor, weblink.display_text
    ORDER by sponsored_award.sponsor;

-- state_county ----------------------------------------------------------------
CREATE TABLE adif_view.state_county AS
    SELECT
        state.abbreviation AS "Abbreviation",
        state.name AS "State",
        county_name.name AS "County"
    FROM adif.state_county
        JOIN adif.state ON
            adif.state.state_id = adif.state_county.state_id
        JOIN adif.county_name ON
            adif.county_name.county_name_id = adif.state_county.county_name_id
    ORDER by state.name;

-- state -----------------------------------------------------------------------
CREATE TABLE adif_view.state AS
    SELECT
        state.abbreviation AS "Abbreviation",
        state.name AS "Name"
    FROM adif.state
    ORDER BY state.name;

-- submode ---------------------------------------------------------------------
CREATE TABLE adif_view.submode AS
    SELECT
        mode.name AS "Mode",
        submode.name AS "Submode"
    FROM adif.submode
        JOIN adif.mode ON
            mode.mode_id = submode.mode_id
    ORDER BY submode.name;

-- weblink ---------------------------------------------------------------------
CREATE TABLE adif_view.weblink AS
    SELECT
        weblink.display_text AS "Orginization",
        weblink.url AS "UTL"
    FROM adif.weblink
    ORDER BY weblink.display_text;

CREATE OR REPLACE VIEW view_schema_info AS
    SELECT
        schema_info.schema_name AS "Schema Name",
        schema_info.schema_version AS "Schema Version",
        schema_info.adif_spec AS "ADIF Spec",
        date_trunc('second', schema_info.last_update::TIMESTAMP) AS "Create Date"
    FROM schema_info
    ORDER BY  schema_info.schema_name;

\echo

-- pas_summary -----------------------------------------------------------------
CREATE TABLE adif_view.pas_summary AS
    SELECT
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

-- pas_type
CREATE TABLE adif_view.pas_type AS
    SELECT
        pas_type AS pri_subdivision_type
    FROM adif.pas_type
    ORDER BY pas_type;

-- sas_type 
CREATE TABLE adif_view.sas_type AS
    SELECT
        sas_type AS sec_subdivision
    FROM adif.sas_type
    ORDER BY sas_type;

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

-- PAS 5 Aland Is. -------------------------------------------------------------

CREATE TABLE adif_view.pas5 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS dxcc,
        pas.pas_code AS code,
        pas.subdivision,
        pas.is_deleted AS is_deleted
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '5'
	ORDER BY adif.pas.pas_code;


-- PAS 6 Alaska ----------------------------------------------------------------

CREATE TABLE adif_view.pas6 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision AS subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '6'
	ORDER BY adif.pas.pas_code;

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
        pas.subdivision AS subdivision,
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

-- Before (test table)
CREATE TABLE adif_view.pas15_before AS
    SELECT * FROM adif_view.pas15 WHERE before_date IS NOT NULL;

-- Current (test table)
CREATE TABLE adif_view.pas15_current AS
    SELECT * FROM adif_view.pas15 WHERE before_date IS NULL;

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

-- 21 Beleric Is. --------------------------------------------------------------

CREATE TABLE adif_view.pas21 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision AS subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '21'
	ORDER BY adif.pas.pas_code;

-- 27 Belarus ------------------------------------------------------------------
CREATE TABLE adif_view.pas27 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision AS subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '27'
	ORDER BY adif.pas.pas_code;

-- 29 Canary Is. ---------------------------------------------------------------

CREATE TABLE adif_view.pas29 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision AS subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '29'
	ORDER BY adif.pas.pas_code;

-- 32 Cetua & Melilla ----------------------------------------------------------

CREATE TABLE adif_view.pas32 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision AS subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '32'
	ORDER BY adif.pas.pas_code;

-- 50 Mexico -------------------------------------------------------------------

CREATE TABLE adif_view.pas50 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision AS subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '50'
	ORDER BY adif.pas.pas_code;

-- 52 Estonia ------------------------------------------------------------------

CREATE TABLE adif_view.pas52 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision AS subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '52'
	ORDER BY adif.pas.pas_code;


-- 54 European Russia ----------------------------------------------------------

-- NOTE: There are no multiple itu or cq zones for EU Russia. Therefore, no
--       need for it's own cqzone or ituzone tables nor aggregate's
CREATE TABLE adif_view.pas54 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision AS subdivision,
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
	WHERE dxcc.dxcc_id = '54'
	ORDER BY adif.pas.pas_code;

-- 61 Franz Josef Land ---------------------------------------------------------

CREATE TABLE adif_view.pas61 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision AS subdivision,
        pas.is_import_only AS is_import_only
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '61'
	ORDER BY adif.pas.pas_code;

-- 70 Cuba ---------------------------------------------------------------------

CREATE TABLE adif_view.pas70 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision AS subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '70'
	ORDER BY adif.pas.pas_code;

-- 74 El Salvador --------------------------------------------------------------

CREATE TABLE adif_view.pas74 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision AS subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '74'
	ORDER BY adif.pas.pas_code;

-- 86 Nicaragua ----------------------------------------------------------------
CREATE TABLE adif_view.pas86 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision AS subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '86'
	ORDER BY adif.pas.pas_code;

-- 100 Argentina ---------------------------------------------------------------

CREATE TABLE adif_view.pas100 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision AS subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '100'
	ORDER BY adif.pas.pas_code;

-- 104 Bolivia -----------------------------------------------------------------

CREATE TABLE adif_view.pas104 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision AS subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '104'
	ORDER BY adif.pas.pas_code;

-- 108 Brazil ------------------------------------------------------------------

CREATE TABLE adif_view.pas108 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision AS subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '108'
	ORDER BY adif.pas.pas_code;

-- 110 Hawaii ------------------------------------------------------------------

CREATE TABLE adif_view.pas110 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision AS subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '110'
	ORDER BY adif.pas.pas_code;

-- 112 Hawaii ------------------------------------------------------------------

CREATE TABLE adif_view.pas112 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision AS subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '112'
	ORDER BY adif.pas.pas_code;


-- 126 Kalingrad ---------------------------------------------------------------

-- NOTE: There are no multiple itu or cq zones for Kalingrad. Therefore, no
--       need for it's own cqzone or ituzone tables nor aggregate's
CREATE TABLE adif_view.pas126 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision AS subdivision,
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

-- 130 Kazakhstan --------------------------------------------------------------

CREATE TABLE adif_view.pas130 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision AS subdivision,
        pas.oblast as oblast
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '130'
	ORDER BY adif.pas.pas_code;

-- 132 Paraguay ----------------------------------------------------------------

CREATE TABLE adif_view.pas132 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision AS subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '132'
	ORDER BY adif.pas.pas_code;

-- 137 Republic of Korea -------------------------------------------------------

CREATE TABLE adif_view.pas137 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision AS subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '137'
	ORDER BY adif.pas.pas_code;

-- 138 Kure Island -------------------------------------------------------------

CREATE TABLE adif_view.pas138 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision AS subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '138'
	ORDER BY adif.pas.pas_code;

-- 144 Uruguay -----------------------------------------------------------------

CREATE TABLE adif_view.pas144 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision AS subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '144'
	ORDER BY adif.pas.pas_code;

-- 147 Lord Howe Is. -----------------------------------------------------------

CREATE TABLE adif_view.pas147 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision AS subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '147'
	ORDER BY adif.pas.pas_code;

-- 148 Venezuela ---------------------------------------------------------------

CREATE TABLE adif_view.pas148 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision AS subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '148'
	ORDER BY adif.pas.pas_code;

-- 149 Azores ------------------------------------------------------------------

CREATE TABLE adif_view.pas149 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision AS subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '149'
	ORDER BY adif.pas.pas_code;

-- 150 Australia ---------------------------------------------------------------

CREATE TABLE adif_view.pas150 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision AS subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '150'
	ORDER BY adif.pas.pas_code;

-- 151 Malyj Vysotski Is -------------------------------------------------------

CREATE TABLE adif_view.pas151 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision AS subdivision,
        pas.is_import_only AS is_import_only
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '151'
	ORDER BY adif.pas.pas_code;

-- 153 Macquarie Is. -----------------------------------------------------------

CREATE TABLE adif_view.pas153 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision AS subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '153'
	ORDER BY adif.pas.pas_code;

-- 163 Papua New Guinea --------------------------------------------------------

CREATE TABLE adif_view.pas163 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision AS subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '163'
	ORDER BY adif.pas.pas_code;

-- 170 New Zealand -------------------------------------------------------------

CREATE TABLE adif_view.pas170 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision AS subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '170'
	ORDER BY adif.pas.pas_code;

-- 177 Minami Torishima --------------------------------------------------------

CREATE TABLE adif_view.pas177 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision AS subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '177'
	ORDER BY adif.pas.pas_code;

-- 179 Moldova -----------------------------------------------------------------

CREATE TABLE adif_view.pas179 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision AS subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '179'
	ORDER BY adif.pas.pas_code;

-- 192 Ogasawara ---------------------------------------------------------------

CREATE TABLE adif_view.pas192 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision AS subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '192'
	ORDER BY adif.pas.pas_code;

-- 206 Austria -----------------------------------------------------------------

-- Regions and Subdivisions
CREATE TABLE adif_view.pas206 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas_region.region as region,
        pas.pas_code AS code,
        pas.subdivision AS subdivision,
        pas.before_date AS before_date,
        pas.after_date AS after_date
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
        JOIN adif.pas_region ON
            adif.pas.pas_region_id = pas_region.pas_region_id
        WHERE dxcc.dxcc_id = '206'
	ORDER BY adif.pas_region.region, pas.pas_code;

-- PAS 206 Regions Only
CREATE TABLE adif_view.pas206_region AS
    SELECT DISTINCT region FROM adif_view.pas206;

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

-- 209 Belgium -----------------------------------------------------------------

CREATE TABLE adif_view.pas209 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision AS subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '209'
	ORDER BY adif.pas.pas_code;

-- 212 Bulgaria ----------------------------------------------------------------

-- Regions and Subdivisions
CREATE TABLE adif_view.pas212 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas_region.region as region,
        pas.pas_code AS code,
        pas.subdivision AS subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
        JOIN adif.pas_region ON
            adif.pas.pas_region_id = pas_region.pas_region_id
        WHERE dxcc.dxcc_id = '212'
	ORDER BY adif.pas_region.region, pas.pas_code;

-- PAS 206 Regions Only
CREATE TABLE adif_view.pas212_region AS
    SELECT DISTINCT region FROM adif_view.pas212;

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

-- 214 Corsica -----------------------------------------------------------------

CREATE TABLE adif_view.pas214 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision AS subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '214'
	ORDER BY adif.pas.pas_code;

-- 221 Denmark -----------------------------------------------------------------

CREATE TABLE adif_view.pas221 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision AS subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '221'
	ORDER BY adif.pas.pas_code;

-- 224 Finland -----------------------------------------------------------------

-- Regions and Subdivisions
CREATE TABLE adif_view.pas224 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas_region.region as region,
        pas.pas_code AS code,
        pas.subdivision AS subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
        JOIN adif.pas_region ON
            adif.pas.pas_region_id = pas_region.pas_region_id
        WHERE dxcc.dxcc_id = '224'
	ORDER BY adif.pas_region.region, pas.pas_code;

-- PAS 224 Regions Only
CREATE TABLE adif_view.pas224_region AS
    SELECT DISTINCT region FROM adif_view.pas224;

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

-- 225 Sardinia ----------------------------------------------------------------

-- Regions and Subdivisions
CREATE TABLE adif_view.pas225 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas_region.region as region,
        pas.pas_code AS code,
        pas.subdivision AS subdivision,
        pas.is_import_only AS is_import_only
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
        JOIN adif.pas_region ON
            adif.pas.pas_region_id = pas_region.pas_region_id
        WHERE dxcc.dxcc_id = '225'
	ORDER BY adif.pas_region.region, pas.pas_code;

-- PAS 225 Regions Only
CREATE TABLE adif_view.pas225_region AS
    SELECT DISTINCT region FROM adif_view.pas225;

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

-- 227 France ------------------------------------------------------------------

CREATE TABLE adif_view.pas227 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision AS subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '227'
	ORDER BY adif.pas.pas_code;

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

-- 239 Hungary -----------------------------------------------------------------

CREATE TABLE adif_view.pas239 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision AS subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '239'
	ORDER BY adif.pas.pas_code;

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

-- 248 Italy -------------------------------------------------------------------

-- Regions and Subdivisions
CREATE TABLE adif_view.pas248 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas_region.region as region,
        pas.pas_code AS code,
        pas.subdivision AS subdivision,
        pas.is_import_only AS is_import_only
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
        JOIN adif.pas_region ON
            adif.pas.pas_region_id = pas_region.pas_region_id
        WHERE dxcc.dxcc_id = '248'
	ORDER BY adif.pas_region.region, pas.pas_code;

-- PAS 225 Regions Only
CREATE TABLE adif_view.pas248_region AS
    SELECT DISTINCT region FROM adif_view.pas248;

-- PAS 225 Stats
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

-- 256 Maderia Is. -------------------------------------------------------------

CREATE TABLE adif_view.pas256 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision AS subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '256'
	ORDER BY adif.pas.pas_code;

-- 263 Netherlands -------------------------------------------------------------

CREATE TABLE adif_view.pas263 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision AS subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '263'
	ORDER BY adif.pas.pas_code;

-- 269 Poland ------------------------------------------------------------------

CREATE TABLE adif_view.pas269 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision AS subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '269'
	ORDER BY adif.pas.pas_code;

-- 272 Portugal ----------------------------------------------------------------

CREATE TABLE adif_view.pas272 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision AS subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '272'
	ORDER BY adif.pas.pas_code;

-- 275 Romania -----------------------------------------------------------------

CREATE TABLE adif_view.pas275 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision AS subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '275'
	ORDER BY adif.pas.pas_code;

-- 281 Spain -------------------------------------------------------------------

CREATE TABLE adif_view.pas281 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision AS subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '281'
	ORDER BY adif.pas.pas_code;

-- 284 Sweden ------------------------------------------------------------------

CREATE TABLE adif_view.pas284 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision AS subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '284'
	ORDER BY adif.pas.pas_code;

-- 287 Switzerland -------------------------------------------------------------

CREATE TABLE adif_view.pas287 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision AS subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '287'
	ORDER BY adif.pas.pas_code;

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

-- 291 United States -----------------------------------------------------------

CREATE TABLE adif_view.pas291 AS
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
    WHERE dxcc.dxcc_id = '291'
	GROUP BY dxcc.dxcc_id, pas.pas_code, pas.subdivision
	ORDER BY adif.pas.pas_code;

-- 318 China -------------------------------------------------------------------

CREATE TABLE adif_view.pas318 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision AS subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '318'
	ORDER BY adif.pas.pas_code;

-- 327 Indonesia ---------------------------------------------------------------

CREATE TABLE adif_view.pas327 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision AS subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '327'
	ORDER BY adif.pas.pas_code;

-- 339 Japan -------------------------------------------------------------------

-- Regions and Subdivisions
CREATE TABLE adif_view.pas339 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas_region.region as region,
        pas.pas_code AS code,
        pas.subdivision AS subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
        JOIN adif.pas_region ON
            adif.pas.pas_region_id = pas_region.pas_region_id
        WHERE dxcc.dxcc_id = '339'
	ORDER BY adif.pas_region.region, pas.pas_code;

-- PAS 225 Regions Only
CREATE TABLE adif_view.pas339_region AS
    SELECT DISTINCT region FROM adif_view.pas339;

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

-- 375 Philippines -------------------------------------------------------------

-- Regions and Subdivisions
CREATE TABLE adif_view.pas375 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas_region.region as region,
        pas.pas_code AS code,
        pas.subdivision AS subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
        JOIN adif.pas_region ON
            adif.pas.pas_region_id = pas_region.pas_region_id
        WHERE dxcc.dxcc_id = '375'
	ORDER BY adif.pas_region.region, pas.pas_code;

-- PAS 225 Regions Only
CREATE TABLE adif_view.pas375_region AS
    SELECT DISTINCT region FROM adif_view.pas375;

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

-- 386 Taiwan ------------------------------------------------------------------

CREATE TABLE adif_view.pas386 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision AS subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '386'
	ORDER BY adif.pas.pas_code;

-- 387 Thailand ----------------------------------------------------------------

CREATE TABLE adif_view.pas387 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision AS subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '387'
	ORDER BY adif.pas.pas_code;

-- 497 Croatia -----------------------------------------------------------------

CREATE TABLE adif_view.pas497 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas.pas_code AS code,
        pas.subdivision AS subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
    WHERE dxcc.dxcc_id = '497'
	ORDER BY adif.pas.pas_code;


-- 503 Czech Republic ----------------------------------------------------------

-- Regions and Subdivisions
CREATE TABLE adif_view.pas503 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas_region.region as region,
        pas.pas_code AS code,
        pas.subdivision AS subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
        JOIN adif.pas_region ON
            adif.pas.pas_region_id = pas_region.pas_region_id
        WHERE dxcc.dxcc_id = '503'
	ORDER BY adif.pas_region.region, pas.pas_code;

-- PAS 225 Regions Only
CREATE TABLE adif_view.pas503_region AS
    SELECT DISTINCT region FROM adif_view.pas503;

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

-- 504 Slovak Republic ---------------------------------------------------------

-- Regions and Subdivisions
CREATE TABLE adif_view.pas504 AS
    SELECT
        dxcc.dxcc_id AS dxcc_code,
        dxcc.name AS country,
        pas_region.region as region,
        pas.pas_code AS code,
        pas.subdivision AS subdivision
    FROM adif.pas
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas.dxcc_id
        JOIN adif.pas_region ON
            adif.pas.pas_region_id = pas_region.pas_region_id
        WHERE dxcc.dxcc_id = '504'
	ORDER BY adif.pas_region.region, pas.pas_code;

-- PAS 225 Regions Only
CREATE TABLE adif_view.pas504_region AS
    SELECT DISTINCT region FROM adif_view.pas503;

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

-- JCC Prefectures and Cities --------------------------------------------------
CREATE TABLE adif_view.jcc AS
    SELECT
        jcc.prefecture AS prefecture,
        jcc_city.number as jcc_number,
        jcc_city.city AS city,
        jcc_city.is_deleted AS is_deleted,
        jcc_city.deleted_date AS deleted_date
    FROM adif.jcc
        JOIN adif.jcc_city ON
            adif.jcc_city.jcc_id = jcc.jcc_id
	ORDER BY jcc_city.number;

-- JCC City County by Prefectture Stats
CREATE TABLE adif_view.jcc_prefecture_stats AS
    SELECT 
        adif.jcc.prefecture AS precefture,
        count(*) AS city_count
    FROM adif.jcc
        JOIN adif.jcc_city ON
            adif.jcc_city.jcc_id = jcc.jcc_id
    GROUP BY jcc.prefecture
    ORDER BY jcc.prefecture;

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

-- RDXC Full RDA List ----------------------------------------------------------
CREATE TABLE adif_view.rdxc_district_list AS
    SELECT
        rdxc.rdxc_code as rdxc_code,
        rdxc.oblast as oblast,
        rdxc.prefix as prefix,
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

-- RDXC Oblast Stats
-- RDXC Oblasts Numbers do not match the 3.0.9 Spec
-- RDXC Number from the source dont match what's published by v3.0.9 Spec Either
-- ADIF Spec states: Current = 2644, Deleted = +180
CREATE TABLE adif_view.rdxc_oblast_count AS
SELECT 
    rdxc.rdxc_code AS rdxc_code,
    rdxc.prefix AS prefix, 
    rdxc.oblast AS oblast, 
    count(*) AS total_count
FROM adif.rdxc
    JOIN adif.rdxc_district ON 
        rdxc_district.rdxc_id = rdxc.rdxc_id
GROUP BY rdxc.oblast, rdxc.rdxc_code, rdxc.prefix 
ORDER BY rdxc.rdxc_code;

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

-- *****************************************************************************
-- ADD SCHEMA INFORMATION
-- *****************************************************************************

INSERT INTO schema_info(schema_name, schema_version, adif_spec, last_update)
VALUES('adif', :'ver', :'adifv', CURRENT_TIMESTAMP)
ON CONFLICT (schema_name) DO UPDATE SET schema_version = :'ver',
                                        adif_spec = :'adifv',
                                        last_update = CURRENT_TIMESTAMP;
