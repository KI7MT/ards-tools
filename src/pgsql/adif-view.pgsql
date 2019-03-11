-- =============================================================================
--
--                        ADIF VIEW TABLES / MODELS
--
-- =============================================================================

-- Script Variables
\set name adif_view
\set ver 0.0.1
\set adifv 3.0.9
\echo ''
\echo Generating Schema for ( :name )
\echo '-----------------------------------'

-- Drop, and re-create schema
DROP SCHEMA IF EXISTS :name CASCADE;

-- Create New Schema
CREATE SCHEMA :name;

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
CREATE OR REPLACE VIEW adif_view.contest AS
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

-- iaru_region -----------------------------------------------------------------
CREATE TABLE adif_view.iaru_region AS
    SELECT
        iaru_region.region AS "Region",
        iaru_region.description AS "Description"
    FROM adif.iaru_region
    ORDER BY iaru_region.region;

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

-- qso_complete ----------------------------------------------------------------
CREATE TABLE adif_view.qso_complete AS
    SELECT
        qso_complete.abbreviation AS "Abbreviation",
        qso_complete.meaning AS "Meaning"
    FROM adif.qso_complete
    ORDER BY qso_complete.Abbreviation;

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

-- *****************************************************************************
-- Add Schema Informaiton
-- *****************************************************************************

INSERT INTO schema_info(schema_name, schema_version, adif_spec, last_update)
VALUES(:'name', :'ver', :'adifv', CURRENT_TIMESTAMP)
ON CONFLICT (schema_name) DO UPDATE SET schema_version = :'ver',
                                        adif_spec = :'adifv',
                                        last_update = CURRENT_TIMESTAMP;

\echo
--SELECT * FROM view_schema_info WHERE view_schema_info."Schema Name" = :'name';