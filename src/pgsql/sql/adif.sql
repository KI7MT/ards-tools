/* 

    Project .............: Amateur Radio Data Serivce
    Author ..............: Greg, Beam, KI7MT, <ki7mt@yahoo.com>
    Copyright ...........: Copyright (C) 2018 Greg Beam, KI7MT
    License .............: GPL-3

    File ................: adif.sql
    Description .........: Enumeration Tables for R-DaaS Project
    Database Type .......: PostgreSQL v10 or later
    Version .............: 0.0.1
    ADIF Specification ..: 3.0.9
    ADIF Refrence .......: http://www.adif.org/309/ADIF_309.htm#Enumerations
    Bug Reports .........: https://github.com/KI7MT/radio-data-service/issues'

    Comments
    
        This schema implements section III.B of the Amateur Data Interchange
        Format (ADIF) in a 3NF normalized fashion (or close to it). The intent
        is to keep the data-set static and in sync with specification revisions.
        Users should refrain from modifying the data directly unless you are
        willing to accept the deviation from the spec.

    Tool Requirments:

        * PostgreSQL v10 or above
        * git for cloning the repository
        * adif uses the default database (postgres) and password (postgres)
          If you want to use a different Role / DB, adjust the commands as needed.

    Installation
    
        * Clone the repository

            git clone https://github.com/KI7MT/radio-data-service.git
        
        * Change directories and run the sql script

            cd radio-data-service\ards-pgsql\src\pgsql\sql

            psql -v ON_ERROR_STOP=1 -U postgres -f adif.sql

    Development Activity and Coding

        Suffix Annotations
        _uq     = Unique Constraint
        _pkey   = Primary Key
        _fkey   = Foreign Key

        TODO: adif.oblast will need an FK for PSA or SAS before its functional.
        TODO: adif.pas and adif.sas CSV files for data entry
        TODO: Add adif.sas FK's after adif.pas has been populated.

*/

-- *****************************************************************************
--  BEGIN SCHEMA CREATION
-- *****************************************************************************

\echo ''
\echo '---------------------------'
\echo 'Creating ADIF Schema'
\echo '---------------------------'

-- Drop, and re-create schema
DROP SCHEMA IF EXISTS adif CASCADE;

\echo ''
\echo '==========================='
\echo 'Creating Schema adif'
\echo '==========================='

-- Create New Schema
CREATE SCHEMA adif;

--ADIF Informaiton Table
CREATE TABLE adif.database_info
(
    id INT PRIMARY KEY,
    author VARCHAR (20),
    db_version VARCHAR(10),
    adif_spec VARCHAR(10),
    last_update TIMESTAMP DEFAULT NOW() 
);

INSERT INTO adif.database_info (id, author, db_version, adif_spec, last_update)
VALUES(1, 'Greg Beam', '1.0.0', '3.0.9', CURRENT_TIMESTAMP);

-- *****************************************************************************
--  BEGIN TABLE CREATION
-- *****************************************************************************

\echo ''
\echo '==========================='
\echo 'Creating Tables'
\echo '==========================='

-- Antenna Path
CREATE TABLE adif.antenna_path
(
    id SERIAL PRIMARY KEY,
    abbreviation VARCHAR(1) NOT NULL,
    meaning VARCHAR(15) NOT NULL,
    CONSTRAINT antenna_path_uq UNIQUE (abbreviation, meaning)
);

-- Award
CREATE TABLE adif.award
(
    id SERIAL PRIMARY KEY,
    name VARCHAR(15),
    import_only BOOLEAN NOT NULL DEFAULT '1',
    CONSTRAINT award_name_uq UNIQUE (name)
);

-- ARRL Section
-- FK => dxcc_entity_fkey REFERENCEES adif.dxcc_entity (id)
CREATE TABLE adif.arrl_section
(
    id SERIAL PRIMARY KEY,
    abbreviation VARCHAR(4) NOT NULL,
    name VARCHAR(70) NOT NULL,
    dxcc_entity_id INT NOT NULL,
    from_date date,
    deleted_date date
);

