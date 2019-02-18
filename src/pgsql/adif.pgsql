/* 

    Project .............: Amateur Radio Data Serivce Tools
    Author ..............: Greg, Beam, KI7MT, <ki7mt@yahoo.com>
    Copyright ...........: Copyright (C) 2018-2019 Greg Beam, KI7MT
    License .............: GPL-3

    File ................: adif.pgsql
    Description .........: ADIF Enumeration Tables
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

            psql -v ON_ERROR_STOP=1 -U ards -f adif.pgsql

    Development Activity and Coding

        Suffix Annotations
        _uq     = Unique Constraint
        _pkey   = Primary Key
        _fkey   = Foreign Key

        TODO: Move JTAlerts Model to it's own script
        TODO: Need adif.pas and adif.sas CSV Data files
        TODO: Add adif.sas FK's after adif.pas has been populated.
        TODO: Add Japan JCC, JGC, KU Tables and List CSV Data
        TODO: Need JCC, JGC, and KU CSV Datafiles
        TODO: Add Source Data Table: souce_data_info

*/

-- Script Variables
\set name adif
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

-- Source Data Informaiton
CREATE TABLE adif.source_list -- FK Done
(
    id SERIAL PRIMARY KEY,
    source_name VARCHAR NOT NULL,
    source_date date NOT NULL,
    verified_date date NOT NULL,
    weblink_id INT NOT NULL,
    CONSTRAINT source_name_uq UNIQUE (source_name)
);

-- Antenna Path
CREATE TABLE adif.antenna_path -- No FK needed
(
    id SERIAL PRIMARY KEY,
    abbreviation VARCHAR(1) NOT NULL,
    meaning VARCHAR(15) NOT NULL,
    CONSTRAINT antenna_path_uq UNIQUE (abbreviation, meaning)
);

-- Award
CREATE TABLE adif.award -- No FK needed
(
    id SERIAL PRIMARY KEY,
    name VARCHAR(15),
    import_only BOOLEAN NOT NULL DEFAULT '1',
    CONSTRAINT award_name_uq UNIQUE (name)
);

-- ARRL Section 
CREATE TABLE adif.arrl_section -- FK Done
(
    id SERIAL PRIMARY KEY,
    abbreviation VARCHAR(4) NOT NULL,
    name VARCHAR(70) NOT NULL,
    dxcc_entity_id INT NOT NULL,
    from_date date,
    deleted_date date
);

-- BAND
CREATE TABLE adif.band -- No FK Needed
(
    id SERIAL PRIMARY KEY,
    name VARCHAR(6) NOT NULL,
    lower_freq NUMERIC NOT NULL,
    upper_freq NUMERIC NOT NULL,
    CONSTRAINT band_name_uq UNIQUE (name)
);

-- Contest
CREATE TABLE adif.contest -- FK Done
(
    id SERIAL PRIMARY KEY,
    name VARCHAR(60),
    description VARCHAR(120),
    import_only BOOLEAN NOT NULL DEFAULT '0',
    weblink_id INT,
    CONSTRAINT contest_name_uq UNIQUE (name)
);

-- Continent
CREATE TABLE adif.continent -- No FK Needed
(
    id SERIAL PRIMARY KEY,
    abbreviation VARCHAR(2),
    name VARCHAR(14),
    CONSTRAINT continent_name_uq UNIQUE (abbreviation, name)
);

-- Credit Sponsor
CREATE TABLE adif.credit_sponsor -- No FK Needed
(
    id SERIAL PRIMARY KEY,
    name VARCHAR(20),
    CONSTRAINT credit_sponsor_name_uq UNIQUE (name)
);

-- Credit Award
CREATE TABLE adif.credit_award -- No FK needed
(
    id SERIAL PRIMARY KEY,
    name VARCHAR(60),
    CONSTRAINT credit_award_name_uq UNIQUE (name)
);

-- Credit Facet
CREATE TABLE adif.credit_facet -- No FK needed
(
    id SERIAL PRIMARY KEY,
    name VARCHAR(20),
    CONSTRAINT credit_facet_name_uq UNIQUE (name)
);

-- Credit
CREATE TABLE adif.credit -- FK Done
(
    id SERIAL PRIMARY KEY,
    credit_for VARCHAR(24) NOT NULL,
    sponsor_id INT NOT NULL,
    award_id INT NOT NULL,
    facet_id INT NOT NULL,
    CONSTRAINT credit_for_uq UNIQUE (credit_for)
);

