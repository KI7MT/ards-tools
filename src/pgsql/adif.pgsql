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

        * PostgreSQL v10 or above
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

        TODO: Add Japan JCC, JGC, KU Tables and List CSV Data
        TODO: Need JCC, JGC, and KU CSV Datafiles

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
DROP SCHEMA IF EXISTS :name CASCADE;

-- Create New Schema
CREATE SCHEMA :name;

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
    weblink_id INT,
    CONSTRAINT cqzone_cqzone_uq UNIQUE (cqzone)
);

-- ITU Zone --------------------------------------------------------------------
CREATE TABLE adif.ituzone -- FK Done
(
    ituzone_id INT PRIMARY KEY,
    ituzone INT NOT NULL,
    description VARCHAR(300),
    weblink_id INT,
    CONSTRAINT ituzone_ituzone_uq UNIQUE (ituzone)
);

-- IARU Region -----------------------------------------------------------------
CREATE TABLE adif.iaru_region -- FK Done
(
    iaru_region_id INT PRIMARY KEY,
    region INT NOT NULL,
    description VARCHAR(120),
    weblink_id INT,
    CONSTRAINT iaru_region_region_uq UNIQUE (region)
);

-- IARU Region Member ----------------------------------------------------------
CREATE TABLE adif.iaru_region_member -- FK Done
(
    iaru_region_member_id INT PRIMARY KEY,
    iaru_region_id INT NOT NULL,
    name VARCHAR(120),
    country_territory VARCHAR(60),
    CONSTRAINT iaru_region_name_uq UNIQUE (name)
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
    abbreviaiton VARCHAR(1) NOT NULL,
    description VARCHAR(120) NOT NULL,
    CONSTRAINT qso_upload_status_abbreviation_uq UNIQUE (abbreviaiton)
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
\COPY adif.qso_complete FROM 'adif/qsl_complete.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY adif.qso_upload_status FROM 'adif/qso_upload_status.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY adif.region FROM 'adif/region.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY adif.region_applicability FROM 'adif/region_applicability.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY adif.weblink FROM 'adif/weblink.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY adif.sponsored_award FROM 'adif/sponsored_award.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY adif.cqzone FROM 'adif/cqzone.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY adif.ituzone FROM 'adif/ituzone.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

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

-- CQ Zone ---------------------------------------------------------------------
ALTER TABLE adif.cqzone ADD CONSTRAINT cqzone_weblink_fkey
    FOREIGN KEY (weblink_id) REFERENCES adif.weblink (weblink_id);

-- ITU Zone --------------------------------------------------------------------
ALTER TABLE adif.ituzone ADD CONSTRAINT ituzone_weblink_fkey
    FOREIGN KEY (weblink_id) REFERENCES adif.weblink (weblink_id);

-- IARU Region Weblink ---------------------------------------------------------
ALTER TABLE adif.iaru_region ADD CONSTRAINT iaru_region_weblink_fkey
    FOREIGN KEY (weblink_id) REFERENCES adif.weblink (weblink_id);

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

\echo
\echo 'Creating Views'
\echo '-----------------------------'

-- View: adif.vw_antenna_path
CREATE OR REPLACE VIEW adif.view_antenna_path AS
    SELECT 
        antenna_path.abbreviation AS "Abbreviation",
        antenna_path.meaning AS "Meaning"
    FROM adif.antenna_path
    ORDER BY adif.antenna_path.abbreviation;

-- View: adif.vw_arrl_section
CREATE OR REPLACE VIEW adif.view_arrl_section AS
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

-- View: adif.vw_award
CREATE OR REPLACE VIEW adif.view_band AS
    SELECT
        band.name AS "Band",
        band.lower_freq AS "Lower Freq (MHZ)",
        band.upper_freq AS "Upper Freq (MHZ)"
    FROM adif.band
    ORDER BY band.lower_freq;

-- View: adif.award_view
CREATE OR REPLACE VIEW adif.view_award AS
    SELECT
        award.name AS "Award Name",
        award.import_only AS "Import Only"
    FROM adif.award
    ORDER BY award.name;

-- View: adif.vw_contest
CREATE OR REPLACE VIEW adif.view_contest AS
    SELECT
        contest.name AS "Contest Name",
        contest.description AS "Description",
        contest.import_only AS "Import Only",
        weblink.url AS "Weblink URL"
    FROM adif.contest
        LEFT JOIN adif.weblink ON
            adif.weblink.weblink_id = adif.contest.weblink_id
    ORDER BY contest.name;

-- View: adif.vw_continent
CREATE OR REPLACE VIEW adif.view_continent AS
    SELECT
        continent.abbreviation AS "Abbreviation",
        continent.name AS "Continent"
    FROM adif.continent
    ORDER BY continent.abbreviation;

-- View: adif.vw_county_name
CREATE OR REPLACE VIEW adif.view_county_name AS
    SELECT
        county_name.name AS "County Name"
    FROM adif.county_name
    ORDER BY county_name.name;

-- View: adif.vw_credit_award
CREATE OR REPLACE VIEW adif.view_credit_award AS
    SELECT
        credit_award.name AS "Award Name"
    FROM adif.credit_award
    ORDER BY credit_award.name;

-- View: adif.vw_credit_facet
CREATE OR REPLACE VIEW adif.view_credit_facet AS
    SELECT
        credit_facet.name AS "Facet"
    FROM adif.credit_facet
    ORDER BY credit_facet.name;

-- View: adif.vw_credit_sponsor
CREATE OR REPLACE VIEW adif.view_credit_sponsor AS
    SELECT
        credit_sponsor.name AS "Sponsor"
    FROM adif.credit_sponsor
    ORDER BY credit_sponsor.name;

-- View: adif.vw_credit
CREATE OR REPLACE VIEW adif.view_credit AS
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

-- View: adif.vw_dxcc
CREATE OR REPLACE VIEW adif.view_dxcc AS
    SELECT
        dxcc.code AS "DXCC Code",
        dxcc.name AS "DXCC Name",
        dxcc.is_deleted as "Deleted"
    FROM adif.dxcc
    ORDER BY dxcc.code;


-- View: adif.vw_state
CREATE OR REPLACE VIEW adif.view_state AS
    SELECT
        state.abbreviation AS "Abbreviation",
        state.name AS "Name"
    FROM adif.state
    ORDER BY state.name;

-- View: adif.vw_state_county
CREATE OR REPLACE VIEW adif.view_state_county AS
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

-- =============================================================================
--
--
--
--
--
--
--
--
--
--               ADIF PRIMARY ADMINISTRATION SUBDIVISION
--
--
--
--
--

--
--
--
--
-- =============================================================================

-- Primary Administration Subdivision Summary ----------------------------------
CREATE TABLE adif.pas_summary
(
    pas_summary_id SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    pas_subdivision_type_id INT NOT NULL,
    has_oblast BOOLEAN NOT NULL DEFAULT '0',
    has_sas BOOLEAN NOT NULL DEFAULT '0',
    sas_subdivision_type_id INT,
    CHECK ( NOT (has_sas AND sas_subdivision_type_id IS NULL) )
); 

-- Primary Administration Subdivision Type
CREATE TABLE adif.pas_subdivision_type
(
    pas_subdivision_type_id SERIAL PRIMARY KEY,
    pas_subdivision_type VARCHAR(20) NOT NULL,
    CONSTRAINT pas_subdivision_type_uq UNIQUE (pas_subdivision_type)
);

-- Secondary Administration Subdivision
CREATE TABLE adif.sas_subdivision_type
(
    sas_subdivision_type_id SERIAL PRIMARY KEY,
    sas_subdivision_type VARCHAR(20) NOT NULL,
    CONSTRAINT sas_subdivision_type_uq UNIQUE (sas_subdivision_type)
);

-- PAS Summary Data
\COPY adif.pas_subdivision_type FROM 'adif-pas/pas_subdivision_type.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY adif.sas_subdivision_type FROM 'adif-pas/sas_subdivision_type.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY adif.pas_summary FROM 'adif-pas/pas_summary.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS Summary FK's
ALTER TABLE adif.pas_summary ADD CONSTRAINT pas_summary_pas_subdivision_type_fkey
    FOREIGN KEY (pas_subdivision_type_id) REFERENCES adif.pas_subdivision_type (pas_subdivision_type_id);

ALTER TABLE adif.pas_summary ADD CONSTRAINT pas_summary_sas_subdivision_type_fkey
    FOREIGN KEY (sas_subdivision_type_id) REFERENCES adif.sas_subdivision_type (sas_subdivision_type_id);

-- view_pas_summary
CREATE OR REPLACE VIEW adif.view_pas_summary AS
    SELECT
        dxcc.dxcc_id AS "DXCC Code",
        dxcc.name AS "Country",
        pas_subdivision_type.pas_subdivision_type AS "Pri. Subdivision",
        pas_summary.has_oblast AS "Has Oblast",
        pas_summary.has_sas AS "Has Secondary",
        sas_subdivision_type.sas_subdivision_type AS "Sec. Subdivision"
    FROM adif.pas_summary
        LEFT JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas_summary.dxcc_code
        LEFT JOIN adif.pas_subdivision_type ON
            adif.pas_summary.pas_subdivision_type_id = adif.pas_subdivision_type.pas_subdivision_type_id
        LEFT JOIN adif.sas_subdivision_type ON
            adif.pas_summary.sas_subdivision_type_id = adif.sas_subdivision_type.sas_subdivision_type_id
    ORDER BY adif.pas_summary.pas_summary_id;

-- view_pas_subdivision_type
CREATE OR REPLACE VIEW adif.view_pas_subdivision_type AS
    SELECT
        pas_subdivision_type AS "Pri. Subdivision"
    FROM adif.pas_subdivision_type
    ORDER BY pas_subdivision_type;

-- view_sas_subdivision_type 
CREATE OR REPLACE VIEW adif.view_sas_subdivision_type AS
    SELECT
        sas_subdivision_type AS "Sec. Subdivision"
    FROM adif.sas_subdivision_type
    ORDER BY sas_subdivision_type;

-- PAS-1 Canada ----------------------------------------------------------------

-- PAS-1 Table
CREATE TABLE adif.pas1
(
    pas1_id SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    code CHAR(2) NOT NULL, -- two letter code
    subdivision VARCHAR(120) NOT NULL,
    CONSTRAINT pas1_uq UNIQUE (code,subdivision)
);

-- PAS-1 CQ Zone
CREATE TABLE adif.pas1_cqzone
(
    pas1_cqzone_id SERIAL PRIMARY KEY,
    pas1_id INT NOT NULL,
    cqzone_id INT NOT NULL
);

-- PAS-1 ITU Zone 
CREATE TABLE adif.pas1_ituzone
(
    pas1_ituzone_id SERIAL PRIMARY KEY,
    pas1_id INT NOT NULL,
    ituzone_id INT NOT NULL
);

-- PAS-1 Data
\COPY adif.pas1 FROM 'adif-pas/pas1.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY adif.pas1_cqzone FROM 'adif-pas/pas1_cqzone.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY adif.pas1_ituzone FROM 'adif-pas/pas1_ituzone.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-1 FK's 
ALTER TABLE adif.pas1_cqzone ADD CONSTRAINT pas1_cqzone_pas1_fkey
    FOREIGN KEY (pas1_id) REFERENCES adif.pas1 (pas1_id);

ALTER TABLE adif.pas1_cqzone ADD CONSTRAINT pas1_cqzone_cqzone_fkey
    FOREIGN KEY (cqzone_id) REFERENCES adif.cqzone (cqzone_id);

ALTER TABLE adif.pas1_ituzone ADD CONSTRAINT pas1_ituzone_pas1_fkey
    FOREIGN KEY (pas1_id) REFERENCES adif.pas1 (pas1_id);

ALTER TABLE adif.pas1_ituzone ADD CONSTRAINT pas1_ituzone_ituzone_fkey
    FOREIGN KEY (ituzone_id) REFERENCES adif.ituzone (ituzone_id);

-- PAS-1 View
CREATE OR REPLACE VIEW adif.view_pas1 AS
    SELECT
        dxcc.dxcc_id AS "DXCC Code",
        dxcc.name AS "Country",
        pas1.code AS "Code",
        pas1.subdivision AS "Subdivision",
		STRING_AGG(DISTINCT pas1_cqzone.cqzone_id::text,', ') AS "CQ Zone",
		STRING_AGG(DISTINCT pas1_ituzone.ituzone_id::text,', ') AS "ITU Zone"
    FROM adif.pas1
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas1.dxcc_code
		JOIN adif.pas1_cqzone ON
		    adif.pas1_cqzone.pas1_id = pas1.pas1_id
		JOIN adif.pas1_ituzone ON
		    adif.pas1_ituzone.pas1_id = pas1.pas1_id
	GROUP BY dxcc.dxcc_id, pas1.code, pas1.subdivision
	ORDER BY adif.pas1.code;

-- 5 Aland Is. -----------------------------------------------------------------

-- PAS-5 Table
CREATE TABLE adif.pas5
(
    pas5_id SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    code CHAR(3) NOT NULL, -- three char 001, 002, 003
    subdivision VARCHAR(120) NOT NULL,
    is_deleted BOOLEAN NOT NULL DEFAULT '0',
    CONSTRAINT pas5_uq UNIQUE (code,subdivision)
);

-- PAS-5 Data
\COPY adif.pas5 FROM 'adif-pas/pas5.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-5 View
CREATE OR REPLACE VIEW adif.view_pas5 AS
    SELECT
        dxcc.dxcc_id AS "DXCC Code",
        dxcc.name AS "Country",
        pas5.code AS "Code",
        pas5.subdivision AS "Subdivision",
        pas5.is_deleted AS "Is Deleted"
    FROM adif.pas5
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas5.dxcc_code
	ORDER BY adif.pas5.code;

-- 6 Alaska --------------------------------------------------------------------

-- PA6 Table
CREATE TABLE adif.pas6
(
    pas6_id SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char AK
    subdivision VARCHAR(120) NOT NULL,
    CONSTRAINT pas6_uq UNIQUE (code,subdivision)
);

-- PAS-6 Data
\COPY adif.pas6 FROM 'adif-pas/pas6.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-6 View
CREATE OR REPLACE VIEW adif.view_pas6 AS
    SELECT
        dxcc.dxcc_id AS "DXCC Code",
        dxcc.name AS "Country",
        pas6.code AS "Code",
        pas6.subdivision AS "Subdivision"
    FROM adif.pas6
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas6.dxcc_code
	ORDER BY adif.pas6.code;

-- 15 Asiatic Russia -----------------------------------------------------------

CREATE TABLE adif.pas15
(
    pas15_id SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char AA, BB, CC
    subdivision VARCHAR(120) NOT NULL,
    oblast VARCHAR(3) NOT NULL,
    before_date DATE,
    referred_to_as VARCHAR(120),
    CONSTRAINT pas15_uq UNIQUE (code,subdivision)
);

-- PAS-15 CQ Zone
CREATE TABLE adif.pas15_cqzone
(
    pas15_cqzone_id SERIAL PRIMARY KEY,
    pas15_id INT NOT NULL,
    cqzone_id INT NOT NULL
);

-- PAS-15 ITU Zone
-- For CSV File Conversion: IF(G2 <> "",TEXT(G2,"yyyy-mm-dd"),"")
CREATE TABLE adif.pas15_ituzone
(
    pas15_ituzone_id SERIAL PRIMARY KEY,
    pas15_id INT NOT NULL,
    ituzone_id INT NOT NULL
);

-- PAS-15 Data
\COPY adif.pas15 FROM 'adif-pas/pas15.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY adif.pas15_cqzone FROM 'adif-pas/pas15_cqzone.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY adif.pas15_ituzone FROM 'adif-pas/pas15_ituzone.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-015 Asiatic Russia
ALTER TABLE adif.pas15_cqzone ADD CONSTRAINT pas15_cqzone_pas15_fkey
    FOREIGN KEY (pas15_id) REFERENCES adif.pas15 (pas15_id);

ALTER TABLE adif.pas15_cqzone ADD CONSTRAINT pas15_cqzone_cqzone_fkey
    FOREIGN KEY (cqzone_id) REFERENCES adif.cqzone (cqzone_id);

ALTER TABLE adif.pas15_ituzone ADD CONSTRAINT pas15_ituzone_pas15_fkey
    FOREIGN KEY (pas15_id) REFERENCES adif.pas15 (pas15_id);

ALTER TABLE adif.pas15_ituzone ADD CONSTRAINT pas15_ituzone_ituzone_fkey
    FOREIGN KEY (ituzone_id) REFERENCES adif.ituzone (ituzone_id);

-- PAS-15 View Full Table
CREATE OR REPLACE VIEW adif.view_pas15 AS
    SELECT
        dxcc.dxcc_id AS "DXCC Code",
        dxcc.name AS "Country",
        pas15.code AS "Code",
        pas15.subdivision AS "Subdivision",
		STRING_AGG(DISTINCT pas15_cqzone.cqzone_id::text,', ') AS "CQ Zone",
		STRING_AGG(DISTINCT pas15_ituzone.ituzone_id::text,', ') AS "ITU Zone",
        pas15.oblast AS "Oblast",
        pas15.before_date AS "Before Date",
        pas15.referred_to_as AS "Referred To As"
    FROM adif.pas15
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas15.dxcc_code
		JOIN adif.pas15_cqzone ON
		    adif.pas15_cqzone.pas15_id = pas15.pas15_id
		JOIN adif.pas15_ituzone ON
		    adif.pas15_ituzone.pas15_id = pas15.pas15_id
	GROUP BY dxcc.dxcc_id, pas15.code, pas15.subdivision, pas15.oblast, pas15.before_date, pas15.referred_to_as
	ORDER BY adif.pas15.code;

-- PAS-15 Partial List where Before Date IS NOT NULL
CREATE OR REPLACE VIEW adif.view_pas15_before AS
    SELECT
        dxcc.dxcc_id AS "DXCC Code",
        dxcc.name AS "Country",
        pas15.code AS "Code",
        pas15.subdivision AS "Subdivision",
		STRING_AGG(DISTINCT pas15_cqzone.cqzone_id::text,', ') AS "CQ Zone",
		STRING_AGG(DISTINCT pas15_ituzone.ituzone_id::text,', ') AS "ITU Zone",
        pas15.oblast AS "Oblast",
        pas15.before_date AS "Before Date",
        pas15.referred_to_as AS "Referred To As"
    FROM adif.pas15
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas15.dxcc_code
		JOIN adif.pas15_cqzone ON
		    adif.pas15_cqzone.pas15_id = pas15.pas15_id
		JOIN adif.pas15_ituzone ON
		    adif.pas15_ituzone.pas15_id = pas15.pas15_id
    WHERE pas15.before_date IS NOT NULL
	GROUP BY dxcc.dxcc_id, pas15.code, pas15.subdivision, pas15.oblast, pas15.before_date, pas15.referred_to_as
	ORDER BY adif.pas15.code;

-- PAS-15 Current List where Before Date IS NULL
CREATE OR REPLACE VIEW adif.view_pas15_current AS
    SELECT
        dxcc.dxcc_id AS "DXCC Code",
        dxcc.name AS "Country",
        pas15.code AS "Code",
        pas15.subdivision AS "Subdivision",
		STRING_AGG(DISTINCT pas15_cqzone.cqzone_id::text,', ') AS "CQ Zone",
		STRING_AGG(DISTINCT pas15_ituzone.ituzone_id::text,', ') AS "ITU Zone",
        pas15.oblast AS "Oblast",
        pas15.before_date AS "Before Date",
        pas15.referred_to_as AS "Referred To As"
    FROM adif.pas15
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas15.dxcc_code
		JOIN adif.pas15_cqzone ON
		    adif.pas15_cqzone.pas15_id = pas15.pas15_id
		JOIN adif.pas15_ituzone ON
		    adif.pas15_ituzone.pas15_id = pas15.pas15_id
    WHERE pas15.before_date IS NULL
	GROUP BY dxcc.dxcc_id, pas15.code, pas15.subdivision, pas15.oblast, pas15.before_date, pas15.referred_to_as
	ORDER BY adif.pas15.code;

-- PAD-15 Stats
CREATE OR REPLACE VIEW adif.view_pas15_stats AS
    SELECT  (
            SELECT COUNT(*)
                FROM adif.pas15
            ) AS "Total Count",
            (
            SELECT COUNT(*)
                FROM adif.pas15 WHERE before_date IS NOT NULL
            ) AS "Before Count",
            (
            SELECT COUNT(*)
                FROM adif.pas15 WHERE before_date IS NULL
            ) AS "Current Count";

-- 21 Beleric Is. --------------------------------------------------------------

--PAS-21 Table
CREATE TABLE adif.pas21
(
    pas21_id SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char IB, IC, ...
    subdivision VARCHAR(120) NOT NULL,
    CONSTRAINT pas21_uq UNIQUE (code,subdivision)
);

-- PAS-21
\COPY adif.pas21 FROM 'adif-pas/pas21.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-21 View
CREATE OR REPLACE VIEW adif.view_pas21 AS
    SELECT
        dxcc.dxcc_id AS "DXCC Code",
        dxcc.name AS "Country",
        pas21.code AS "Code",
        pas21.subdivision AS "Subdivision"
    FROM adif.pas21
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas21.dxcc_code
	ORDER BY adif.pas21.code;

-- 27 Belarus ------------------------------------------------------------------

-- PAS-27 Table
CREATE TABLE adif.pas27
(
    pas27_id SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    code CHAR(2) NOT NULL, --two char MI, BR, HR
    subdivision VARCHAR(120) NOT NULL,
    CONSTRAINT pas27_uq UNIQUE (code,subdivision)
);

-- PAS-27 Data
\COPY adif.pas27 FROM 'adif-pas/pas27.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-27 View
CREATE OR REPLACE VIEW adif.view_pas27 AS
    SELECT
        dxcc.dxcc_id AS "DXCC Code",
        dxcc.name AS "Country",
        pas27.code AS "Code",
        pas27.subdivision AS "Subdivision"
    FROM adif.pas27
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas27.dxcc_code
	ORDER BY adif.pas27.code;

-- 29 Canary Is. ---------------------------------------------------------------

-- PAS-29 Table
CREATE TABLE adif.pas29
(
    pas29_id SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    code CHAR(2) NOT NULL, --two hcar CG, TF, ...
    subdivision VARCHAR(120) NOT NULL,
    CONSTRAINT pas29_uq UNIQUE (code,subdivision)
);

-- PAS-29 Data
\COPY adif.pas29 FROM 'adif-pas/pas29.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-29 View
CREATE OR REPLACE VIEW adif.view_pas29 AS
    SELECT
        dxcc.dxcc_id AS "DXCC Code",
        dxcc.name AS "Country",
        pas29.code AS "Code",
        pas29.subdivision AS "Subdivision"
    FROM adif.pas29
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas29.dxcc_code
	ORDER BY adif.pas29.code;

-- 32 Cetua & Melilla ----------------------------------------------------------

-- PAS-32 Table
CREATE TABLE adif.pas32
(
    pas32_id SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char CE, ML, ...
    subdivision VARCHAR(120) NOT NULL,
    CONSTRAINT pas32_uq UNIQUE (code,subdivision)
);

-- PAS-032 Data
\COPY adif.pas32 FROM 'adif-pas/pas32.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-32 View
CREATE OR REPLACE VIEW adif.view_pas32 AS
    SELECT
        dxcc.dxcc_id AS "DXCC Code",
        dxcc.name AS "Country",
        pas32.code AS "Code",
        pas32.subdivision AS "Subdivision"
    FROM adif.pas32
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas32.dxcc_code
	ORDER BY adif.pas32.code;

-- 50 Mexico -------------------------------------------------------------------

-- PAS-50 Table
CREATE TABLE adif.pas50
(
    pas50_id SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    code CHAR(3) NOT NULL, -- three char COL, DF, EMX, ...
    subdivision VARCHAR(120) NOT NULL,
    CONSTRAINT pas50_uq UNIQUE (code,subdivision)
);

-- PAS-050 Data
\COPY adif.pas50 FROM 'adif-pas/pas50.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-50 View
CREATE OR REPLACE VIEW adif.view_pas50 AS
    SELECT
        dxcc.dxcc_id AS "DXCC Code",
        dxcc.name AS "Country",
        pas50.code AS "Code",
        pas50.subdivision AS "Subdivision"
    FROM adif.pas50
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas50.dxcc_code
	ORDER BY adif.pas50.code;

-- 52 Estonia ------------------------------------------------------------------

-- PAS-52 Table
CREATE TABLE adif.pas52
(
    pas52_id SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    code CHAR(2) NOT NULL, -- assuming two char 37, 39, 44, ...
    subdivision VARCHAR(120) NOT NULL,
    CONSTRAINT pas52_uq UNIQUE (code,subdivision)
);

-- PAS-52 View
CREATE OR REPLACE VIEW adif.view_pas52 AS
    SELECT
        dxcc.dxcc_id AS "DXCC Code",
        dxcc.name AS "Country",
        pas52.code AS "Code",
        pas52.subdivision AS "Subdivision"
    FROM adif.pas52
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas52.dxcc_code
	ORDER BY adif.pas52.code;

-- PAS-52 Data
\COPY adif.pas52 FROM 'adif-pas/pas52.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- 54 European Russia ----------------------------------------------------------

-- PAS-54 Table
CREATE TABLE adif.pas54
(
    pas54_id SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char SP, LO, KL, ...
    subdivision VARCHAR(120) NOT NULL,
    oblast CHAR(3) NOT NULL, -- three char, all oblast numbers are 3 digits
    cqzone_id INT NOT NULL,
    ituzone_id INT NOT NULL,
    CONSTRAINT pas54_uq UNIQUE (code,subdivision)
);

-- PAS-54 Data
\COPY adif.pas54 FROM 'adif-pas/pas54.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-54 FK
ALTER TABLE adif.pas54 ADD CONSTRAINT pas54_cqzone_fkey
    FOREIGN KEY (cqzone_id) REFERENCES adif.cqzone (cqzone_id);

ALTER TABLE adif.pas54 ADD CONSTRAINT pas54_ituzone_fkey
    FOREIGN KEY (ituzone_id) REFERENCES adif.ituzone (ituzone_id);

-- PAS-54 View
-- NOTE: There are no multiple itu or cq zones for EU Russia. Therefore, no
--       need for it's own cqzone or ituzone tables nor aggregate's
CREATE OR REPLACE VIEW adif.view_pas54 AS
    SELECT
        dxcc.dxcc_id AS "DXCC Code",
        dxcc.name AS "Country",
        pas54.code AS "Code",
        pas54.subdivision AS "Subdivision",
        pas54.oblast AS "Oblast",
		pas54.cqzone_id AS "CQ Zone",
		pas54.ituzone_id AS "ITU Zone"
    FROM adif.pas54
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas54.dxcc_code
		JOIN adif.cqzone ON
		    adif.cqzone.cqzone_id = pas54.cqzone_id
        JOIN adif.ituzone ON
		    adif.ituzone.ituzone_id = pas54.ituzone_id
	ORDER BY adif.pas54.code;

-- 61 Franz Josef Land ---------------------------------------------------------

-- PAS-61 Table
CREATE TABLE adif.pas61
(
    pas_id SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    code CHAR(3) NOT NULL, -- three char AR, ...
    subdivision VARCHAR(120) NOT NULL,
    import_only BOOLEAN NOT NULL DEFAULT '0',
    CONSTRAINT pas61_uq UNIQUE (code,subdivision)
);

-- PAS-61 Data
\COPY adif.pas61 FROM 'adif-pas/pas61.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-61 View
CREATE OR REPLACE VIEW adif.view_pas61 AS
    SELECT
        dxcc.dxcc_id AS "DXCC Code",
        dxcc.name AS "Country",
        pas61.code AS "Code",
        pas61.subdivision AS "Subdivision",
        pas61.import_only AS "Import Only"
    FROM adif.pas61
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas61.dxcc_code
	ORDER BY adif.pas61.code;

-- 70 Cuba ---------------------------------------------------------------------

-- PAS-70 Table
CREATE TABLE adif.pas70
(
    pas70_id SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char 09, 08, 06, ...
    subdivision VARCHAR(120) NOT NULL,
    CONSTRAINT pas70_uq UNIQUE (code,subdivision)
);

-- PAS-70 Data
\COPY adif.pas70 FROM 'adif-pas/pas70.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-70 View
CREATE OR REPLACE VIEW adif.view_pas70 AS
    SELECT
        dxcc.dxcc_id AS "DXCC Code",
        dxcc.name AS "Country",
        pas70.code AS "Code",
        pas70.subdivision AS "Subdivision"
    FROM adif.pas70
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas70.dxcc_code
	ORDER BY adif.pas70.code;


-- 74 El Salvador --------------------------------------------------------------

-- PAS-74 Table
CREATE TABLE adif.pas74
(
    pas70_id SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char AH, CH, CA, ...
    subdivision VARCHAR(120) NOT NULL,
    CONSTRAINT pas74_uq UNIQUE (code,subdivision)
);

-- PAS-74 Data
\COPY adif.pas74 FROM 'adif-pas/pas74.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-74 View
CREATE OR REPLACE VIEW adif.view_pas74 AS
    SELECT
        dxcc.dxcc_id AS "DXCC Code",
        dxcc.name AS "Country",
        pas74.code AS "Code",
        pas74.subdivision AS "Subdivision"
    FROM adif.pas74
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas74.dxcc_code
	ORDER BY adif.pas74.code;

-- 86 Nicaragua ----------------------------------------------------------------

-- PAS-86 Table
CREATE TABLE adif.pas86
(
    pas86_id SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char BO, CA, CI ...
    subdivision VARCHAR(120) NOT NULL,
    CONSTRAINT pas86_uq UNIQUE (code,subdivision)
);

-- PAS-86 Data
\COPY adif.pas86 FROM 'adif-pas/pas86.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-86 View
CREATE OR REPLACE VIEW adif.view_pas86 AS
    SELECT
        dxcc.dxcc_id AS "DXCC Code",
        dxcc.name AS "Country",
        pas86.code AS "Code",
        pas86.subdivision AS "Subdivision"
    FROM adif.pas86
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas86.dxcc_code
	ORDER BY adif.pas86.code;

-- 100 Argentina ---------------------------------------------------------------

-- TODO: view_pas100
CREATE TABLE adif.pas100
(
    pas100_id SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    code CHAR(1) NOT NULL, -- one char A, B, C, ...
    subdivision VARCHAR(120) NOT NULL,
    CONSTRAINT pas100_uq UNIQUE (code,subdivision)
);

-- PAS-100 Data
\COPY adif.pas100 FROM 'adif-pas/pas100.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-100 View
CREATE OR REPLACE VIEW adif.view_pas100 AS
    SELECT
        dxcc.dxcc_id AS "DXCC Code",
        dxcc.name AS "Country",
        pas100.code AS "Code",
        pas100.subdivision AS "Subdivision"
    FROM adif.pas100
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas100.dxcc_code
	ORDER BY adif.pas100.code;


-- 104 Bolivia -----------------------------------------------------------------

-- PAS-104 Table
CREATE TABLE adif.pas104
(
    pas104_id SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    code CHAR(1) NOT NULL, -- two char A, B, C, ...
    subdivision VARCHAR(120) NOT NULL,
    CONSTRAINT pas104_uq UNIQUE (code,subdivision)
);

-- PAS-104 Data
\COPY adif.pas104 FROM 'adif-pas/pas104.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-104 View
CREATE OR REPLACE VIEW adif.view_pas104 AS
    SELECT
        dxcc.dxcc_id AS "DXCC Code",
        dxcc.name AS "Country",
        pas104.code AS "Code",
        pas104.subdivision AS "Subdivision"
    FROM adif.pas104
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas104.dxcc_code
	ORDER BY adif.pas104.code;


-- 108 Brazil ------------------------------------------------------------------

-- PAS-108 Table
CREATE TABLE adif.pas108
(
    pas108_id SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    code CHAR(2) NOT NULL, -- assuming two char ES, GO, SC, ...
    subdivision VARCHAR(120) NOT NULL,
    CONSTRAINT pas108_uq UNIQUE (code,subdivision)
);

-- PAS-108
\COPY adif.pas108 FROM 'adif-pas/pas108.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-108 View
CREATE OR REPLACE VIEW adif.view_pas108 AS
    SELECT
        dxcc.dxcc_id AS "DXCC Code",
        dxcc.name AS "Country",
        pas108.code AS "Code",
        pas108.subdivision AS "Subdivision"
    FROM adif.pas108
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas108.dxcc_code
	ORDER BY adif.pas108.code;

-- 110 Hawaii ------------------------------------------------------------------

-- PAS-110 Table
CREATE TABLE adif.pas110
(
    pas110_id SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    code CHAR(2) NOT NULL, -- assuming two char HI
    subdivision VARCHAR(120) NOT NULL,
    CONSTRAINT pas110_uq UNIQUE (code,subdivision)
);

-- PAS-110 Data
\COPY adif.pas110 FROM 'adif-pas/pas110.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-110 View
CREATE OR REPLACE VIEW adif.view_pas110 AS
    SELECT
        dxcc.dxcc_id AS "DXCC Code",
        dxcc.name AS "Country",
        pas110.code AS "Code",
        pas110.subdivision AS "Subdivision"
    FROM adif.pas110
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas110.dxcc_code
	ORDER BY adif.pas110.code;

-- 112 Chile -------------------------------------------------------------------

-- PAS-112 table
CREATE TABLE adif.pas112
(
    pas112_id SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    code CHAR(4) NOT NULL, -- four char XIII, XIV, XII, ...
    subdivision VARCHAR(120) NOT NULL,
    CONSTRAINT pas112_uq UNIQUE (code,subdivision)
);

-- PAS-112 Data
\COPY adif.pas112 FROM 'adif-pas/pas112.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-112 View
CREATE OR REPLACE VIEW adif.view_pas112 AS
    SELECT
        dxcc.dxcc_id AS "DXCC Code",
        dxcc.name AS "Country",
        pas112.code AS "Code",
        pas112.subdivision AS "Subdivision"
    FROM adif.pas112
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas112.dxcc_code
	ORDER BY adif.pas112.code;

-- 126 Kalingrad ---------------------------------------------------------------

-- NOTE: There are no multiple itu or cq zones for EU Russia
-- TODO: view_pas126
CREATE TABLE adif.pas126
(
    pas126_id SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char KA, ...
    subdivision VARCHAR(120) NOT NULL,
    oblast CHAR(3) NOT NULL, -- three char, oblast numbers are 3 digits
    cqzone_id INT NOT NULL,
    ituzone_id INT NOT NULL,
    CONSTRAINT pas126_uq UNIQUE (code,subdivision)
);

-- PAS-126 Data
\COPY adif.pas126 FROM 'adif-pas/pas126.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-126 Kalingrad
ALTER TABLE adif.pas126 ADD CONSTRAINT pas126_cqzone_fkey
    FOREIGN KEY (cqzone_id) REFERENCES adif.cqzone (cqzone_id);

ALTER TABLE adif.pas126 ADD CONSTRAINT pas126_ituzone_fkey
    FOREIGN KEY (ituzone_id) REFERENCES adif.ituzone (ituzone_id);

-- PAS-126 View
-- NOTE: There are no multiple itu or cq zones for Kalingrad. Therefore, no
--       need for it's own cqzone or ituzone tables nor aggregate's
CREATE OR REPLACE VIEW adif.view_pas126 AS
    SELECT
        dxcc.dxcc_id AS "DXCC Code",
        dxcc.name AS "Country",
        pas126.code AS "Code",
        pas126.subdivision AS "Subdivision",
        pas126.oblast AS "Oblast",
		pas126.cqzone_id AS "CQ Zone",
		pas126.ituzone_id AS "ITU Zone"
    FROM adif.pas126
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas126.dxcc_code
		JOIN adif.cqzone ON
		    adif.cqzone.cqzone_id = pas126.cqzone_id
        JOIN adif.ituzone ON
		    adif.ituzone.ituzone_id = pas126.ituzone_id
	ORDER BY adif.pas126.code;

-- 130 Kazakhstan --------------------------------------------------------------

-- PAS-130 Table
CREATE TABLE adif.pas130
(
    pas130_id SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char AA, BB, CC, ...
    subdivision VARCHAR(120) NOT NULL,
    oblast INT NOT NULL,
    CONSTRAINT pas130_uq UNIQUE (code,subdivision,oblast)
);

-- PAS-130 Data
\COPY adif.pas130 FROM 'adif-pas/pas130.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-130 View
CREATE OR REPLACE VIEW adif.view_pas130 AS
    SELECT
        dxcc.dxcc_id AS "DXCC Code",
        dxcc.name AS "Country",
        pas130.code AS "Code",
        pas130.subdivision AS "Subdivision",
        pas130.oblast AS "Oblast"
    FROM adif.pas130
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas130.dxcc_code
	ORDER BY adif.pas130.code;

-- 132 Paraguay ----------------------------------------------------------------

-- PAS-132 Table
CREATE TABLE adif.pas132
(
    pas132_id SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    code CHAR(3) NOT NULL, -- three char 16, ASU, 11 
    subdivision VARCHAR(120) NOT NULL,
    CONSTRAINT pas132_uq UNIQUE (code,subdivision)
);

-- PAS-132 Data
\COPY adif.pas132 FROM 'adif-pas/pas132.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-132 View
CREATE OR REPLACE VIEW adif.view_pas132 AS
    SELECT
        dxcc.dxcc_id AS "DXCC Code",
        dxcc.name AS "Country",
        pas132.code AS "Code",
        pas132.subdivision AS "Subdivision"
    FROM adif.pas132
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas132.dxcc_code
	ORDER BY adif.pas132.code;

-- 137 Republic of Korea -------------------------------------------------------

-- PAS-137 Table
CREATE TABLE adif.pas137
(
    pas137_id SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    code CHAR(1) NOT NULL, -- one char 1, 9, 8, ... 
    subdivision VARCHAR(120) NOT NULL,
    CONSTRAINT pas137_uq UNIQUE (code,subdivision)
);

-- PAS-137 Data
\COPY adif.pas137 FROM 'adif-pas/pas137.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-137 View
CREATE OR REPLACE VIEW adif.view_pas137 AS
    SELECT
        dxcc.dxcc_id AS "DXCC Code",
        dxcc.name AS "Country",
        pas137.code AS "Code",
        pas137.subdivision AS "Subdivision"
    FROM adif.pas137
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas137.dxcc_code
	ORDER BY adif.pas137.code;

-- 138 Kure Island -------------------------------------------------------------

-- PAS-138 Table
CREATE TABLE adif.pas138
(
    pas138_id SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char KI, ... 
    subdivision VARCHAR(120) NOT NULL,
    CONSTRAINT pas138_uq UNIQUE (code,subdivision)
);

-- PAS-138 Data
\COPY adif.pas138 FROM 'adif-pas/pas138.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-138 View
CREATE OR REPLACE VIEW adif.view_pas138 AS
    SELECT
        dxcc.dxcc_id AS "DXCC Code",
        dxcc.name AS "Country",
        pas138.code AS "Code",
        pas138.subdivision AS "Subdivision"
    FROM adif.pas138
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas138.dxcc_code
	ORDER BY adif.pas138.code;


-- 144 Uruguay -----------------------------------------------------------------

-- PAS-144 Table
CREATE TABLE adif.pas144
(
    pas144_id SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    code CHAR(2) NOT NULL, -- two two char MO, CA, SJ, ... 
    subdivision VARCHAR(120) NOT NULL,
    CONSTRAINT pas144_uq UNIQUE (code,subdivision)
);

-- PAS-144 Data
\COPY adif.pas144 FROM 'adif-pas/pas144.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-138 View
CREATE OR REPLACE VIEW adif.view_pas144 AS
    SELECT
        dxcc.dxcc_id AS "DXCC Code",
        dxcc.name AS "Country",
        pas144.code AS "Code",
        pas144.subdivision AS "Subdivision"
    FROM adif.pas144
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas144.dxcc_code
	ORDER BY adif.pas144.code;

-- 147 Lord Howe Is. -----------------------------------------------------------

-- PAS-147 Table
CREATE TABLE adif.pas147
(
    pas147_id SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char LH, ... 
    subdivision VARCHAR(120) NOT NULL,
    CONSTRAINT pas147_uq UNIQUE (code,subdivision)
);

-- PAS-147 Data
\COPY adif.pas147 FROM 'adif-pas/pas147.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-147 View
CREATE OR REPLACE VIEW adif.view_pas147 AS
    SELECT
        dxcc.dxcc_id AS "DXCC Code",
        dxcc.name AS "Country",
        pas147.code AS "Code",
        pas147.subdivision AS "Subdivision"
    FROM adif.pas147
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas147.dxcc_code
	ORDER BY adif.pas147.code;

-- 148 Venezuela ---------------------------------------------------------------

-- PAS-148 Table
CREATE TABLE adif.pas148
(
    pas148_id SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char AM, AN, AP, ... 
    subdivision VARCHAR(120) NOT NULL,
    CONSTRAINT pas148_uq UNIQUE (code,subdivision)
);

-- PAS-148 Data
\COPY adif.pas148 FROM 'adif-pas/pas148.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-148 View
CREATE OR REPLACE VIEW adif.view_pas148 AS
    SELECT
        dxcc.dxcc_id AS "DXCC Code",
        dxcc.name AS "Country",
        pas148.code AS "Code",
        pas148.subdivision AS "Subdivision"
    FROM adif.pas148
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas148.dxcc_code
	ORDER BY adif.pas148.code;

-- 149 Azores ------------------------------------------------------------------

-- PAS-149 Table
CREATE TABLE adif.pas149
(
    pas149_id SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char AC, ... 
    subdivision VARCHAR(120) NOT NULL,
    CONSTRAINT pas149_uq UNIQUE (code,subdivision)
);

-- PAS-149 Data
\COPY adif.pas149 FROM 'adif-pas/pas149.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-149 View
CREATE OR REPLACE VIEW adif.view_pas149 AS
    SELECT
        dxcc.dxcc_id AS "DXCC Code",
        dxcc.name AS "Country",
        pas149.code AS "Code",
        pas149.subdivision AS "Subdivision"
    FROM adif.pas149
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas149.dxcc_code
	ORDER BY adif.pas149.code;

-- 150 Australia ---------------------------------------------------------------

-- PAS-150 Table
CREATE TABLE adif.pas150
(
    pas150_id SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    code CHAR(3) NOT NULL, -- three char ACT, SA, NSW, ...
    subdivision VARCHAR(120) NOT NULL,
    CONSTRAINT pas150_uq UNIQUE (code,subdivision)
);

-- PAS-150 Data
\COPY adif.pas150 FROM 'adif-pas/pas150.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-149 View
CREATE OR REPLACE VIEW adif.view_pas150 AS
    SELECT
        dxcc.dxcc_id AS "DXCC Code",
        dxcc.name AS "Country",
        pas150.code AS "Code",
        pas150.subdivision AS "Subdivision"
    FROM adif.pas150
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas150.dxcc_code
	ORDER BY adif.pas150.code;

-- 151 Malyj Vysotski Is -------------------------------------------------------

-- PAS-151 Table
CREATE TABLE adif.pas151
(
    pas151_id SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char LO, MV, ...
    subdivision VARCHAR(120) NOT NULL,
    import_only BOOLEAN NOT NULL DEFAULT '0',
    CONSTRAINT pas151_uq UNIQUE (code,subdivision)
);

-- PAS-151 Data
\COPY adif.pas151 FROM 'adif-pas/pas151.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-151 View
CREATE OR REPLACE VIEW adif.view_pas151 AS
    SELECT
        dxcc.dxcc_id AS "DXCC Code",
        dxcc.name AS "Country",
        pas151.code AS "Code",
        pas151.subdivision AS "Subdivision",
        pas151.import_only AS "Import Only"
    FROM adif.pas151
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas151.dxcc_code
	ORDER BY adif.pas151.code;

-- 153 Macquarie Is. -----------------------------------------------------------

-- PAS-153 Table
CREATE TABLE adif.pas153
(
    pas153_id SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char MA, ...
    subdivision VARCHAR(120) NOT NULL,
    CONSTRAINT pas153_uq UNIQUE (code,subdivision)
);

-- PAS-153 Data
\COPY adif.pas153 FROM 'adif-pas/pas153.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-153 View
CREATE OR REPLACE VIEW adif.view_pas153 AS
    SELECT
        dxcc.dxcc_id AS "DXCC Code",
        dxcc.name AS "Country",
        pas153.code AS "Code",
        pas153.subdivision AS "Subdivision"
    FROM adif.pas153
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas153.dxcc_code
	ORDER BY adif.pas153.code;

-- 163 Papua New Guinea --------------------------------------------------------

-- PAS-163 Table
CREATE TABLE adif.pas163
(
    pas163_id SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    code CHAR(3) NOT NULL, -- three char NCD, CPM, CPK, ...
    subdivision VARCHAR(120) NOT NULL,
    CONSTRAINT pas163_uq UNIQUE (code,subdivision)
);

-- PAS-163 Data
\COPY adif.pas163 FROM 'adif-pas/pas163.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-163 View
CREATE OR REPLACE VIEW adif.view_pas163 AS
    SELECT
        dxcc.dxcc_id AS "DXCC Code",
        dxcc.name AS "Country",
        pas163.code AS "Code",
        pas163.subdivision AS "Subdivision"
    FROM adif.pas163
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas163.dxcc_code
	ORDER BY adif.pas163.code;

-- 170 New Zealand -------------------------------------------------------------

-- PAS-170 Table
CREATE TABLE adif.pas170
(
    pas170_id SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    code CHAR(3) NOT NULL, -- three char AUK, BUP, NTL, ...
    subdivision VARCHAR(120) NOT NULL,
    CONSTRAINT pas170_uq UNIQUE (code,subdivision)
);

-- PAS-170 Data
\COPY adif.pas170 FROM 'adif-pas/pas170.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-170 View
CREATE OR REPLACE VIEW adif.view_pas170 AS
    SELECT
        dxcc.dxcc_id AS "DXCC Code",
        dxcc.name AS "Country",
        pas170.code AS "Code",
        pas170.subdivision AS "Subdivision"
    FROM adif.pas170
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas170.dxcc_code
	ORDER BY adif.pas170.code;

-- 177 Minami Torishima --------------------------------------------------------

-- TODO: view_pas177
CREATE TABLE adif.pas177
(
    pas177_id SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char MT, ...
    subdivision VARCHAR(120) NOT NULL,
    CONSTRAINT pas177_uq UNIQUE (code,subdivision)
);

-- PAS-177 Data
\COPY adif.pas177 FROM 'adif-pas/pas177.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-177 View
CREATE OR REPLACE VIEW adif.view_pas177 AS
    SELECT
        dxcc.dxcc_id AS "DXCC Code",
        dxcc.name AS "Country",
        pas177.code AS "Code",
        pas177.subdivision AS "Subdivision"
    FROM adif.pas177
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas177.dxcc_code
	ORDER BY adif.pas177.code;

-- 179 Moldova -----------------------------------------------------------------

-- PAS-179 Table
CREATE TABLE adif.pas179
(
    pas179_id SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    code CHAR(3) NOT NULL, -- three char AAA, BBB, CCC, ...
    subdivision VARCHAR(120) NOT NULL,
    CONSTRAINT pas179_uq UNIQUE (code,subdivision)
);

-- PAS-179 Data
\COPY adif.pas179 FROM 'adif-pas/pas179.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-179 View
CREATE OR REPLACE VIEW adif.view_pas179 AS
    SELECT
        dxcc.dxcc_id AS "DXCC Code",
        dxcc.name AS "Country",
        pas179.code AS "Code",
        pas179.subdivision AS "Subdivision"
    FROM adif.pas179
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas179.dxcc_code
	ORDER BY adif.pas179.code;

-- 192 Ogasawara ---------------------------------------------------------------

-- PAS-192 Table
CREATE TABLE adif.pas192
(
    pas192_id SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    code CHAR(1) NOT NULL, -- one char O, ...
    subdivision VARCHAR(120) NOT NULL,
    CONSTRAINT pas192_uq UNIQUE (code,subdivision)
);

-- PAS-192 Data
\COPY adif.pas192 FROM 'adif-pas/pas192.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-192 View
CREATE OR REPLACE VIEW adif.view_pas192 AS
    SELECT
        dxcc.dxcc_id AS "DXCC Code",
        dxcc.name AS "Country",
        pas192.code AS "Code",
        pas192.subdivision AS "Subdivision"
    FROM adif.pas192
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas192.dxcc_code
	ORDER BY adif.pas192.code;

-- 206 Austria -----------------------------------------------------------------

-- PAS-206 Table Region 
CREATE TABLE adif.pas206_region
(
    pas206_region_id SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    region VARCHAR(120) NOT NULL,
    CONSTRAINT pas206_region_uq UNIQUE (region)
);

--PAS-206 Table Subdivision
-- For CSV File Conversion: IF(K2 <> "",TEXT(K2,"yyyy-mm-dd"),"")
CREATE TABLE adif.pas206_subdivision
(
    pa206_subdivision_id SERIAL PRIMARY KEY,
    pas206_region_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char AM, BL, BN, ...
    subdivision VARCHAR(120) NOT NULL,
    before_date DATE,
    CONSTRAINT pas206_subdivision_uq UNIQUE (code,subdivision)
);

-- PAS-206 Data
\COPY adif.pas206_region FROM 'adif-pas/pas206_region.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY adif.pas206_subdivision FROM 'adif-pas/pas206_subdivision.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-206 FK
ALTER TABLE adif.pas206_subdivision ADD CONSTRAINT pas206_subdivision_pas206_region_fkey
    FOREIGN KEY (pas206_region_id) REFERENCES adif.pas206_region (pas206_region_id);

-- PAS-206 View Region
CREATE OR REPLACE VIEW adif.view_pas206_region AS
    SELECT
        dxcc.dxcc_id AS "DXCC Code",
        dxcc.name AS "Country",
        pas206_region.region AS "Region"
    FROM adif.pas206_region
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas206_region.dxcc_code
    ORDER BY adif.pas206_region.region;

-- PAS-206 View Subdivision
CREATE OR REPLACE VIEW adif.view_pas206_subdivision AS
    SELECT
        pas206_region.region AS "Region",
        pas206_subdivision.code AS "Code",
        pas206_subdivision.subdivision AS "Pri. Subdivision",
        pas206_subdivision.before_date AS "Before Date"
    FROM adif.pas206_subdivision
        JOIN adif.pas206_region ON
            adif.pas206_region.pas206_region_id = pas206_subdivision.pas206_region_id
    ORDER BY pas206_region.region;

-- 209 Belgium -----------------------------------------------------------------

-- PAS-209 Table
CREATE TABLE adif.pas209
(
    pas209_id SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char AN, BR, BW, ...
    subdivision VARCHAR(120) NOT NULL,
    CONSTRAINT pas209_uq UNIQUE (code,subdivision)
);

-- PAS-209
\COPY adif.pas209 FROM 'adif-pas/pas209.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-209 View
CREATE OR REPLACE VIEW adif.view_pas209 AS
    SELECT
        dxcc.dxcc_id AS "DXCC Code",
        dxcc.name AS "Country",
        pas209.code AS "Code",
        pas209.subdivision AS "Subdivision"
    FROM adif.pas209
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas209.dxcc_code
	ORDER BY adif.pas209.code;

-- 212 Bulgaria ----------------------------------------------------------------

-- PAS-212 Table Region
CREATE TABLE adif.pas212_region
(
    pas212_region_id SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    region VARCHAR(120) NOT NULL,
    CONSTRAINT pas212_region_uq UNIQUE (region)
);

-- PAS-212 Table Subdivision
CREATE TABLE adif.pas212_subdivision
(
    pas212_subdivision_id SERIAL PRIMARY KEY,
    pas212_region_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char AM, BL, BN, ...
    subdivision VARCHAR(120) NOT NULL,
    CONSTRAINT pas212_subdivision_uq UNIQUE (code,subdivision)
);

-- PAS-212
\COPY adif.pas212_region FROM 'adif-pas/pas212_region.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY adif.pas212_subdivision FROM 'adif-pas/pas212_subdivision.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-212 FK
ALTER TABLE adif.pas212_subdivision ADD CONSTRAINT pas212_subdivision_pas212_region_fkey
    FOREIGN KEY (pas212_region_id) REFERENCES adif.pas212_region (pas212_region_id);

-- PAS-212 View Region
CREATE OR REPLACE VIEW adif.view_pas212_region AS
    SELECT
        dxcc.dxcc_id AS "DXCC Code",
        dxcc.name AS "Country",
        pas212_region.region AS "Region"
    FROM adif.pas212_region
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas212_region.dxcc_code
    ORDER BY adif.pas212_region.region;

-- PAS-212 View Subdivision
CREATE OR REPLACE VIEW adif.view_pas212_subdivision AS
    SELECT
        pas212_region.region AS "Region",
        pas212_subdivision.code AS "Code",
        pas212_subdivision.subdivision AS "Pri. Subdivision"
    FROM adif.pas212_subdivision
        JOIN adif.pas212_region ON
            adif.pas212_region.pas212_region_id = pas212_subdivision.pas212_region_id
    ORDER BY pas212_region.region;

-- 214 Corsica -----------------------------------------------------------------

-- PAS-214 Table
CREATE TABLE adif.pas214
(
    pas214_id SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char 2A, 2B, ...
    subdivision VARCHAR(120) NOT NULL,
    CONSTRAINT pas214_uq UNIQUE (code,subdivision)
);

-- PAS-214 Data
\COPY adif.pas214 FROM 'adif-pas/pas214.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-214 View
CREATE OR REPLACE VIEW adif.view_pas214 AS
    SELECT
        dxcc.dxcc_id AS "DXCC Code",
        dxcc.name AS "Country",
        pas214.code AS "Code",
        pas214.subdivision AS "Subdivision"
    FROM adif.pas214
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas214.dxcc_code
	ORDER BY adif.pas214.code;

-- 221 Denmark -----------------------------------------------------------------

-- PAS-221 Table
CREATE TABLE adif.pas221
(
    pas221_id SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    code CHAR(3) NOT NULL, -- three char 015, 025, 055, ...
    subdivision VARCHAR(120) NOT NULL,
    CONSTRAINT pas221_uq UNIQUE (code,subdivision)
);

-- PAS-221 Data
\COPY adif.pas221 FROM 'adif-pas/pas221.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-221 View
CREATE OR REPLACE VIEW adif.view_pas221 AS
    SELECT
        dxcc.dxcc_id AS "DXCC Code",
        dxcc.name AS "Country",
        pas221.code AS "Code",
        pas221.subdivision AS "Subdivision"
    FROM adif.pas221
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas221.dxcc_code
	ORDER BY adif.pas221.code;

-- 224 Finland -----------------------------------------------------------------

-- PAS-224 Table Region
CREATE TABLE adif.pas224_region
(
    pas224_region_id SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    region VARCHAR(120) NOT NULL,
    CONSTRAINT pas224_region_uq UNIQUE (region)
);

-- PAS-224 Table Subdivision
CREATE TABLE adif.pas224_subdivision
(
    pas224_subdivision_id SERIAL PRIMARY KEY,
    pas224_region_id INT NOT NULL,
    code CHAR(3) NOT NULL, -- three char 105, 106, 107, ...
    subdivision VARCHAR(120) NOT NULL,
    CONSTRAINT pas224_subdivision_uq UNIQUE (code,subdivision)
);

-- PAS-224 Data
\COPY adif.pas224_region FROM 'adif-pas/pas224_region.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY adif.pas224_subdivision FROM 'adif-pas/pas224_subdivision.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-224 FK
ALTER TABLE adif.pas224_subdivision ADD CONSTRAINT pas224_subdivision_pas224_region_fkey
    FOREIGN KEY (pas224_region_id) REFERENCES adif.pas224_region (pas224_region_id);

-- PAS-224 View Region
CREATE OR REPLACE VIEW adif.view_pas224_region AS
    SELECT
        dxcc.dxcc_id AS "DXCC Code",
        dxcc.name AS "Country",
        pas224_region.region AS "Region"
    FROM adif.pas224_region
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas224_region.dxcc_code
    ORDER BY adif.pas224_region.region;

-- PAS-224 View Subdivision
CREATE OR REPLACE VIEW adif.view_pas224_subdivision AS
    SELECT
        pas224_region.region AS "Region",
        pas224_subdivision.code AS "Code",
        pas224_subdivision.subdivision AS "Pri. Subdivision"
    FROM adif.pas224_subdivision
        JOIN adif.pas224_region ON
            adif.pas224_region.pas224_region_id = pas224_subdivision.pas224_region_id
    ORDER BY pas224_region.region;

-- 225 Sardinia ----------------------------------------------------------------

-- PAS-225 Table Region
CREATE TABLE adif.pas225_region
(
    pas225_region_id SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    region VARCHAR(120) NOT NULL,
    CONSTRAINT pas225_region_uq UNIQUE (region)
);

-- PAS-225 Table Subdivision
CREATE TABLE adif.pas225_subdivision
(
    pas225_subdivision_id SERIAL PRIMARY KEY,
    pas225_region_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char CA, CI, MD, ...
    subdivision VARCHAR(120) NOT NULL,
    import_only BOOLEAN NOT NULL DEFAULT '0',
    CONSTRAINT pas225_subdivision_uq UNIQUE (code,subdivision)
);

-- PAS-225 Data
\COPY adif.pas225_region FROM 'adif-pas/pas225_region.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY adif.pas225_subdivision FROM 'adif-pas/pas225_subdivision.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-225 FK
ALTER TABLE adif.pas225_subdivision ADD CONSTRAINT pas225_subdivision_pas225_region_fkey
    FOREIGN KEY (pas225_region_id) REFERENCES adif.pas225_region (pas225_region_id);

-- PAS-225 View Region
CREATE OR REPLACE VIEW adif.view_pas225_region AS
    SELECT
        dxcc.dxcc_id AS "DXCC Code",
        dxcc.name AS "Country",
        pas225_region.region AS "Region"
    FROM adif.pas225_region
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas225_region.dxcc_code
    ORDER BY adif.pas225_region.region;

-- PAS-225 View Subdivision
CREATE OR REPLACE VIEW adif.view_pas225_subdivision AS
    SELECT
        pas225_region.region AS "Region",
        pas225_subdivision.code AS "Code",
        pas225_subdivision.subdivision AS "Pri. Subdivision",
        pas225_subdivision.import_only AS "Import Only"
    FROM adif.pas225_subdivision
        JOIN adif.pas225_region ON
            adif.pas225_region.pas225_region_id = pas225_subdivision.pas225_region_id
    ORDER BY pas225_region.region;

-- 227 France ------------------------------------------------------------------

-- PAS-227 Table
CREATE TABLE adif.pas227
(
    pas227_id SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char 01, 02, 03, ...
    subdivision VARCHAR(120) NOT NULL,
    CONSTRAINT pas227_uq UNIQUE (code,subdivision)
);

-- PAS-227 Data
\COPY adif.pas227 FROM 'adif-pas/pas227.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-227 View
CREATE OR REPLACE VIEW adif.view_pas227 AS
    SELECT
        dxcc.dxcc_id AS "DXCC Code",
        dxcc.name AS "Country",
        pas227.code AS "Code",
        pas227.subdivision AS "Subdivision"
    FROM adif.pas227
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas227.dxcc_code
	ORDER BY adif.pas227.code;

-- 230 Fed. Rep. of Germany ----------------------------------------------------

-- PAS-230 Table
CREATE TABLE adif.pas230
(
    pas230_id SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    code CHAR(2) NOT NULL, -- assuming two char BB, BW, BW, ...
    subdivision VARCHAR(120) NOT NULL,
    CONSTRAINT pas230_uq UNIQUE (code,subdivision)
);

-- PAS-230 Data
\COPY adif.pas230 FROM 'adif-pas/pas230.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-230 View
CREATE OR REPLACE VIEW adif.view_pas230 AS
    SELECT
        dxcc.dxcc_id AS "DXCC Code",
        dxcc.name AS "Country",
        pas230.code AS "Code",
        pas230.subdivision AS "Subdivision"
    FROM adif.pas230
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas230.dxcc_code
	ORDER BY adif.pas230.code;

-- 239 Hungary -----------------------------------------------------------------

-- PAS-239
CREATE TABLE adif.pas239
(
    pas239_id SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    code CHAR(2) NOT NULL, -- assuming two char GY, VA, ZA, ...
    subdivision VARCHAR(120) NOT NULL,
    CONSTRAINT pas239_uq UNIQUE (code,subdivision)
);

-- PAS-239 Data
\COPY adif.pas239 FROM 'adif-pas/pas239.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-230 View
CREATE OR REPLACE VIEW adif.view_pas239 AS
    SELECT
        dxcc.dxcc_id AS "DXCC Code",
        dxcc.name AS "Country",
        pas239.code AS "Code",
        pas239.subdivision AS "Subdivision"
    FROM adif.pas239
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas239.dxcc_code
	ORDER BY adif.pas239.code;

-- 245 Ireland -----------------------------------------------------------------

-- PAS-245 Table
CREATE TABLE adif.pas245
(
    pas245_id SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    code CHAR(2) NOT NULL, -- assuming two char CW, CN, CE, ...
    subdivision VARCHAR(120) NOT NULL,
    CONSTRAINT pas245_uq UNIQUE (code,subdivision)
);

-- PAS-245 Data
\COPY adif.pas245 FROM 'adif-pas/pas245.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-230 View
CREATE OR REPLACE VIEW adif.view_pas245 AS
    SELECT
        dxcc.dxcc_id AS "DXCC Code",
        dxcc.name AS "Country",
        pas245.code AS "Code",
        pas245.subdivision AS "Subdivision"
    FROM adif.pas245
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas245.dxcc_code
	ORDER BY adif.pas245.code;

-- 248 Italy -------------------------------------------------------------------

-- NOTE: Italy has Regions and Subdivisions
-- NOTE: Italy has multiple Import Only Subdivisions

-- PAS-248 Table Region
CREATE TABLE adif.pas248_region
(
    pas248_region_id SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    region VARCHAR(120) NOT NULL,
    CONSTRAINT pas248_region_uq UNIQUE (region)
);

-- PAS-248 Table Subdivision
CREATE TABLE adif.pas248_subdivision
(
    pas248_subdivision_id SERIAL PRIMARY KEY,
    pas248_region_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- assuming two char BO, FE, FO, ...
    subdivision VARCHAR(120) NOT NULL,
    import_only BOOLEAN NOT NULL DEFAULT '0',
    CONSTRAINT pas248_subdivision_uq UNIQUE (pas248_region_id,code,subdivision)
);

-- PAS-248 Data
\COPY adif.pas248_region FROM 'adif-pas/pas248_region.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY adif.pas248_subdivision FROM 'adif-pas/pas248_subdivision.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-248 FK
ALTER TABLE adif.pas248_subdivision ADD CONSTRAINT pas248_subdivision_pas248_region_fkey
    FOREIGN KEY (pas248_region_id) REFERENCES adif.pas248_region (pas248_region_id);


-- PAS-248 View Region
CREATE OR REPLACE VIEW adif.view_pas248_region AS
    SELECT
        dxcc.dxcc_id AS "DXCC Code",
        dxcc.name AS "Country",
        pas248_region.region AS "Region"
    FROM adif.pas248_region
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas248_region.dxcc_code
    ORDER BY adif.pas248_region.region;

-- PAS-225 View Subdivision
CREATE OR REPLACE VIEW adif.view_pas248_subdivision AS
    SELECT
        pas248_region.region AS "Region",
        pas248_subdivision.code AS "Code",
        pas248_subdivision.subdivision AS "Pri. Subdivision",
        pas248_subdivision.import_only AS "Import Only"
    FROM adif.pas248_subdivision
        JOIN adif.pas248_region ON
            adif.pas248_region.pas248_region_id = pas248_subdivision.pas248_region_id
    ORDER BY pas248_region.region;

-- 256 Maderia Is. -------------------------------------------------------------

-- TPAS-256 Table
CREATE TABLE adif.pas256
(
    pas256_id SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    code CHAR(2) NOT NULL, -- assuming two char MD, ...
    subdivision VARCHAR(120) NOT NULL,
    CONSTRAINT pas256_uq UNIQUE (code,subdivision)
);

-- PAS-256 Data
\COPY adif.pas256 FROM 'adif-pas/pas256.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-256 View
CREATE OR REPLACE VIEW adif.view_pas256 AS
    SELECT
        dxcc.dxcc_id AS "DXCC Code",
        dxcc.name AS "Country",
        pas256.code AS "Code",
        pas256.subdivision AS "Subdivision"
    FROM adif.pas256
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas256.dxcc_code
	ORDER BY adif.pas256.code;

-- 263 Netherlands -------------------------------------------------------------

-- PAS-263 Table
CREATE TABLE adif.pas263
(
    pas263_id SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char DR, FR, GR, ...
    subdivision VARCHAR(120) NOT NULL,
    CONSTRAINT pas263_uq UNIQUE (code,subdivision)
);

-- PAS-263 Data
\COPY adif.pas263 FROM 'adif-pas/pas263.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-263 View
CREATE OR REPLACE VIEW adif.view_pas263 AS
    SELECT
        dxcc.dxcc_id AS "DXCC Code",
        dxcc.name AS "Country",
        pas263.code AS "Code",
        pas263.subdivision AS "Subdivision"
    FROM adif.pas263
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas263.dxcc_code
	ORDER BY adif.pas263.code;

-- 269 Poland ------------------------------------------------------------------

-- PAS-269 Table
CREATE TABLE adif.pas269
(
    pas269_id SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    code CHAR(1) NOT NULL, -- one char Z, F, P, ...
    subdivision VARCHAR(120) NOT NULL,
    CONSTRAINT pas269_uq UNIQUE (code,subdivision)
);

-- PAS-269 Data
\COPY adif.pas269 FROM 'adif-pas/pas269.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-269 View
CREATE OR REPLACE VIEW adif.view_pas269 AS
    SELECT
        dxcc.dxcc_id AS "DXCC Code",
        dxcc.name AS "Country",
        pas269.code AS "Code",
        pas269.subdivision AS "Subdivision"
    FROM adif.pas269
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas269.dxcc_code
	ORDER BY adif.pas269.code;

-- 272 Portugal ----------------------------------------------------------------

-- PAS-272 Table
CREATE TABLE adif.pas272
(
    pas272_id SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char AV, BJ, BR, ...
    subdivision VARCHAR(120) NOT NULL,
    CONSTRAINT pas272_uq UNIQUE (code,subdivision)
);

-- PAS-272 Data
\COPY adif.pas272 FROM 'adif-pas/pas272.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-272 View
CREATE OR REPLACE VIEW adif.view_pas272 AS
    SELECT
        dxcc.dxcc_id AS "DXCC Code",
        dxcc.name AS "Country",
        pas272.code AS "Code",
        pas272.subdivision AS "Subdivision"
    FROM adif.pas272
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas272.dxcc_code
	ORDER BY adif.pas272.code;

-- 275 Romania -----------------------------------------------------------------

-- PAS-275 Table
CREATE TABLE adif.pas275
(
    pas275_id SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char AR, CS, HD, ...
    subdivision VARCHAR(120) NOT NULL,
    CONSTRAINT pas275_uq UNIQUE (code,subdivision)
);

-- PAS-275 Data
\COPY adif.pas275 FROM 'adif-pas/pas275.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-275 View
CREATE OR REPLACE VIEW adif.view_pas275 AS
    SELECT
        dxcc.dxcc_id AS "DXCC Code",
        dxcc.name AS "Country",
        pas275.code AS "Code",
        pas275.subdivision AS "Subdivision"
    FROM adif.pas275
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas275.dxcc_code
	ORDER BY adif.pas275.code;

-- 281 Spain -------------------------------------------------------------------

-- PAS-281 Table
CREATE TABLE adif.pas281
(
    pas281_id SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char AV, BU, C, ...
    subdivision VARCHAR(120) NOT NULL,
    CONSTRAINT pas281_uq UNIQUE (code,subdivision)
);

-- PAS-281 Data
\COPY adif.pas281 FROM 'adif-pas/pas281.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-281 View
CREATE OR REPLACE VIEW adif.view_pas281 AS
    SELECT
        dxcc.dxcc_id AS "DXCC Code",
        dxcc.name AS "Country",
        pas281.code AS "Code",
        pas281.subdivision AS "Subdivision"
    FROM adif.pas281
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas281.dxcc_code
	ORDER BY adif.pas281.code;

-- 284 Sweden ------------------------------------------------------------------

-- PAS-284 Table
CREATE TABLE adif.pas284
(
    pas284_id SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char AB, I, BD, ...
    subdivision VARCHAR(120) NOT NULL,
    CONSTRAINT pas284_uq UNIQUE (code,subdivision)
);

-- PAS-284 Data
\COPY adif.pas284 FROM 'adif-pas/pas284.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-284 View
CREATE OR REPLACE VIEW adif.view_pas284 AS
    SELECT
        dxcc.dxcc_id AS "DXCC Code",
        dxcc.name AS "Country",
        pas284.code AS "Code",
        pas284.subdivision AS "Subdivision"
    FROM adif.pas284
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas284.dxcc_code
	ORDER BY adif.pas284.code;

-- 287 Switzerland -------------------------------------------------------------

-- PAS-287 Table
CREATE TABLE adif.pas287
(
    pas287_idid SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char AG, AR, AI, ...
    subdivision VARCHAR(120) NOT NULL,
    CONSTRAINT pas287_uq UNIQUE (code,subdivision)
);

-- PAS-287 Data
\COPY adif.pas287 FROM 'adif-pas/pas287.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-287 View
CREATE OR REPLACE VIEW adif.view_pas287 AS
    SELECT
        dxcc.dxcc_id AS "DXCC Code",
        dxcc.name AS "Country",
        pas287.code AS "Code",
        pas287.subdivision AS "Subdivision"
    FROM adif.pas287
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas287.dxcc_code
	ORDER BY adif.pas287.code;

-- 288 Ukraine -----------------------------------------------------------------

-- PAS-288 Table
CREATE TABLE adif.pas288
(
    pas288_id SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char SU, TE, CH, ...
    subdivision VARCHAR(120) NOT NULL,
    CONSTRAINT pas288_uq UNIQUE (code,subdivision)
);

-- PAS-288 Data
\COPY adif.pas288 FROM 'adif-pas/pas288.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

CREATE OR REPLACE VIEW adif.view_pas288 AS
    SELECT
        dxcc.dxcc_id AS "DXCC Code",
        dxcc.name AS "Country",
        pas288.code AS "Code",
        pas288.subdivision AS "Subdivision"
    FROM adif.pas288
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas288.dxcc_code
	ORDER BY adif.pas288.code;

-- 291 United States -----------------------------------------------------------

-- TODO: view_pas291
CREATE TABLE adif.pas291
(
    pas291_id SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    code CHAR(3) NOT NULL, -- two letter state code
    subdivision VARCHAR(120) NOT NULL, -- state name
    CONSTRAINT pas291_uq UNIQUE (code,subdivision)
);

-- PAS-291 CQ Zone
CREATE TABLE adif.pas291_cqzone
(
    pas291_cqzone_id SERIAL PRIMARY KEY,
    pas291_id INT NOT NULL,
    cqzone_id INT NOT NULL
);

-- PAS-291 ITU Zone
CREATE TABLE adif.pas291_ituzone
(
    pas291_ituzone_id SERIAL PRIMARY KEY,
    pas291_id INT NOT NULL,
    ituzone_id INT NOT NULL
);

-- PAS-291 Data
\COPY adif.pas291 FROM 'adif-pas/pas291.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY adif.pas291_cqzone FROM 'adif-pas/pas291_cqzone.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY adif.pas291_ituzone FROM 'adif-pas/pas291_ituzone.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-291 FK's 
ALTER TABLE adif.pas291_cqzone ADD CONSTRAINT pas291_cqzone_pas291_fkey
    FOREIGN KEY (pas291_id) REFERENCES adif.pas291 (pas291_id);

ALTER TABLE adif.pas291_cqzone ADD CONSTRAINT pas291_cqzone_cqzone_fkey
    FOREIGN KEY (cqzone_id) REFERENCES adif.cqzone (cqzone_id);

ALTER TABLE adif.pas291_ituzone ADD CONSTRAINT pas291_ituzone_pas291_fkey
    FOREIGN KEY (pas291_id) REFERENCES adif.pas291 (pas291_id);

ALTER TABLE adif.pas291_ituzone ADD CONSTRAINT pas291_ituzone_ituzone_fkey
    FOREIGN KEY (ituzone_id) REFERENCES adif.ituzone (ituzone_id);

-- PAS-291 View
CREATE OR REPLACE VIEW adif.view_pas291 AS
    SELECT
        dxcc.dxcc_id AS "DXCC Code",
        dxcc.name AS "Country",
        pas291.code AS "Code",
        pas291.subdivision AS "Subdivision",
		STRING_AGG(DISTINCT pas291_cqzone.cqzone_id::text,', ') AS "CQ Zone",
		STRING_AGG(DISTINCT pas291_ituzone.ituzone_id::text,', ') AS "ITU Zone"
    FROM adif.pas291
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas291.dxcc_code
		JOIN adif.pas291_cqzone ON
		    adif.pas291_cqzone.pas291_id = pas291.pas291_id
		JOIN adif.pas291_ituzone ON
		    adif.pas291_ituzone.pas291_id = pas291.pas291_id
	GROUP BY dxcc.dxcc_id, pas291.code, pas291.subdivision
	ORDER BY adif.pas291.code;

-- 318 China -------------------------------------------------------------------

-- TODO: view_pas287
CREATE TABLE adif.pas318
(
    pas318_id SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char AH, BJ, CQ, ...
    subdivision VARCHAR(120) NOT NULL,
    CONSTRAINT pas318_uq UNIQUE (code,subdivision)
);

-- PAS-318 Data
\COPY adif.pas318 FROM 'adif-pas/pas318.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-318 View
CREATE OR REPLACE VIEW adif.view_pas318 AS
    SELECT
        dxcc.dxcc_id AS "DXCC Code",
        dxcc.name AS "Country",
        pas318.code AS "Code",
        pas318.subdivision AS "Subdivision"
    FROM adif.pas318
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas318.dxcc_code
	ORDER BY adif.pas318.code;


-- *****************************************************************************
-- Add Schema Informaiton
-- *****************************************************************************

INSERT INTO schema_info(schema_name, schema_version, adif_spec, last_update)
VALUES(:'name', :'ver', :'adifv', CURRENT_TIMESTAMP)
ON CONFLICT (schema_name) DO UPDATE SET schema_version = :'ver',
                                        adif_spec = :'adifv',
                                        last_update = CURRENT_TIMESTAMP;

CREATE OR REPLACE VIEW view_schema_info AS
    SELECT
        schema_info.schema_name AS "Schema Name",
        schema_info.schema_version AS "Schema Version",
        schema_info.adif_spec AS "ADIF Spec",
        date_trunc('second', schema_info.last_update::TIMESTAMP) AS "Create Date"
    FROM schema_info
    ORDER BY  schema_info.schema_name;

\echo
--SELECT * FROM view_schema_info WHERE view_schema_info."Schema Name" = :'name';