-- Band
CREATE TABLE adif.band
(
    id SERIAL PRIMARY KEY,
    name VARCHAR(6) NOT NULL,
    lower_freq NUMERIC NOT NULL,
    upper_freq NUMERIC NOT NULL,
    CONSTRAINT band_name_uq UNIQUE (name)
);

-- Contest
CREATE TABLE adif.contest
(
    id SERIAL PRIMARY KEY,
    name VARCHAR(60),
    description VARCHAR(120),
    import_only BOOLEAN NOT NULL DEFAULT '0',
    weblink_id INT,
    CONSTRAINT contest_name_uq UNIQUE (name)
);

-- Continent
CREATE TABLE adif.continent
(
    id SERIAL PRIMARY KEY,
    abbreviation VARCHAR(2),
    name VARCHAR(14),
    CONSTRAINT continent_name_uq UNIQUE (abbreviation, name)
);

-- Credit Sponsor
CREATE TABLE adif.credit_sponsor
(
    id SERIAL PRIMARY KEY,
    name VARCHAR(20),
    CONSTRAINT credit_sponsor_name_uq UNIQUE (name)
);

-- Credit Award
CREATE TABLE adif.credit_award
(
    id SERIAL PRIMARY KEY,
    name VARCHAR(60),
    CONSTRAINT credit_award_name_uq UNIQUE (name)
);

-- Credit Facet
CREATE TABLE adif.credit_facet
(
    id SERIAL PRIMARY KEY,
    name VARCHAR(20),
    CONSTRAINT credit_facet_name_uq UNIQUE (name)
);

-- Credit
-- FK => credit_sponsor_fkey REFERENCE adif.credit_sponsor (id)
-- FK => credit_award_fkey REFERENCE adif.credit_award (id)
-- FK => credit_facetPfkey REFERENCE adif.credit_facet (id)
CREATE TABLE adif.credit
(
    id SERIAL PRIMARY KEY,
    credit_for VARCHAR(24) NOT NULL,
    sponsor_id INT NOT NULL,
    award_id INT NOT NULL,
    facet_id INT NOT NULL,
CONSTRAINT credit_for_uq UNIQUE (credit_for)
);

-- DXCC Entities
-- id is a natureal PK as it matches dscc_entity_id
CREATE TABLE adif.dxcc_entity
(
    id INT PRIMARY KEY,
    code VARCHAR(4) NOT NULL,
    name VARCHAR(90) NOT NULL,
    is_deleted BOOLEAN DEFAULT '0',
    CONSTRAINT dxcc_entity_name_uq UNIQUE (code, name)
);

-- State
CREATE TABLE adif.state
(
    id SERIAL PRIMARY KEY,
    abbreviation VARCHAR(2) NOT NULL,
    name VARCHAR(20) NOT NULL,
    CONSTRAINT state_uq UNIQUE (abbreviation, name)
);

-- County
CREATE TABLE adif.county_name
(
    id SERIAL PRIMARY KEY,
    name VARCHAR(60) NOT NULL,
    CONSTRAINT county_name_uq UNIQUE (name)
);

-- State County Many-To-Many
-- FK => state_county_state_fkey REFERENCE adif.state (id)
-- FK => state_county_county_name_fkey REFERENCE adif.county_name (id)
CREATE TABLE adif.state_county
(
    id SERIAL PRIMARY KEY,
    state_id INT NOT NULL,
    county_name_id INT NOT NULL
);

-- Mode
-- FK => mode_mode_description REFERENCEES adif.mode_description (id)
CREATE TABLE adif.mode
(
    id SERIAL PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    mode_description_id INT,
    import_only BOOLEAN NOT NULL DEFAULT '0',
    CONSTRAINT mode_name_uq UNIQUE (name)
);

-- Submode One-To-Many
-- FK => submode_mode REFERENCES adif.mode (id)
-- FK => subode_mode_description_fkey REFERENCE adif.mode_description (id)
CREATE TABLE adif.submode
(
    id SERIAL PRIMARY KEY,
    mode_id INT NOT NULL,
    name VARCHAR(20) NOT NULL,
    mode_description_id INT,
    CONSTRAINT submode_name_uq UNIQUE (name)
);

