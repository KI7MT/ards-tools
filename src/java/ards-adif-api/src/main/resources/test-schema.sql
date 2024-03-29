-- Drop, and re-create schema
DROP SCHEMA IF EXISTS adif CASCADE;

-- Create New Schema
CREATE SCHEMA adif;

-- INSERT INTO adif.schema_info(schema_name, schema_version, adif_spec, last_update)
-- VALUES('adif', '0.0.1', '3.0.9', CURRENT_TIMESTAMP)

-- Source Data Information -----------------------------------------------------
CREATE TABLE adif.source_list -- FK Done
(
    id SERIAL PRIMARY KEY,
    source_name VARCHAR NOT NULL,
    source_date date NOT NULL,
    verified_date date NOT NULL,
    weblink_id INT NOT NULL,
    CONSTRAINT source_name_uq UNIQUE (source_name)
);

-- Antenna Path ----------------------------------------------------------------
CREATE TABLE adif.antenna_path -- No FK needed
(
    id SERIAL PRIMARY KEY,
    abbreviation VARCHAR(1) NOT NULL,
    meaning VARCHAR(15) NOT NULL,
    CONSTRAINT antenna_path_uq UNIQUE (abbreviation, meaning)
);

-- ARRL Section ----------------------------------------------------------------
CREATE TABLE adif.arrl_section -- FK Done
(
    id SERIAL PRIMARY KEY,
    abbreviation VARCHAR(4) NOT NULL,
    name VARCHAR(70) NOT NULL,
    dxcc_id INT NOT NULL,
    from_date date,
    deleted_date date
);

-- Award -----------------------------------------------------------------------
CREATE TABLE adif.award -- No FK needed
(
    id SERIAL PRIMARY KEY,
    name VARCHAR(15) NOT NULL,
    import_only BOOLEAN DEFAULT '1',
    CONSTRAINT award_name_uq UNIQUE (name)
);

-- BAND ------------------------------------------------------------------------
CREATE TABLE adif.band -- No FK Needed
(
    id SERIAL PRIMARY KEY,
    name VARCHAR(6) NOT NULL,
    lower_freq NUMERIC NOT NULL,
    upper_freq NUMERIC NOT NULL,
    CONSTRAINT band_name_uq UNIQUE (name)
);

-- Contest ---------------------------------------------------------------------
CREATE TABLE adif.contest -- FK Done
(
    id SERIAL PRIMARY KEY,
    name VARCHAR(60),
    description VARCHAR(120),
    import_only BOOLEAN NOT NULL DEFAULT '0',
    weblink_id INT,
    CONSTRAINT contest_name_uq UNIQUE (name)
);

-- Continent -------------------------------------------------------------------
CREATE TABLE adif.continent -- No FK Needed
(
    id SERIAL PRIMARY KEY,
    abbreviation VARCHAR(2),
    name VARCHAR(14),
    CONSTRAINT continent_name_uq UNIQUE (abbreviation, name)
);

-- Credit Sponsor --------------------------------------------------------------
CREATE TABLE adif.credit_sponsor -- No FK Needed
(
    id SERIAL PRIMARY KEY,
    name VARCHAR(20),
    CONSTRAINT credit_sponsor_name_uq UNIQUE (name)
);

-- Credit Award ----------------------------------------------------------------
CREATE TABLE adif.credit_award -- No FK needed
(
    id SERIAL PRIMARY KEY,
    name VARCHAR(60),
    CONSTRAINT credit_award_name_uq UNIQUE (name)
);

-- Credit Facet ----------------------------------------------------------------
CREATE TABLE adif.credit_facet -- No FK needed
(
    id SERIAL PRIMARY KEY,
    name VARCHAR(20),
    CONSTRAINT credit_facet_name_uq UNIQUE (name)
);

-- Credit ----------------------------------------------------------------------
CREATE TABLE adif.credit -- FK Done
(
    id SERIAL PRIMARY KEY,
    credit_for VARCHAR(24) NOT NULL,
    sponsor_id INT NOT NULL,
    award_id INT NOT NULL,
    facet_id INT NOT NULL,
    CONSTRAINT credit_for_uq UNIQUE (credit_for)
);

-- DXCC ------------------------------------------------------------------------
-- (id) is a natureal PK matching the dxcc_id
CREATE TABLE adif.dxcc -- No FK needed
(
    id INT PRIMARY KEY,
    code VARCHAR(4) NOT NULL,
    name VARCHAR(90) NOT NULL,
    is_deleted BOOLEAN DEFAULT '0',
    CONSTRAINT dxcc_code_name_uq UNIQUE (code, name)
);