-- DXCC Entities
-- (id) is a natureal PK matching the dxcc_entity_id
CREATE TABLE adif.dxcc_entity -- No FK needed
(
    id INT PRIMARY KEY,
    code VARCHAR(4) NOT NULL,
    name VARCHAR(90) NOT NULL,
    is_deleted BOOLEAN DEFAULT '0',
    CONSTRAINT dxcc_entity_name_uq UNIQUE (code, name)
);

-- State
CREATE TABLE adif.state -- No FK Needed
(
    id SERIAL PRIMARY KEY,
    abbreviation VARCHAR(2) NOT NULL,
    name VARCHAR(20) NOT NULL,
    CONSTRAINT state_uq UNIQUE (abbreviation, name)
);

-- County
CREATE TABLE adif.county_name -- No FK Needed
(
    id SERIAL PRIMARY KEY,
    name VARCHAR(60) NOT NULL,
    CONSTRAINT county_name_uq UNIQUE (name)
);

-- State County
CREATE TABLE adif.state_county -- FK Done
(
    id SERIAL PRIMARY KEY,
    state_id INT NOT NULL,
    county_name_id INT NOT NULL
);

-- Mode
CREATE TABLE adif.mode -- FK DOne
(
    id SERIAL PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    mode_description_id INT,
    import_only BOOLEAN NOT NULL DEFAULT '0',
    CONSTRAINT mode_name_uq UNIQUE (name)
);

-- Submode
CREATE TABLE adif.submode -- FK Done
(
    id SERIAL PRIMARY KEY,
    mode_id INT NOT NULL,
    name VARCHAR(20) NOT NULL,
    mode_description_id INT,
    CONSTRAINT submode_name_uq UNIQUE (name)
);

-- Mode Description
CREATE TABLE adif.mode_description -- FK Done
(
    id SERIAL PRIMARY KEY,
    description VARCHAR(120) NOT NULL
);

-- CQ Zone
CREATE TABLE adif.cq_zone -- FK Done
(
    id INT PRIMARY KEY,
    short_description VARCHAR(60) NOT NULL,
    long_description VARCHAR NOT NULL,
    weblink_id INT
);

-- ITU Zone
CREATE TABLE adif.itu_zone -- FK Done
(
    id INT PRIMARY KEY,
    number INT NOT NULL,
    short_description VARCHAR(120),
    long_description VARCHAR (255),
    weblink_id INT,
    CONSTRAINT itu_zone_number_uq UNIQUE (number)
);

-- Propogation
CREATE TABLE adif.propogation_mode -- FK Done
(
    id SERIAL PRIMARY KEY,
    enumeration VARCHAR(20) NOT NULL,
    description VARCHAR(120) NOT NULL,
    CONSTRAINT propogation_mode_abbreviation_uq UNIQUE (enumeration)
);

-- Primary Administrative Subdivision (PAS)
CREATE TABLE adif.pas -- FK Done
(
    id SERIAL PRIMARY KEY,
    dxcc_entity_id INT NOT NULL,
    region VARCHAR(120),
    code VARCHAR(10) NOT NULL,
    subdivision VARCHAR(80) NOT NULL,
    is_deleted BOOLEAN NOT NULL DEFAULT '0',
    oblast_id INT,
    CONSTRAINT pas_code_subdivision_uq UNIQUE (code, subdivision)
);

-- PAS CQ Zone
CREATE TABLE adif.pas_cq_zone -- FK Done
(
    id SERIAL PRIMARY KEY,
    pas_id INT NOT NULL,
    cq_zone_id INT NOT NULL    
);

-- PAS ITU Zone
CREATE TABLE adif.pas_itu_zone -- FK Done
(
    id SERIAL PRIMARY KEY,
    pas_id INT NOT NULL,
    itu_zone_id INT NOT NULL    
);