-- Mode Description
CREATE TABLE adif.mode_description
(
    id SERIAL PRIMARY KEY,
    description VARCHAR(120) NOT NULL
);

-- CQ Zone
-- PK id is the same as the cqzone_number = No SERIAL, use INT
CREATE TABLE adif.cq_zone
(
    id INT PRIMARY KEY,
    short_description VARCHAR(60) NOT NULL,
    long_description VARCHAR NOT NULL,
    weblink_id INT
);

-- ITU Zone
-- PK id is the same ans the itu_zone_number = No SERIAL, use INT
CREATE TABLE adif.itu_zone
(
    id INT PRIMARY KEY,
    number INT NOT NULL,
    short_description VARCHAR(120),
    long_description VARCHAR (255),
    weblink_id INT,
    CONSTRAINT itu_zone_number_uq UNIQUE (number)
);

-- Oblast
-- TO-DO: adif.oblast will need an FK for PSA or SAS before its functional.
CREATE TABLE adif.oblast
(
    id SERIAL PRIMARY KEY,
    code VARCHAR(10) NOT NULL,
    name VARCHAR(120) NOT NULL,
    is_deleted BOOLEAN NOT NULL DEFAULT '0',
    comment VARCHAR(120) NOT NULL,
    CONSTRAINT oblast_code_uq UNIQUE (code)
);

-- Propogation
CREATE TABLE adif.propogation_mode
(
    id SERIAL PRIMARY KEY,
    enumeration VARCHAR(20) NOT NULL,
    description VARCHAR(120) NOT NULL,
    CONSTRAINT propogation_mode_abbreviation_uq UNIQUE (enumeration)
);

-- Primary Administrative Subdivision
-- FK pas_dxcc_entity_fkey REFERENCE adif.dxcc_entity (id)
CREATE TABLE adif.pas
(
    id SERIAL PRIMARY KEY,
    dxcc_entity_id INT NOT NULL,
    code VARCHAR(10) NOT NULL,
    subdivision VARCHAR(80) NOT NULL,
    CONSTRAINT pas_code_uq UNIQUE (code)
);

-- Secondary Administrative Subdivision
-- FK_sas_pas_id REFERENCE adif.pas (id) 
CREATE TABLE adif.sas
(
    id SERIAL PRIMARY KEY,
    name VARCHAR(80) NOT NULL,
    pas_id INT NOT NULL,
    CONSTRAINT sas_name_uq UNIQUE (name)
);

-- QSL Medium
CREATE TABLE adif.qsl_medium
(
    id SERIAL PRIMARY KEY,
    medium VARCHAR(10) NOT NULL,
    description VARCHAR(120) NOT NULL,
    CONSTRAINT qsl_medium_uq UNIQUE (medium)
);

-- QSL Recieved
CREATE TABLE adif.qsl_rcvd
(
    id SERIAL PRIMARY KEY,
    status VARCHAR(1) NOT NULL,
    meaning VARCHAR(20) NOT NULL,
    import_only BOOLEAN NOT NULL DEFAULT '0',
    description VARCHAR(255),
    CONSTRAINT qsl_rcvd_status_uq UNIQUE (status)
);

-- QSL Sent
CREATE TABLE adif.qsl_sent
(
    id SERIAL PRIMARY KEY,
    status VARCHAR(1) NOT NULL,
    meaning VARCHAR(20) NOT NULL,
    description VARCHAR(255),
    CONSTRAINT qsl_sent_status_uq UNIQUE (status)
);

-- QSL Via
CREATE TABLE adif.qsl_via
(
    id SERIAL PRIMARY KEY,
    via VARCHAR(1) NOT NULL,
    description VARCHAR(20) NOT NULL,
    import_only BOOLEAN NOT NULL DEFAULT '0',
    CONSTRAINT qsl_via_uq UNIQUE (via)
);

-- QSO Complete
CREATE TABLE adif.qso_complete
(
    id SERIAL PRIMARY KEY,
    abbreviation VARCHAR(5) NOT NULL,
    meaning VARCHAR(20) NOT NULL,
    CONSTRAINT qso_complete_abbreviation_uq UNIQUE (abbreviation)
);