-- CQ Zone ---------------------------------------------------------------------
CREATE TABLE adif.cq_zone -- FK Done
(
    id INT PRIMARY KEY,
    cqzone INT NOT NULL,
    description VARCHAR(60) NOT NULL,
    weblink_id INT,
    CONSTRAINT cq_zone_cqzone_uq UNIQUE (cqzone)
);

-- ITU Zone --------------------------------------------------------------------
CREATE TABLE adif.itu_zone -- FK Done
(
    id INT PRIMARY KEY,
    ituzone INT NOT NULL,
    description VARCHAR(300),
    weblink_id INT,
    CONSTRAINT itu_zone_ituzone_uq UNIQUE (ituzone)
);

-- IARU Region -----------------------------------------------------------------
CREATE TABLE adif.iaru_region -- FK Done
(
    id INT PRIMARY KEY,
    region INT NOT NULL,
    description VARCHAR(120),
    weblink_id INT,
    CONSTRAINT iaru_region_region_uq UNIQUE (region)
);

-- IARU Region Member ----------------------------------------------------------
CREATE TABLE adif.iaru_region_member -- FK Done
(
    id INT PRIMARY KEY,
    iaru_region_id INT NOT NULL,
    name VARCHAR(120),
    country_territory VARCHAR(60),
    CONSTRAINT iaru_region_name_uq UNIQUE (name)
);

-- Mode ------------------------------------------------------------------------
CREATE TABLE adif.mode -- FK Done
(
    id SERIAL PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    mode_description_id INT,
    import_only BOOLEAN NOT NULL DEFAULT '0',
    CONSTRAINT mode_name_uq UNIQUE (name)
);

-- Submode ---------------------------------------------------------------------
CREATE TABLE adif.submode -- FK Done
(
    id SERIAL PRIMARY KEY,
    mode_id INT NOT NULL,
    name VARCHAR(20) NOT NULL,
    mode_description_id INT,
    CONSTRAINT submode_name_uq UNIQUE (name)
);

-- Mode Description ------------------------------------------------------------
CREATE TABLE adif.mode_description
(
    id SERIAL PRIMARY KEY,
    description VARCHAR(20) NOT NULL,
    weblink_id INT
);

-- State -----------------------------------------------------------------------
CREATE TABLE adif.state -- No FK Needed
(
    id SERIAL PRIMARY KEY,
    abbreviation VARCHAR(2) NOT NULL,
    name VARCHAR(20) NOT NULL,
    CONSTRAINT state_uq UNIQUE (abbreviation, name)
);

-- County Name -----------------------------------------------------------------
CREATE TABLE adif.county_name -- No FK Needed
(
    id SERIAL PRIMARY KEY,
    name VARCHAR(60) NOT NULL,
    CONSTRAINT county_name_uq UNIQUE (name)
);

-- State-County ----------------------------------------------------------------
CREATE TABLE adif.state_county -- FK Done
(
    id SERIAL PRIMARY KEY,
    state_id INT NOT NULL,
    county_name_id INT NOT NULL
);

-- Propogation -----------------------------------------------------------------
CREATE TABLE adif.propogation_mode -- No FK Needed
(
    id SERIAL PRIMARY KEY,
    enumeration VARCHAR(20) NOT NULL,
    description VARCHAR(120) NOT NULL,
    CONSTRAINT propogation_mode_abbreviation_uq UNIQUE (enumeration)
);

-- QSL Medium ------------------------------------------------------------------
CREATE TABLE adif.qsl_medium -- No FK Needed
(
    id SERIAL PRIMARY KEY,
    medium VARCHAR(10) NOT NULL,
    description VARCHAR(120) NOT NULL,
    CONSTRAINT qsl_medium_uq UNIQUE (medium)
);

-- QSL Recieved ----------------------------------------------------------------
CREATE TABLE adif.qsl_rcvd -- No FK needed
(
    id SERIAL PRIMARY KEY,
    status VARCHAR(1) NOT NULL,
    meaning VARCHAR(20) NOT NULL,
    description VARCHAR(255),
    import_only BOOLEAN NOT NULL DEFAULT '0',
    CONSTRAINT qsl_rcvd_status_uq UNIQUE (status)
);

-- QSL Sent --------------------------------------------------------------------
CREATE TABLE adif.qsl_sent --- No FK Needed
(
    id SERIAL PRIMARY KEY,
    status VARCHAR(1) NOT NULL,
    meaning VARCHAR(20) NOT NULL,
    description VARCHAR(255),
    CONSTRAINT qsl_sent_status_uq UNIQUE (status)
);

