/*
-- 327 Indonesia ---------------------------------------------------------------

-- TODO: view_pas_327
CREATE TABLE adif.pas_327
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char BA, BB, BT, ...
    subdivision VARCHAR(120) NOT NULL,
    CONSTRAINT pas_327_uq UNIQUE (code,subdivision)
);

-- 339 Japan -------------------------------------------------------------------

-- NOTE: Japan has Regions and Subdivisions
-- TODO: view_pas_327_region
CREATE TABLE adif.pas_339_region
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    region VARCHAR(20) NOT NULL,
    CONSTRAINT pas_339_region_uq UNIQUE (region)
);

-- TODO: view_pas_327_subdivision
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
-- TODO: view_pas_375_region
CREATE TABLE adif.pas_375_region
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    region VARCHAR(60) NOT NULL,
    CONSTRAINT pas_375_region_uq UNIQUE (region)
);

-- TODO: Need CSV Data
-- TODO: view_pas_375_subdivision
CREATE TABLE adif.pas_375_subdivision
(
    id SERIAL PRIMARY KEY,
    pas_375_region_id INT NOT NULL,
    code CHAR(3) NOT NULL, -- three char AUR, BTG, CAV, ...
    subdivision VARCHAR(120) NOT NULL,
    CONSTRAINT pas_375_subdivision_uq UNIQUE (code,subdivision)
);

-- 386 Taiwan ------------------------------------------------------------------

-- TODO: view_pas_386
CREATE TABLE adif.pas_386
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(3) NOT NULL, -- two char DAS, DAO, CAM, ...
    subdivision VARCHAR(120) NOT NULL,
    CONSTRAINT pas_386_uq UNIQUE (code,subdivision)
);

-- 387 Thailand ----------------------------------------------------------------

-- TODO: view_pas_387
CREATE TABLE adif.pas_387
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char 37, 25, 81, ...
    subdivision VARCHAR(120) NOT NULL,
    CONSTRAINT pas_387_uq UNIQUE (code,subdivision)
);

-- 497 Croatia -----------------------------------------------------------------

-- TODO: view_pas_497
CREATE TABLE adif.pas_497
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char 01, 02, 03, ...
    subdivision VARCHAR(120) NOT NULL,
    CONSTRAINT pas_497_uq UNIQUE (code,subdivision)
);

-- 503 Czech Republic ----------------------------------------------------------

-- NOTE: Czech Republic has Regions and Subdivisions
-- TODO: view_pas_503_region
CREATE TABLE adif.pas_503_region
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    region VARCHAR(60) NOT NULL,
    CONSTRAINT pas_503_region_uq UNIQUE (region)
);

-- TODO: view_pas_503_subdivision
CREATE TABLE adif.pas_503_subdivision
(
    id SERIAL PRIMARY KEY,
    pas_503_region_id INT NOT NULL,
    code CHAR(3) NOT NULL, -- two char APA, APB, APC, ...
    subdivision VARCHAR(120) NOT NULL,
    CONSTRAINT pas_503_subdivision_uq UNIQUE (code,subdivision)
);

-- 504 Slovak Republic ---------------------------------------------------------

-- NOTE: Slovak Republic has Regions and Subdivisions
-- TODO: view_pas_504_region
CREATE TABLE adif.pas_504_region
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    region VARCHAR(60) NOT NULL,
    CONSTRAINT pas_504_region_uq UNIQUE (region)
);

-- TODO: view_pas_504_subdivision
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

-- PAS-327
\COPY pas_327 FROM 'adif-pas/pas_327.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-339
\COPY pas_339_region FROM 'adif-pas/pas_339_region.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY pas_339_subdivision FROM 'adif-pas/pas_339_subdivision.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-375
\COPY pas_375_region FROM 'adif-pas/pas_375_region.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY pas_375_subdivision FROM 'adif-pas/pas_375_subdivision.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-386
\COPY pas_386 FROM 'adif-pas/pas_386.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-387
\COPY pas_387 FROM 'adif-pas/pas_387.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-497
\COPY pas_497 FROM 'adif-pas/pas_497.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-503
\COPY pas_503_region FROM 'adif-pas/pas_503_region.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY pas_503_subdivision FROM 'adif-pas/pas_503_subdivision.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-504
\COPY pas_504_region FROM 'adif-pas/pas_504_region.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY pas_504_subdivision FROM 'adif-pas/pas_504_subdivision.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- *****************************************************************************
--  ADD FOREIGN KEYS
-- *****************************************************************************

-- PAS-318 China ---------------------------------------------------------------
ALTER TABLE pas318 ADD CONSTRAINT pas318_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES dxcc (dxcc_id);

-- PAS-327 Indonesia -----------------------------------------------------------
ALTER TABLE pas_327 ADD CONSTRAINT pas_327_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES dxcc (dxcc_id);

-- PAS-339 Japan ---------------------------------------------------------------
ALTER TABLE pas_339_region ADD CONSTRAINT pas_339_region_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES dxcc (dxcc_id);

ALTER TABLE pas_339_subdivision ADD CONSTRAINT pas_339_subdivision_pas_339_region_fkey
    FOREIGN KEY (pas_339_region_id) REFERENCES pas_339_region (id);

-- PAS-375 Philippines ---------------------------------------------------------
ALTER TABLE pas_375_region ADD CONSTRAINT pas_375_region_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES dxcc (dxcc_id;

ALTER TABLE pas_375_subdivision ADD CONSTRAINT pas_375_subdivision_pas_375_region_fkey
    FOREIGN KEY (pas_375_region_id) REFERENCES pas_375_region (id);

-- PAS-386 Taiwan --------------------------------------------------------------
ALTER TABLE pas_386 ADD CONSTRAINT pas_386_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES dxcc (dxcc_id);

-- PAS-387 Thailand ------------------------------------------------------------
ALTER TABLE pas_387 ADD CONSTRAINT pas_387_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES dxcc (dxcc_id);

-- PAS-497 Crotia ------------------------------------------------------------------
ALTER TABLE pas_497 ADD CONSTRAINT pas_497_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES dxcc (dxcc_id);

-- 503 Czech Republic ----------------------------------------------------------
ALTER TABLE pas_503_region ADD CONSTRAINT pas_503_region_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES dxcc (dxcc_id);

ALTER TABLE pas_503_subdivision ADD CONSTRAINT pas_503_subdivision_pas_503_region_fkey
    FOREIGN KEY (pas_503_region_id) REFERENCES pas_503_region (id);

-- 504 Slovak Republic ---------------------------------------------------------
ALTER TABLE pas_504_region ADD CONSTRAINT pas_504_region_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES dxcc (dxcc_id);

ALTER TABLE pas_504_subdivision ADD CONSTRAINT pas_504_subdivision_pas_504_region_fkey
    FOREIGN KEY (pas_504_region_id) REFERENCES pas_504_region (id);


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

-- view_pas_summary -------------------------------------------------------
CREATE OR REPLACE VIEW adif.view_pas_summary AS
    SELECT
        dxcc.dxcc_code AS "DXCC Code",
        dxcc.name AS "Country",
        pas_subdivision_type.pas_subdivision_type AS "Pri. Subdivision",
        pas_summary.has_oblast AS "Has Oblast",
        pas_summary.has_sas AS "Has Secondary",
        sas_subdivision_type.sas_subdivision_type AS "Sec. Subdivision"
    FROM adif.pas_summary
        LEFT JOIN dxcc ON
            dxcc.dxcc_id = pas_summary.dxcc_id
        LEFT JOIN pas_subdivision_type ON
            pas_summary.pas_subdivision_type_id = pas_subdivision_type.id
        LEFT JOIN sas_subdivision_type ON
            pas_summary.sas_subdivision_type_id = sas_subdivision_type.id
    ORDER BY adif.pas_summary.id;

-- view_pas_subdivision_type ----------------------------------------------
CREATE OR REPLACE VIEW view_pas_subdivision_type AS
    SELECT
        pas_subdivision_type AS "Pri. Subdivision"
    FROM pas_subdivision_type
    ORDER BY pas_subdivision_type;

-- view_sas_subdivision_type ----------------------------------------------
CREATE OR REPLACE VIEW view_sas_subdivision_type AS
    SELECT
        sas_subdivision_type AS "Sec. Subdivision"
    FROM sas_subdivision_type
    ORDER BY sas_subdivision_type;

-- *****************************************************************************
--  FOOTER
-- *****************************************************************************
\echo
SELECT * FROM view_schema_info WHERE view_schema_info."Schema Name" = :'name';

-- =============================================================================
--
--
--                       ADIF SECONDARY SUBDIVISION
--
--
-- =============================================================================

-- JARL Ku ---------------------------------------------------------------------
-- Japan Century Cities (JCC), SWL - Japan Century Cites (SWL - JCC)
-- Info Link   : https://www.jarl.org/English/4_Library/A-4-2_Awards/Aw_jcc.htm
-- Source Link : https://www.jarl.org/English/4_Library/A-4-5_jcc-jcg/jcc-list.txt

CREATE TABLE adif.jarl_jcc
(
    id SERIAL PRIMARY KEY,
    prefecture VARCHAR(30) NOT NULL,
    prefix CHAR(2) NOT NULL,
    CONSTRAINT jarl_jcc_uq UNIQUE(prefecture)
);

CREATE TABLE adif.jarl_jcc_city
(
    id SERIAL PRIMARY KEY,
    jcc_id INT NOT NULL,
    number CHAR(6),
    city VARCHAR(30),
    is_deleted BOOLEAN NOT NULL DEFAULT '0',
    deleted_date date,
    CONSTRAINT jarl_jcc_city_uq UNIQUE(number,city)
);

-- RDXC Oblasts ----------------------------------------------------------------
CREATE TABLE adif.rdxc
(
    id SERIAL PRIMARY KEY,
    prefix CHAR(4) NOT NULL,
    rdxc_code CHAR(2) NOT NULL,
    oblast VARCHAR(60) NOT NULL,
    is_deleted BOOLEAN NOT NULL DEFAULT '0',
    CONSTRAINT rdxc_uq UNIQUE(prefix,rdxc_code,oblast)
);

CREATE TABLE adif.rdxc_district
(
    id SERIAL PRIMARY KEY,
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

-- *****************************************************************************
--  ADD CSV DATA
-- *****************************************************************************

-- NOTE(s): 
-- Note: All CSV File use "|" as the delimiter.

\echo
\echo 'Importing SAS CSV Files'
\echo '---------------------------'
\COPY jarl_jcc FROM 'adif-sas/jarl_jcc.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY jarl_jcc_city FROM 'adif-sas/jarl_jcc_city.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY rdxc FROM 'adif-sas/rdxc.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY rdxc_district FROM 'adif-sas/rdxc_district.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- *****************************************************************************
--  ADD FOREIGN KEYS
-- *****************************************************************************

\echo
\echo 'Adding Foreign Keys'
\echo '---------------------------'

-- JARL JCC --------------------------------------------------------------------
ALTER TABLE jarl_jcc_city ADD CONSTRAINT jarl_jcc_city_jarl_jcc_fkey
    FOREIGN KEY (jcc_id) REFERENCES jarl_jcc (id);


-- RDA RDXC --------------------------------------------------------------------
ALTER TABLE rdxc_district ADD CONSTRAINT rdxc_district_rdxc_fkey
    FOREIGN KEY (rdxc_id) REFERENCES rdxc (id);

/*
SELECT 
	jarl_jcc.prefecture AS "Precefture",
	count(*) AS "City Count"
	FROM jarl_jcc JOIN jarl_jcc_city ON
        (
            jarl_jcc_city.jcc_id = jarl_jcc.id
        )
GROUP BY jarl_jcc.prefecture
ORDER BY jarl_jcc.prefecture;

SELECT 
	rdxc.rdxc_code AS "RDXC Code",
    rdxc.prefix AS "Prefix", 
	rdxc.oblast AS "Oblast", 
	count(*) AS "District Count"
	FROM rdxc JOIN rdxc_district ON (rdxc_district.rdxc_id = rdxc.id)
	WHERE rdxc_district.is_deleted = '0'
GROUP BY rdxc.oblast, rdxc.rdxc_code, rdxc.prefix 
ORDER BY rdxc.rdxc_code;


SELECT 
	rdxc.rdxc_code AS "RDXC Code",
    rdxc.prefix AS "Prefix", 
	rdxc.oblast AS "Oblast", 
	count(*) AS "District Count"
	FROM rdxc JOIN rdxc_district ON (rdxc_district.rdxc_id = rdxc.id)
	WHERE rdxc.is_deleted = 'false' 
GROUP BY rdxc.oblast, rdxc.rdxc_code, rdxc.prefix 
ORDER BY rdxc.rdxc_code;

For future consolidation
CREATE OR REPLACE FUNCTION adif.get_pas (dx_var CHAR) 
RETURNS TABLE (
    country VARCHAR,
    dxcc_code INT,
    code CHAR,
    subdivision VARCHAR,
    is_deleted BOOLEAN
) 
AS $$
BEGIN
    RETURN QUERY SELECT
    dxcc_code AS "Code",
    dxcc.name AS "Country",
    code,
    subdivision,
    id_deleted
    FROM dx_var
        JOIN dxcc ON
            dxcc.dxcc_id = dx_var.dxcc_code
    WHERE dxcc_code = dx_var.dxcc_code;
END; $$ 
LANGUAGE 'plpgsql';

*/