-- Secondary Administrative Subdivision (SAS)
CREATE TABLE adif.sas
(
    id SERIAL PRIMARY KEY,
    pas_id INT NOT NULL,
    name VARCHAR(80) NOT NULL,
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
CREATE TABLE adif.qsl_rcvd -- No FK needed
(
    id SERIAL PRIMARY KEY,
    status VARCHAR(1) NOT NULL,
    meaning VARCHAR(20) NOT NULL,
    import_only BOOLEAN NOT NULL DEFAULT '0',
    description VARCHAR(255),
    CONSTRAINT qsl_rcvd_status_uq UNIQUE (status)
);

-- QSL Sent
CREATE TABLE adif.qsl_sent --- No FK Needed
(
    id SERIAL PRIMARY KEY,
    status VARCHAR(1) NOT NULL,
    meaning VARCHAR(20) NOT NULL,
    description VARCHAR(255),
    CONSTRAINT qsl_sent_status_uq UNIQUE (status)
);

-- QSL Via
CREATE TABLE adif.qsl_via -- No FK Needed
(
    id SERIAL PRIMARY KEY,
    via VARCHAR(1) NOT NULL,
    description VARCHAR(20) NOT NULL,
    import_only BOOLEAN NOT NULL DEFAULT '0',
    CONSTRAINT qsl_via_uq UNIQUE (via)
);

-- QSO Complete
CREATE TABLE adif.qso_complete -- No FK Needed
(
    id SERIAL PRIMARY KEY,
    abbreviation VARCHAR(5) NOT NULL,
    meaning VARCHAR(20) NOT NULL,
    CONSTRAINT qso_complete_abbreviation_uq UNIQUE (abbreviation)
);

-- QSO Upload Status
CREATE TABLE adif.qso_upload_status -- No FK Needed
(
    id SERIAL PRIMARY KEY,
    abbreviaiton VARCHAR(1) NOT NULL,
    description VARCHAR(120) NOT NULL,
    CONSTRAINT qso_upload_status_abbreviation_uq UNIQUE (abbreviaiton)
);

-- Region
CREATE TABLE adif.region -- FK Done
(
    id SERIAL PRIMARY KEY,
    code VARCHAR(4),
    dxcc_entity_id INT,
    region VARCHAR(120),
    prefix VARCHAR(10),
    CONSTRAINT region_code_uq UNIQUE (code)
);

-- Region Applicability
CREATE TABLE adif.region_applicability -- FK Done
(
    id SERIAL PRIMARY KEY,
    region_id INT NOT NULL,
    weblink_id INT NOT NULL
);

-- Web Link Section
CREATE TABLE adif.weblink -- No FK needed
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

-- Oblast
CREATE TABLE adif.oblast
(
    id SERIAL PRIMARY KEY,
    prefix VARCHAR(2) NOT NULL,
    continent_id INT NOT NULL,
    oblast_number INT NOT NULL,
    designation VARCHAR(2) NOT NULL,
    territory VARCHAR(60) NOT NULL,
    is_deleted BOOLEAN NOT NULL DEFAULT '0',
    dxcc_entity_id INT NOT NULL
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

\echo
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

\echo
\echo 'Adding Foreign Keys'
\echo '---------------------------'

ALTER TABLE adif.source_list ADD CONSTRAINT source_list_weblink_fkey
    FOREIGN KEY (weblink_id) REFERENCES adif.weblink (id);

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

ALTER TABLE adif.sponsored_award ADD CONSTRAINT sponsored_award_weblink_fkey
    FOREIGN KEY (weblink_id) REFERENCES adif.weblink (id);

ALTER TABLE adif.state_county ADD CONSTRAINT state_county_state_fkey
    FOREIGN KEY (state_id) REFERENCES adif.state (id);

ALTER TABLE adif.state_county ADD CONSTRAINT state_county_county_name_fkey
    FOREIGN KEY (county_name_id) REFERENCES adif.county_name (id);

ALTER TABLE adif.mode ADD CONSTRAINT mode_mode_description_fkey
    FOREIGN KEY (mode_description_id) REFERENCES adif.mode_description (id);

ALTER TABLE adif.submode ADD CONSTRAINT submode_mode_fkey
    FOREIGN KEY (mode_id) REFERENCES adif.mode (id);

ALTER TABLE adif.submode ADD CONSTRAINT submode_mode_description_fkey
    FOREIGN KEY (mode_description_id) REFERENCES adif.mode_description (id);

ALTER TABLE adif.cq_zone ADD CONSTRAINT cq_zone_weblink_fkey
    FOREIGN KEY (weblink_id) REFERENCES adif.weblink (id);

ALTER TABLE adif.itu_zone ADD CONSTRAINT itu_zone_weblink_fkey
    FOREIGN KEY (weblink_id) REFERENCES adif.weblink (id);

ALTER TABLE adif.pas ADD CONSTRAINT pas_dxcc_entity_fkey
    FOREIGN KEY (dxcc_entity_id) REFERENCES adif.dxcc_entity (id);

ALTER TABLE adif.pas ADD CONSTRAINT pas_oblast_fkey
    FOREIGN KEY (oblast_id) REFERENCES adif.oblast (id);

ALTER TABLE adif.pas_cq_zone ADD CONSTRAINT pas_cq_zone_pas_fkey
    FOREIGN KEY (pas_id) REFERENCES adif.pas (id);

ALTER TABLE adif.pas_cq_zone ADD CONSTRAINT pas_cq_zone_cq_zone_fkey
    FOREIGN KEY (cq_zone_id) REFERENCES adif.cq_zone (id);

ALTER TABLE adif.pas_itu_zone ADD CONSTRAINT pas_itu_zone_pas_fkey
    FOREIGN KEY (pas_id) REFERENCES adif.pas (id);

ALTER TABLE adif.pas_itu_zone ADD CONSTRAINT pas_itu_zone_itu_zone_fkey
    FOREIGN KEY (itu_zone_id) REFERENCES adif.itu_zone (id);

ALTER TABLE adif.region ADD CONSTRAINT region_dxcc_entity_fkey
    FOREIGN KEY (dxcc_entity_id) REFERENCES adif.dxcc_entity (id);

ALTER TABLE adif.region_applicability ADD CONSTRAINT region_applicability_region_fkey
    FOREIGN KEY (region_id) REFERENCES adif.region (id);

ALTER TABLE adif.region_applicability ADD CONSTRAINT region_applicability_weblink_fkey
    FOREIGN KEY (weblink_id) REFERENCES adif.weblink (id);

ALTER TABLE adif.oblast ADD CONSTRAINT oblast_continent_fkey
    FOREIGN KEY (continent_id) REFERENCES adif.continent (id);

ALTER TABLE adif.oblast ADD CONSTRAINT oblast_dxcc_entity_fkey
    FOREIGN KEY (dxcc_entity_id) REFERENCES adif.dxcc_entity (id);

-- *****************************************************************************
--  ADD INDEXES based on z-tools\index-reccomend2.sql
-- *****************************************************************************

\echo
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
create index pas_cq_zone_pas_id_idx on adif.pas_cq_zone (pas_id);
create index region_applicability_region_id_idx on adif.region_applicability (region_id);
create index itu_zone_weblink_id_idx on adif.itu_zone (weblink_id);
create index cq_zone_weblink_id_idx on adif.cq_zone (weblink_id);
create index oblast_dxcc_entity_id_idx on adif.oblast (dxcc_entity_id);
create index oblast_continent_id_idx on adif.oblast (continent_id);
create index pas_oblast_id_idx on adif.pas (oblast_id);
create index pas_itu_zone_pas_id_idx on adif.pas_itu_zone (pas_id);
create index pas_itu_zone_itu_zone_id_idx on adif.pas_itu_zone (itu_zone_id);
create index sponsored_award_weblink_id_idx on adif.sponsored_award (weblink_id);
create index source_list_weblink_id_idx on adif.source_list (weblink_id);
create index region_applicability_weblink_id_idx on adif.region_applicability (weblink_id);
create index pas_cq_zone_cq_zone_id_idx on adif.pas_cq_zone (cq_zone_id);

-- *****************************************************************************
--  VIEWS
-- *****************************************************************************

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
        dxcc_entity.code AS "DXCC Code",
        dxcc_entity.name AS "DXCC Name",
        arrl_section.from_date AS "From Date",
        arrl_section.deleted_date AS "Deleted On"
    FROM adif.arrl_section
        JOIN adif.dxcc_entity ON 
            adif.dxcc_entity.id = adif.arrl_section.id
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
            adif.weblink.id = adif.contest.weblink_id
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
            adif.credit_sponsor.id = adif.credit.sponsor_id
        LEFT JOIN adif.credit_award ON
            adif.credit_award.id = adif.credit.award_id
        LEFT JOIN adif.credit_facet ON
            adif.credit_facet.id = adif.credit.facet_id
    ORDER BY credit_for;

-- View: adif.vw_dxcc_entity
CREATE OR REPLACE VIEW adif.view_dxcc_entity AS
    SELECT
        dxcc_entity.code AS "DXCC Code",
        dxcc_entity.name AS "DXCC Name",
        dxcc_entity.is_deleted as "Deleted"
    FROM adif.dxcc_entity
    ORDER BY dxcc_entity.code;


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
            adif.state.id = adif.state_county.state_id
        JOIN adif.county_name ON
            adif.county_name.id = adif.state_county.county_name_id
    ORDER by state.name;


-- *****************************************************************************
--  FOOTER
-- *****************************************************************************
\echo
SELECT * FROM ards.view_schema_info WHERE view_schema_info."Schema Name" = :'name';

-- END adif.sql