-- QSL Via ---------------------------------------------------------------------
CREATE TABLE adif.qsl_via -- No FK Needed
(
    id SERIAL PRIMARY KEY,
    via VARCHAR(1) NOT NULL,
    description VARCHAR(20) NOT NULL,
    import_only BOOLEAN NOT NULL DEFAULT '0',
    CONSTRAINT qsl_via_uq UNIQUE (via)
);

-- QSO Complete ----------------------------------------------------------------
CREATE TABLE adif.qso_complete -- No FK Needed
(
    id SERIAL PRIMARY KEY,
    abbreviation VARCHAR(5) NOT NULL,
    meaning VARCHAR(20) NOT NULL,
    CONSTRAINT qso_complete_abbreviation_uq UNIQUE (abbreviation)
);

-- QSO Upload Status -----------------------------------------------------------
CREATE TABLE adif.qso_upload_status -- No FK Needed
(
    id SERIAL PRIMARY KEY,
    abbreviaiton VARCHAR(1) NOT NULL,
    description VARCHAR(120) NOT NULL,
    CONSTRAINT qso_upload_status_abbreviation_uq UNIQUE (abbreviaiton)
);

-- Region ----------------------------------------------------------------------
CREATE TABLE adif.region -- FK Done
(
    id SERIAL PRIMARY KEY,
    code VARCHAR(4),
    dxcc_id INT,
    region VARCHAR(120),
    prefix VARCHAR(10),
    CONSTRAINT region_code_uq UNIQUE (code)
);

-- Region Applicability --------------------------------------------------------
CREATE TABLE adif.region_applicability -- FK Done
(
    id SERIAL PRIMARY KEY,
    region_id INT NOT NULL,
    weblink_id INT NOT NULL
);

-- Web Link Section ------------------------------------------------------------
CREATE TABLE adif.weblink -- No FK needed
(
    id SERIAL PRIMARY KEY,
    display_text VARCHAR(120) NOT NULL,
    url VARCHAR(255) NOT NULL,
    CONSTRAINT weblink_display_text_uq UNIQUE (display_text)
);

-- Sponsored Award -------------------------------------------------------------
CREATE TABLE adif.sponsored_award
(
    id SERIAL PRIMARY KEY,
    sponsor VARCHAR(20) NOT NULL,
    weblink_id INT NOT NULL,
    CONSTRAINT qso_sponsored_award_sponsor_uq UNIQUE (sponsor)
);

-- *****************************************************************************
--  ADD CSV DATA
-- *****************************************************************************

-- NOTE(s): 
-- Note: All CSV File use "|" as the delimiter.

--COPY adif.antenna_path FROM 'adif/antenna_path.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
--COPY adif.arrl_section FROM 'adif/arrl_section.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
--COPY adif.award FROM 'adif/award.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
--COPY adif.band FROM 'adif/band.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
--COPY adif.contest FROM 'adif/contest.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
--COPY adif.continent FROM 'adif/continent.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
--COPY adif.county_name FROM 'adif/county_name.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
--COPY adif.credit FROM 'adif/credit.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
--COPY adif.credit_award FROM 'adif/credit_award.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
--COPY adif.credit_facet FROM 'adif/credit_facet.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
--COPY adif.credit_sponsor FROM 'adif/credit_sponsor.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
--COPY adif.dxcc FROM 'adif/dxcc.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
--COPY adif.state FROM 'adif/state.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
--COPY adif.state_county FROM 'adif/state_county.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
--COPY adif.mode FROM 'adif/mode.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
--COPY adif.submode FROM 'adif/submode.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
--COPY adif.propogation_mode FROM 'adif/propogation_mode.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
--COPY adif.qsl_medium FROM 'adif/qsl_medium.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
--COPY adif.qsl_rcvd FROM 'adif/qsl_rcvd.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
--COPY adif.qsl_sent FROM 'adif/qsl_sent.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
--COPY adif.qsl_via FROM 'adif/qsl_via.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
--COPY adif.qso_complete FROM 'adif/qsl_complete.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
--COPY adif.qso_upload_status FROM 'adif/qso_upload_status.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
--COPY adif.region FROM 'adif/region.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
--COPY adif.region_applicability FROM 'adif/region_applicability.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
--COPY adif.weblink FROM 'adif/weblink.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
--COPY adif.sponsored_award FROM 'adif/sponsored_award.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
--COPY adif.cq_zone FROM 'adif/cq_zone.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
--COPY adif.itu_zone FROM 'adif/itu_zone.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- *****************************************************************************
--  ADD FOREIGN KEYS
-- *****************************************************************************


-- Source List -----------------------------------------------------------------
ALTER TABLE adif.source_list ADD CONSTRAINT source_list_weblink_fkey
    FOREIGN KEY (weblink_id) REFERENCES adif.weblink (id);