-- QSO Upload Status
CREATE TABLE adif.qso_upload_status
(
    id SERIAL PRIMARY KEY,
    abbreviaiton VARCHAR(1) NOT NULL,
    description VARCHAR(120) NOT NULL,
    CONSTRAINT qso_upload_status_abbreviation_uq UNIQUE (abbreviaiton)
);

-- Region
CREATE TABLE adif.region
(
    id SERIAL PRIMARY KEY,
    code VARCHAR(4),
    dxcc_entity_id INT,
    region VARCHAR(120),
    prefix VARCHAR(10),
    CONSTRAINT region_code_uq UNIQUE (code)
);

-- Region Applicability 
CREATE TABLE adif.region_applicability
(
    id SERIAL PRIMARY KEY,
    region_id INT NOT NULL,
    weblink_id INT NOT NULL
);

-- Web Link Section
CREATE TABLE adif.weblink
(
    id SERIAL PRIMARY KEY,
    display_text VARCHAR(120) NOT NULL,
    url VARCHAR(255) NOT NULL,
    CONSTRAINT weblink_display_text_uq UNIQUE (display_text)
);

-- Sponsored Award
CREATE TABLE adif.sponsored_award
(
    id SERIAL PRIMARY KEY,
    sponsor VARCHAR(20) NOT NULL,
    weblink_id INT NOT NULL,
    CONSTRAINT qso_sponsored_award_sponsor_uq UNIQUE (sponsor)
);

-- *****************************************************************************
--  LOTW, EQSL, JTALERTS DATA MODELS
-- *****************************************************************************

-- NOTES: These models are part of the main installation to facilitate
--        generating the R-DaaS API and WebMVC. They are duplicates
--        from the sql scripts residing in .\lotw .\eqsl and .\jtalert.
--        CSV data import is through their individual sql scripts.

-- LoTW Active Users Model
CREATE TABLE adif.lotw_activity
(
    callsign TEXT NOT NULL,
    last_update DATE NOT NULL,
    last_time TIME NOT NULL,
    CONSTRAINT lotw_activity_callsign_pkey PRIMARY KEY (callsign)
);

-- eSQL Data Model
CREATE TABLE adif.eqsl_ag_list
(
    id SERIAL PRIMARY KEY,
    callsign TEXT NOT NULL
);

-- JTAlerts Data Model
CREATE TABLE adif.jtalert_data
(
    call VARCHAR(20),
    state VARCHAR(4),
    lotw BOOLEAN,
    eqsl BOOLEAN,
    lotw_date DATE,
    CONSTRAINT jtalert_data_pkey PRIMARY KEY (call)
);

-- *****************************************************************************
--  ADD CSV DATA
-- *****************************************************************************

-- NOTE(s): 
--  1. Delimiter for dxc_entity is "|" due to comma's in 'name' column
--  2. All other CSV files use ',' delimiters with double-quote escapes

\echo ''
\echo '---------------------------'
\echo 'Importing CSV Files'
\echo '---------------------------'
\COPY adif.antenna_path FROM 'adif/antenna_path.csv' DELIMITER ',' QUOTE '"' HEADER CSV;
\COPY adif.arrl_section FROM 'adif/arrl_section.csv' DELIMITER ',' QUOTE '"' HEADER CSV;
\COPY adif.award FROM 'adif/award.csv' DELIMITER ',' QUOTE '"' HEADER CSV;
\COPY adif.band FROM 'adif/band.csv' DELIMITER ',' QUOTE '"' HEADER CSV;
\COPY adif.contest FROM 'adif/contest.csv' DELIMITER ',' QUOTE '"' HEADER CSV;
\COPY adif.continent FROM 'adif/continent.csv' DELIMITER ',' QUOTE '"' HEADER CSV;
\COPY adif.county_name FROM 'adif/county_name.csv' DELIMITER ',' QUOTE '"' HEADER CSV;
\COPY adif.credit FROM 'adif/credit.csv' DELIMITER ',' QUOTE '"' HEADER CSV;
\COPY adif.credit_award FROM 'adif/credit_award.csv' DELIMITER ',' QUOTE '"' HEADER CSV;
\COPY adif.credit_facet FROM 'adif/credit_facet.csv' DELIMITER ',' QUOTE '"' HEADER CSV;
\COPY adif.credit_sponsor FROM 'adif/credit_sponsor.csv' DELIMITER ',' QUOTE '"' HEADER CSV;
\COPY adif.dxcc_entity FROM 'adif/dxcc_entity.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY adif.state FROM 'adif/state.csv' DELIMITER ',' QUOTE '"' HEADER CSV;
\COPY adif.state_county FROM 'adif/state_county.csv' DELIMITER ',' QUOTE '"' HEADER CSV;
\COPY adif.mode FROM 'adif/mode.csv' DELIMITER ',' QUOTE '"' HEADER CSV;
\COPY adif.submode FROM 'adif/submode.csv' DELIMITER ',' QUOTE '"' HEADER CSV;
\COPY adif.propogation_mode FROM 'adif/propogation_mode.csv' DELIMITER ',' QUOTE '"' HEADER CSV;
\COPY adif.qsl_medium FROM 'adif/qsl_medium.csv' DELIMITER ',' QUOTE '"' HEADER CSV;
\COPY adif.qsl_rcvd FROM 'adif/qsl_rcvd.csv' DELIMITER ',' QUOTE '"' HEADER CSV;
\COPY adif.qsl_sent FROM 'adif/qsl_sent.csv' DELIMITER ',' QUOTE '"' HEADER CSV;
\COPY adif.qsl_via FROM 'adif/qsl_via.csv' DELIMITER ',' QUOTE '"' HEADER CSV;
\COPY adif.qso_complete FROM 'adif/qsl_complete.csv' DELIMITER ',' QUOTE '"' HEADER CSV;
\COPY adif.qso_upload_status FROM 'adif/qso_upload_status.csv' DELIMITER ',' QUOTE '"' HEADER CSV;
\COPY adif.region FROM 'adif/region.csv' DELIMITER ',' QUOTE '"' HEADER CSV;
\COPY adif.region_applicability FROM 'adif/region_applicability.csv' DELIMITER ',' QUOTE '"' HEADER CSV;
\COPY adif.weblink FROM 'adif/weblink.csv' DELIMITER ',' QUOTE '"' HEADER CSV;
\COPY adif.sponsored_award FROM 'adif/sponsored_award.csv' DELIMITER ',' QUOTE '"' HEADER CSV;
\COPY adif.cq_zone FROM 'adif/cq_zone.csv' DELIMITER ',' QUOTE '"' HEADER CSV;

-- *****************************************************************************
--  ADD FOREIGN KEYS
-- *****************************************************************************

\echo ''
\echo '---------------------------'
\echo 'Adding Foreign Keys'
\echo '---------------------------'

ALTER TABLE adif.arrl_section ADD CONSTRAINT arrl_section_dxcc_entity_fkey
    FOREIGN KEY (dxcc_entity_id) REFERENCES adif.dxcc_entity (id);

ALTER TABLE adif.contest ADD CONSTRAINT contest_weblink_fkey
    FOREIGN KEY (weblink_id) REFERENCES adif.weblink (id);

ALTER TABLE adif.credit ADD CONSTRAINT credit_credit_sponsor_fkey
    FOREIGN KEY (sponsor_id) REFERENCES adif.credit_sponsor (id);

ALTER TABLE adif.credit ADD CONSTRAINT credit_credit_award_fkey
    FOREIGN KEY (award_id) REFERENCES adif.credit_award (id);

ALTER TABLE adif.credit ADD CONSTRAINT credit_credit_facet_fkey
    FOREIGN KEY (facet_id) REFERENCES adif.credit_facet (id);

ALTER TABLE adif.state_county ADD CONSTRAINT state_county_state_fkey
    FOREIGN KEY (state_id) REFERENCES adif.state (id);

ALTER TABLE adif.state_county ADD CONSTRAINT state_county_county_name_fkey
    FOREIGN KEY (county_name_id) REFERENCES adif.county_name (id);