-- ARRL Section ----------------------------------------------------------------
ALTER TABLE adif.arrl_section ADD CONSTRAINT arrl_section_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES adif.dxcc (id);

-- Contest ---------------------------------------------------------------------
ALTER TABLE adif.contest ADD CONSTRAINT contest_weblink_fkey
    FOREIGN KEY (weblink_id) REFERENCES adif.weblink (id);

-- Credit ----------------------------------------------------------------------
ALTER TABLE adif.credit ADD CONSTRAINT credit_credit_sponsor_fkey
    FOREIGN KEY (sponsor_id) REFERENCES adif.credit_sponsor (id);

ALTER TABLE adif.credit ADD CONSTRAINT credit_credit_award_fkey
    FOREIGN KEY (award_id) REFERENCES adif.credit_award (id);

ALTER TABLE adif.credit ADD CONSTRAINT credit_credit_facet_fkey
    FOREIGN KEY (facet_id) REFERENCES adif.credit_facet (id);

-- CQ Zone ---------------------------------------------------------------------
ALTER TABLE adif.cq_zone ADD CONSTRAINT cq_zone_weblink_fkey
    FOREIGN KEY (weblink_id) REFERENCES adif.weblink (id);

-- ITU Zone --------------------------------------------------------------------
ALTER TABLE adif.itu_zone ADD CONSTRAINT itu_zone_weblink_fkey
    FOREIGN KEY (weblink_id) REFERENCES adif.weblink (id);

-- IARU Region Weblink ---------------------------------------------------------
ALTER TABLE adif.iaru_region ADD CONSTRAINT iaru_region_weblink_fkey
    FOREIGN KEY (weblink_id) REFERENCES adif.weblink (id);

-- IARU Region Member ----------------------------------------------------------
ALTER TABLE adif.iaru_region_member ADD CONSTRAINT iaru_region_member_iaru_region_fkey
    FOREIGN KEY (iaru_region_id) REFERENCES adif.iaru_region (id);

-- State County ----------------------------------------------------------------
ALTER TABLE adif.state_county ADD CONSTRAINT state_county_state_fkey
    FOREIGN KEY (state_id) REFERENCES adif.state (id);

ALTER TABLE adif.state_county ADD CONSTRAINT state_county_county_name_fkey
    FOREIGN KEY (county_name_id) REFERENCES adif.county_name (id);

-- Mode ------------------------------------------------------------------------
ALTER TABLE adif.mode ADD CONSTRAINT mode_mode_description_fkey
    FOREIGN KEY (mode_description_id) REFERENCES adif.mode_description (id);

-- Submode ---------------------------------------------------------------------
ALTER TABLE adif.submode ADD CONSTRAINT submode_mode_fkey
    FOREIGN KEY (mode_id) REFERENCES adif.mode (id);

ALTER TABLE adif.submode ADD CONSTRAINT submode_mode_description_fkey
    FOREIGN KEY (mode_description_id) REFERENCES adif.mode_description (id);

-- Mode Description ------------------------------------------------------------
ALTER TABLE adif.mode_description ADD CONSTRAINT mode_description_weblink_fkey
    FOREIGN KEY (weblink_id) REFERENCES adif.weblink (id);


-- Region ----------------------------------------------------------------------
ALTER TABLE adif.region ADD CONSTRAINT region_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES adif.dxcc (id);

-- Region Applicabiility -------------------------------------------------------
ALTER TABLE adif.region_applicability ADD CONSTRAINT region_applicability_region_fkey
    FOREIGN KEY (region_id) REFERENCES adif.region (id);

ALTER TABLE adif.region_applicability ADD CONSTRAINT region_applicability_weblink_fkey
    FOREIGN KEY (weblink_id) REFERENCES adif.weblink (id);

-- Sponsored Award -------------------------------------------------------------
ALTER TABLE adif.sponsored_award ADD CONSTRAINT sponsored_award_weblink_fkey
    FOREIGN KEY (weblink_id) REFERENCES adif.weblink (id);

-- *****************************************************************************
--  ADD INDEXES based on z-tools\index-reccomend2.sql
-- *****************************************************************************

-- *****************************************************************************
--  VIEWS
-- *****************************************************************************

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
            adif.dxcc.id = adif.arrl_section.dxcc_id
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
            adif.state.id = adif.state_county.state_id
        JOIN adif.county_name ON
            adif.county_name.id = adif.state_county.county_name_id
    ORDER by state.name;


-- *****************************************************************************
--  FOOTER
-- *****************************************************************************
-- SELECT * FROM ards.view_schema_info WHERE view_schema_info."Schema Name" = :'name';

-- END schema.sql