ALTER TABLE adif.pas ADD CONSTRAINT pas_dxcc_entity_fkey
    FOREIGN KEY (dxcc_entity_id) REFERENCES adif.dxcc_entity (id);

ALTER TABLE adif.sas ADD CONSTRAINT sas_pas_fkey
    FOREIGN KEY (pas_id) REFERENCES adif.pas (id);

ALTER TABLE adif.region ADD CONSTRAINT region_dxcc_entity_fkey
    FOREIGN KEY (dxcc_entity_id) REFERENCES adif.dxcc_entity (id);

ALTER TABLE adif.mode ADD CONSTRAINT mode_mode_description_fkey
    FOREIGN KEY (mode_description_id) REFERENCES adif.mode_description (id);

ALTER TABLE adif.submode ADD CONSTRAINT submode_mode_fkey
    FOREIGN KEY (mode_id) REFERENCES adif.mode (id);

ALTER TABLE adif.submode ADD CONSTRAINT submode_mode_description_fkey
    FOREIGN KEY (mode_description_id) REFERENCES adif.mode_description (id);

-- *****************************************************************************
--  GENERATE INDEXES based on utilitiies\index-reccomend2.sql
-- *****************************************************************************

\echo ''
\echo '-----------------------------'
\echo 'Creating Foreign Key Indexes'
\echo '-----------------------------'

CREATE INDEX contest_weblink_id_idx on adif.contest (weblink_id);
create index state_county_county_name_id_idx on adif.state_county (county_name_id);
create index submode_mode_description_id_idx on adif.submode (mode_description_id);
create index pas_dxcc_entity_id_idx on adif.pas (dxcc_entity_id);
create index credit_facet_id_idx on adif.credit (facet_id);
create index submode_mode_id_idx on adif.submode (mode_id);
create index sas_pas_id_idx on adif.sas (pas_id);
create index arrl_section_dxcc_entity_id_idx on adif.arrl_section (dxcc_entity_id);
create index credit_award_id_idx on adif.credit (award_id);
create index credit_sponsor_id_idx on adif.credit (sponsor_id);
create index state_county_state_id_idx on adif.state_county (state_id);
create index region_dxcc_entity_id_idx on adif.region (dxcc_entity_id);
create index mode_mode_description_id_idx on adif.mode (mode_description_id);

-- *****************************************************************************
--  GENERATE Views
-- *****************************************************************************

-- Create Test View: adif.database_info_view
CREATE OR REPLACE VIEW adif.database_info_view AS
    SELECT
        database_info.author AS "Author",
        database_info.db_version AS "DB Version",
        database_info.adif_spec AS "ADIF Spec",
        date_trunc('second', database_info.last_update::TIMESTAMP) AS "Revision Date"
    FROM adif.database_info;

-- View: adif.vw_antenna_path
CREATE OR REPLACE VIEW adif.antenna_path_view AS
    SELECT 
        antenna_path.abbreviation AS "Abbreviation",
        antenna_path.meaning AS "Meaning"
    FROM adif.antenna_path
    ORDER BY adif.antenna_path.abbreviation;

-- View: adif.vw_arrl_section
CREATE OR REPLACE VIEW adif.arrl_section_view AS
    SELECT 
        arrl_section.abbreviation AS "Abbreviation",
        arrl_section.name AS "Section Name",
        dxcc_entity.code AS "DXCC Code",
        dxcc_entity.name AS "DXCC Name",
        arrl_section.from_date AS "From Date",
        arrl_section.deleted_date AS "Deleted On"
    FROM adif.arrl_section
        JOIN adif.dxcc_entity ON 
            adif.dxcc_entity.id = adif.arrl_section.id
    ORDER BY arrl_section.name;

-- View: adif.vw_award
CREATE OR REPLACE VIEW adif.band_view AS
    SELECT
        band.name AS "Band",
        band.lower_freq AS "Lower Freq (MHZ)",
        band.upper_freq AS "Upper Freq (MHZ)"
    FROM adif.band
    ORDER BY band.lower_freq;

-- View: adif.award_view
CREATE OR REPLACE VIEW adif.award_view AS
    SELECT
        award.name AS "Award Name",
        award.import_only AS "Import Only"
    FROM adif.award
    ORDER BY award.name;

-- View: adif.vw_contest
CREATE OR REPLACE VIEW adif.contest_view AS
    SELECT
        contest.name AS "Contest Name",
        contest.description AS "Description",
        contest.import_only AS "Import Only",
        weblink.url AS "Weblink URL"
    FROM adif.contest
        LEFT JOIN adif.weblink ON
            adif.weblink.id = adif.contest.weblink_id
    ORDER BY contest.name;

-- View: adif.vw_continent
CREATE OR REPLACE VIEW adif.continent_view AS
    SELECT
        continent.abbreviation AS "Abbreviation",
        continent.name AS "Continent"
    FROM adif.continent
    ORDER BY continent.abbreviation;

-- View: adif.vw_county_name
CREATE OR REPLACE VIEW adif.county_name_view AS
    SELECT
        county_name.name AS "County Name"
    FROM adif.county_name
    ORDER BY county_name.name;

-- View: adif.vw_credit_award
CREATE OR REPLACE VIEW adif.credit_award_view AS
    SELECT
        credit_award.name AS "Award Name"
    FROM adif.credit_award
    ORDER BY credit_award.name;

-- View: adif.vw_credit_facet
CREATE OR REPLACE VIEW adif.credit_facet_view AS
    SELECT
        credit_facet.name AS "Facet"
    FROM adif.credit_facet
    ORDER BY credit_facet.name;

-- View: adif.vw_credit_sponsor
CREATE OR REPLACE VIEW adif.credit_sponsor_view AS
    SELECT
        credit_sponsor.name AS "Sponsor"
    FROM adif.credit_sponsor
    ORDER BY credit_sponsor.name;

-- View: adif.vw_credit
CREATE OR REPLACE VIEW adif.credit_view AS
    SELECT
        credit_for AS "Credit For",
        credit_sponsor.name AS "Sponsor",
        credit_award.name AS "Award",
        credit_facet.name AS "Facet"
    FROM adif.credit
        LEFT JOIN adif.credit_sponsor ON
            adif.credit_sponsor.id = adif.credit.sponsor_id
        LEFT JOIN adif.credit_award ON
            adif.credit_award.id = adif.credit.award_id
        LEFT JOIN adif.credit_facet ON
            adif.credit_facet.id = adif.credit.facet_id
    ORDER BY credit_for;

-- View: adif.vw_dxcc_entity
CREATE OR REPLACE VIEW adif.dxcc_entity_view AS
    SELECT
        dxcc_entity.code AS "DXCC Code",
        dxcc_entity.name AS "DXCC Name",
        dxcc_entity.is_deleted as "Deleted"
    FROM adif.dxcc_entity
    ORDER BY dxcc_entity.code;


-- View: adif.vw_state
CREATE OR REPLACE VIEW adif.state_view AS
    SELECT
        state.abbreviation AS "Abbreviation",
        state.name AS "Name"
    FROM adif.state
    ORDER BY state.name;

-- View: adif.vw_state_county
CREATE OR REPLACE VIEW adif.state_county_view AS
    SELECT
        state.abbreviation AS "Abbreviation",
        state.name AS "State",
        county_name.name AS "County"
    FROM adif.state_county
        JOIN adif.state ON
            adif.state.id = adif.state_county.state_id
        JOIN adif.county_name ON
            adif.county_name.id = adif.state_county.county_name_id
    ORDER by state.name;


-- *****************************************************************************
--  FOOTER - Finished
-- *****************************************************************************
\echo 'Finished Creating ARDS Enumeration Schema'
\echo ''
\echo 'Database Information'
\echo ''
select * from adif.database_info_view;
\echo 'Project Data'
\echo ''
\echo 'Github URL ......: https://github.com/KI7MT/radio-data-service'
\echo 'Report Bugs to ..: https://github.com/KI7MT/radio-data-service/issues'
\echo 'ADIF Refrence ...: http://www.adif.org/309/ADIF_309.htm#Enumerations'
\echo ''

-- END adif.sql