-- =============================================================================
--
--               ADIF PRIMARY ADMINISTRATION SUBDIVISION
--
-- =============================================================================

-- 5 Aland Is. -----------------------------------------------------------------

-- PAS-5 Table
CREATE TABLE adif.pas5
(
    pas5_id SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    code CHAR(4) NOT NULL, -- three char 001, 002, 003
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
    code CHAR(4) NOT NULL, -- two char AK
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
    code CHAR(4) NOT NULL, -- two char AA, BB, CC
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
    code CHAR(4) NOT NULL, -- two char IB, IC, ...
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
    code CHAR(4) NOT NULL, --two char MI, BR, HR
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
    code CHAR(4) NOT NULL, --two hcar CG, TF, ...
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
    code CHAR(4) NOT NULL, -- two char CE, ML, ...
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
    code CHAR(4) NOT NULL, -- three char COL, DF, EMX, ...
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
    code CHAR(4) NOT NULL, -- assuming two char 37, 39, 44, ...
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
    code CHAR(4) NOT NULL, -- two char SP, LO, KL, ...
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
    code CHAR(4) NOT NULL, -- three char AR, ...
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
    code CHAR(4) NOT NULL, -- two char 09, 08, 06, ...
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
    code CHAR(4) NOT NULL, -- two char AH, CH, CA, ...
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
    code CHAR(4) NOT NULL, -- two char BO, CA, CI ...
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
    code CHAR(4) NOT NULL, -- assuming two char ES, GO, SC, ...
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
    code CHAR(4) NOT NULL, -- assuming two char HI
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
    code CHAR(4) NOT NULL, -- two char KA, ...
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
    code CHAR(4) NOT NULL, -- two char AA, BB, CC, ...
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
    code CHAR(4) NOT NULL, -- three char 16, ASU, 11 
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
    code CHAR(4) NOT NULL, -- two char KI, ... 
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
    code CHAR(4) NOT NULL, -- two two char MO, CA, SJ, ... 
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
    code CHAR(4) NOT NULL, -- two char LH, ... 
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
    code CHAR(4) NOT NULL, -- two char AM, AN, AP, ... 
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
    code CHAR(4) NOT NULL, -- two char AC, ... 
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
    code CHAR(4) NOT NULL, -- three char ACT, SA, NSW, ...
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
    code CHAR(4) NOT NULL, -- two char LO, MV, ...
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
    code CHAR(4) NOT NULL, -- two char MA, ...
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
    code CHAR(4) NOT NULL, -- three char NCD, CPM, CPK, ...
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
    code CHAR(4) NOT NULL, -- three char AUK, BUP, NTL, ...
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
    code CHAR(4) NOT NULL, -- two char MT, ...
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
    code CHAR(4) NOT NULL, -- three char AAA, BBB, CCC, ...
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
CREATE TABLE adif.pas206
(
    pa206_id SERIAL PRIMARY KEY,
    pas206_region_id INT NOT NULL,
    code CHAR(4) NOT NULL, -- two char AM, BL, BN, ...
    subdivision VARCHAR(120) NOT NULL,
    before_date DATE, -- For QSO's Made BEFORE date
    after_date DATE, -- For QSO's made ON or AFTER date
    CONSTRAINT pas206_uq UNIQUE (code,subdivision)
);

-- PAS-206 Data
\COPY adif.pas206_region FROM 'adif-pas/pas206_region.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY adif.pas206 FROM 'adif-pas/pas206.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-206 FK
ALTER TABLE adif.pas206 ADD CONSTRAINT pas206_pas206_region_fkey
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
CREATE OR REPLACE VIEW adif.view_pas206 AS
    SELECT
        pas206_region.region AS "Region",
        pas206.code AS "Code",
        pas206.subdivision AS "Pri. Subdivision",
        pas206.before_date AS "Before Date",
        pas206.after_date AS "On or After Date"
    FROM adif.pas206
        JOIN adif.pas206_region ON
            adif.pas206_region.pas206_region_id = pas206.pas206_region_id
    ORDER BY pas206_region.region,pas206.subdivision;

-- 209 Belgium -----------------------------------------------------------------

-- PAS-209 Table
CREATE TABLE adif.pas209
(
    pas209_id SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    code CHAR(4) NOT NULL, -- two char AN, BR, BW, ...
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
CREATE TABLE adif.pas212
(
    pas212_id SERIAL PRIMARY KEY,
    pas212_region_id INT NOT NULL,
    code CHAR(4) NOT NULL, -- two char AM, BL, BN, ...
    subdivision VARCHAR(120) NOT NULL,
    CONSTRAINT pas212_uq UNIQUE (code,subdivision)
);

-- PAS-212
\COPY adif.pas212_region FROM 'adif-pas/pas212_region.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY adif.pas212 FROM 'adif-pas/pas212.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-212 FK
ALTER TABLE adif.pas212 ADD CONSTRAINT pas212_pas212_region_fkey
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
CREATE OR REPLACE VIEW adif.view_pas212 AS
    SELECT
        pas212_region.region AS "Region",
        pas212.code AS "Code",
        pas212.subdivision AS "Pri. Subdivision"
    FROM adif.pas212
        JOIN adif.pas212_region ON
            adif.pas212_region.pas212_region_id = pas212.pas212_region_id
    ORDER BY pas212_region.region;

-- 214 Corsica -----------------------------------------------------------------

-- PAS-214 Table
CREATE TABLE adif.pas214
(
    pas214_id SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    code CHAR(4) NOT NULL, -- two char 2A, 2B, ...
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
    code CHAR(4) NOT NULL, -- three char 015, 025, 055, ...
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
CREATE TABLE adif.pas224
(
    pas224_id SERIAL PRIMARY KEY,
    pas224_region_id INT NOT NULL,
    code CHAR(4) NOT NULL, -- three char 105, 106, 107, ...
    subdivision VARCHAR(120) NOT NULL,
    CONSTRAINT pas224_uq UNIQUE (code,subdivision)
);

-- PAS-224 Data
\COPY adif.pas224_region FROM 'adif-pas/pas224_region.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY adif.pas224 FROM 'adif-pas/pas224.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-224 FK
ALTER TABLE adif.pas224 ADD CONSTRAINT pas224_pas224_region_fkey
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
CREATE OR REPLACE VIEW adif.view_pas224 AS
    SELECT
        pas224_region.region AS "Region",
        pas224.code AS "Code",
        pas224.subdivision AS "Pri. Subdivision"
    FROM adif.pas224
        JOIN adif.pas224_region ON
            adif.pas224_region.pas224_region_id = pas224.pas224_region_id
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
CREATE TABLE adif.pas225
(
    pas225_id SERIAL PRIMARY KEY,
    pas225_region_id INT NOT NULL,
    code CHAR(4) NOT NULL, -- two char CA, CI, MD, ...
    subdivision VARCHAR(120) NOT NULL,
    import_only BOOLEAN NOT NULL DEFAULT '0',
    CONSTRAINT pas225_uq UNIQUE (code,subdivision)
);

-- PAS-225 Data
\COPY adif.pas225_region FROM 'adif-pas/pas225_region.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY adif.pas225 FROM 'adif-pas/pas225.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-225 FK
ALTER TABLE adif.pas225 ADD CONSTRAINT pas225_pas225_region_fkey
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
CREATE OR REPLACE VIEW adif.view_pas225 AS
    SELECT
        pas225_region.region AS "Region",
        pas225.code AS "Code",
        pas225.subdivision AS "Pri. Subdivision",
        pas225.import_only AS "Import Only"
    FROM adif.pas225
        JOIN adif.pas225_region ON
            adif.pas225_region.pas225_region_id = pas225.pas225_region_id
    ORDER BY pas225_region.region;

-- 227 France ------------------------------------------------------------------

-- PAS-227 Table
CREATE TABLE adif.pas227
(
    pas227_id SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    code CHAR(4) NOT NULL, -- two char 01, 02, 03, ...
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
    code CHAR(4) NOT NULL, -- assuming two char BB, BW, BW, ...
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
    code CHAR(4) NOT NULL, -- assuming two char GY, VA, ZA, ...
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
    code CHAR(4) NOT NULL, -- assuming two char CW, CN, CE, ...
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
CREATE TABLE adif.pas248
(
    pas248_id SERIAL PRIMARY KEY,
    pas248_region_id INT NOT NULL,
    code CHAR(4) NOT NULL, -- assuming two char BO, FE, FO, ...
    subdivision VARCHAR(120) NOT NULL,
    import_only BOOLEAN NOT NULL DEFAULT '0',
    CONSTRAINT pas248_uq UNIQUE (pas248_region_id,code,subdivision)
);

-- PAS-248 Data
\COPY adif.pas248_region FROM 'adif-pas/pas248_region.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY adif.pas248 FROM 'adif-pas/pas248.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-248 FK
ALTER TABLE adif.pas248 ADD CONSTRAINT pas248_pas248_region_fkey
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
CREATE OR REPLACE VIEW adif.view_pas248 AS
    SELECT
        pas248_region.region AS "Region",
        pas248.code AS "Code",
        pas248.subdivision AS "Pri. Subdivision",
        pas248.import_only AS "Import Only"
    FROM adif.pas248
        JOIN adif.pas248_region ON
            adif.pas248_region.pas248_region_id = pas248.pas248_region_id
    ORDER BY pas248_region.region;

-- 256 Maderia Is. -------------------------------------------------------------

-- TPAS-256 Table
CREATE TABLE adif.pas256
(
    pas256_id SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    code CHAR(4) NOT NULL, -- assuming two char MD, ...
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
    code CHAR(4) NOT NULL, -- two char DR, FR, GR, ...
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
    code CHAR(4) NOT NULL, -- two char AV, BJ, BR, ...
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
    code CHAR(4) NOT NULL, -- two char AR, CS, HD, ...
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
    code CHAR(4) NOT NULL, -- two char AV, BU, C, ...
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
    code CHAR(4) NOT NULL, -- two char AB, I, BD, ...
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
    code CHAR(4) NOT NULL, -- two char AG, AR, AI, ...
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
    code CHAR(4) NOT NULL, -- two char SU, TE, CH, ...
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
    code CHAR(4) NOT NULL, -- two letter state code
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
    code CHAR(4) NOT NULL, -- two char AH, BJ, CQ, ...
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

-- 327 Indonesia ---------------------------------------------------------------

-- PAS-327 Table
CREATE TABLE adif.pas327
(
    pas327_id SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    code CHAR(4) NOT NULL, -- two char BA, BB, BT, ...
    subdivision VARCHAR(120) NOT NULL,
    CONSTRAINT pas327_uq UNIQUE (code,subdivision)
);

-- PAS-327 Data
\COPY adif.pas327 FROM 'adif-pas/pas327.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-327 View
CREATE OR REPLACE VIEW adif.view_pas327 AS
    SELECT
        dxcc.dxcc_id AS "DXCC Code",
        dxcc.name AS "Country",
        pas327.code AS "Code",
        pas327.subdivision AS "Subdivision"
    FROM adif.pas327
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas327.dxcc_code
	ORDER BY adif.pas327.code;

-- 339 Japan -------------------------------------------------------------------

-- NOTE: Japan has Regions and Subdivisions

-- PAS-339 Table Region
CREATE TABLE adif.pas339_region
(
    pas339_region_id SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    region VARCHAR(20) NOT NULL,
    CONSTRAINT pas339_region_uq UNIQUE (region)
);

-- PAS-339 Table Subdivision
CREATE TABLE adif.pas339
(
    pas339_id SERIAL PRIMARY KEY,
    pas339_region_id INT NOT NULL,
    code CHAR(4) NOT NULL, -- two char 01, 02, 03, ...
    subdivision VARCHAR(20) NOT NULL,
    CONSTRAINT pas339_uq UNIQUE (code,subdivision)
);

-- PAS-339 Data
\COPY adif.pas339_region FROM 'adif-pas/pas339_region.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY adif.pas339 FROM 'adif-pas/pas339.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-339 Japan
ALTER TABLE adif.pas339 ADD CONSTRAINT pas339_pas339_region_fkey
    FOREIGN KEY (pas339_region_id) REFERENCES adif.pas339_region (pas339_region_id);

-- PAS-339 View Region
CREATE OR REPLACE VIEW adif.view_pas339_region AS
    SELECT
        dxcc.dxcc_id AS "DXCC Code",
        dxcc.name AS "Country",
        pas339_region.region AS "Region"
    FROM adif.pas339_region
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas339_region.dxcc_code
    ORDER BY adif.pas339_region.region;

-- PAS-339 View Subdivision
CREATE OR REPLACE VIEW adif.view_pas339 AS
    SELECT
        pas339_region.region AS "Region",
        pas339.code AS "Code",
        pas339.subdivision AS "Pri. Subdivision"
    FROM adif.pas339
        JOIN adif.pas339_region ON
            adif.pas339_region.pas339_region_id = pas339.pas339_region_id
    ORDER BY pas339_region.region;

-- 375 Philippines -------------------------------------------------------------

-- NOTE: Philippines has Regions and Subdivisions

-- PAS-375 Table Region
CREATE TABLE adif.pas375_region
(
    pas375_region_id SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    region VARCHAR(60) NOT NULL,
    CONSTRAINT pas375_region_uq UNIQUE (region)
);

-- PAS-375 Table Subdivision
CREATE TABLE adif.pas375
(
    pas375_id SERIAL PRIMARY KEY,
    pas375_region_id INT NOT NULL,
    code CHAR(4) NOT NULL, -- three char AUR, BTG, CAV, ...
    subdivision VARCHAR(120) NOT NULL,
    CONSTRAINT pas375_uq UNIQUE (code,subdivision)
);

-- PAS-375 Data
\COPY adif.pas375_region FROM 'adif-pas/pas375_region.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY adif.pas375 FROM 'adif-pas/pas375.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-375 FK
ALTER TABLE adif.pas375 ADD CONSTRAINT pas375_pas375_region_fkey
    FOREIGN KEY (pas375_region_id) REFERENCES adif.pas375_region (pas375_region_id);

-- PAS-375 View Region
CREATE OR REPLACE VIEW adif.view_pas375_region AS
    SELECT
        dxcc.dxcc_id AS "DXCC Code",
        dxcc.name AS "Country",
        pas375_region.region AS "Region"
    FROM adif.pas375_region
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas375_region.dxcc_code
    ORDER BY adif.pas375_region.region;

-- PAS-375 View Subdivision
CREATE OR REPLACE VIEW adif.view_pas375 AS
    SELECT
        pas375_region.region AS "Region",
        pas375.code AS "Code",
        pas375.subdivision AS "Pri. Subdivision"
    FROM adif.pas375
        JOIN adif.pas375_region ON
            adif.pas375_region.pas375_region_id = pas375.pas375_region_id
    ORDER BY pas375_region.region;

-- 386 Taiwan ------------------------------------------------------------------

-- PAS-386 Table
CREATE TABLE adif.pas386
(
    pas386_id SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    code CHAR(4) NOT NULL, -- two char DAS, DAO, CAM, ...
    subdivision VARCHAR(120) NOT NULL,
    CONSTRAINT pas386_uq UNIQUE (code,subdivision)
);

-- PAS-386 Date
\COPY adif.pas386 FROM 'adif-pas/pas386.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-386 View
CREATE OR REPLACE VIEW adif.view_pas386 AS
    SELECT
        dxcc.dxcc_id AS "DXCC Code",
        dxcc.name AS "Country",
        pas386.code AS "Code",
        pas386.subdivision AS "Subdivision"
    FROM adif.pas386
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas386.dxcc_code
	ORDER BY adif.pas386.code;

-- 387 Thailand ----------------------------------------------------------------

-- PAS-387 Table
CREATE TABLE adif.pas387
(
    pas387_id SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    code CHAR(4) NOT NULL, -- two char 37, 25, 81, ...
    subdivision VARCHAR(120) NOT NULL,
    CONSTRAINT pas387_uq UNIQUE (code,subdivision)
);

-- PAS-387 Data
\COPY adif.pas387 FROM 'adif-pas/pas387.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-387 View
CREATE OR REPLACE VIEW adif.view_pas387 AS
    SELECT
        dxcc.dxcc_id AS "DXCC Code",
        dxcc.name AS "Country",
        pas387.code AS "Code",
        pas387.subdivision AS "Subdivision"
    FROM adif.pas387
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas387.dxcc_code
	ORDER BY adif.pas387.code;

-- 497 Croatia -----------------------------------------------------------------

-- TODO: view_pas497
CREATE TABLE adif.pas497
(
    pas497_id SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    code CHAR(4) NOT NULL, -- two char 01, 02, 03, ...
    subdivision VARCHAR(120) NOT NULL,
    CONSTRAINT pas497_uq UNIQUE (code,subdivision)
);

-- PAS-497
\COPY adif.pas497 FROM 'adif-pas/pas497.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-497 View
CREATE OR REPLACE VIEW adif.view_pas497 AS
    SELECT
        dxcc.dxcc_id AS "DXCC Code",
        dxcc.name AS "Country",
        pas497.code AS "Code",
        pas497.subdivision AS "Subdivision"
    FROM adif.pas497
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas497.dxcc_code
	ORDER BY adif.pas497.code;

-- 503 Czech Republic ----------------------------------------------------------

-- NOTE: Czech Republic has Regions and Subdivisions

-- PAS-503 Table Region
CREATE TABLE adif.pas503_region
(
    pas503_region_id SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    region VARCHAR(120) NOT NULL,
    CONSTRAINT pas503_region_uq UNIQUE (region)
);

-- TODO: view_pas503
CREATE TABLE adif.pas503
(
    pas503_id SERIAL PRIMARY KEY,
    pas503_region_id INT NOT NULL,
    code CHAR(4) NOT NULL, -- two char APA, APB, APC, ...
    subdivision VARCHAR(120) NOT NULL,
    CONSTRAINT pas503_uq UNIQUE (code,subdivision)
);

-- PAS-503 Data
\COPY adif.pas503_region FROM 'adif-pas/pas503_region.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY adif.pas503 FROM 'adif-pas/pas503.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-503 FK
ALTER TABLE adif.pas503 ADD CONSTRAINT pas503_pas503_region_fkey
    FOREIGN KEY (pas503_region_id) REFERENCES adif.pas503_region (pas503_region_id);

-- PAS-503 View Region
CREATE OR REPLACE VIEW adif.view_pas503_region AS
    SELECT
        dxcc.dxcc_id AS "DXCC Code",
        dxcc.name AS "Country",
        pas503_region.region AS "Region"
    FROM adif.pas503_region
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas503_region.dxcc_code
    ORDER BY adif.pas503_region.region;

-- PAS-503 View Subdivision
CREATE OR REPLACE VIEW adif.view_pas503 AS
    SELECT
        pas503_region.region AS "Region",
        pas503.code AS "Code",
        pas503.subdivision AS "Pri. Subdivision"
    FROM adif.pas503
        JOIN adif.pas503_region ON
            adif.pas503_region.pas503_region_id = pas503.pas503_region_id
    ORDER BY pas503_region.region;

-- 504 Slovak Republic ---------------------------------------------------------

-- NOTE: Slovak Republic has Regions and Subdivisions

-- PAS-504 Table Region
CREATE TABLE adif.pas504_region
(
    pas504_region_id SERIAL PRIMARY KEY,
    dxcc_code INT NOT NULL,
    region VARCHAR(120) NOT NULL,
    CONSTRAINT pas504_region_uq UNIQUE (region)
);

-- TODO: view_pas504
CREATE TABLE adif.pas504
(
    pas504_id SERIAL PRIMARY KEY,
    pas504_region_id INT NOT NULL,
    code CHAR(4) NOT NULL, -- two char APA, APB, APC, ...
    subdivision VARCHAR(120) NOT NULL,
    CONSTRAINT pas504_uq UNIQUE (code,subdivision)
);

-- PAS-504 Data
\COPY adif.pas504_region FROM 'adif-pas/pas504_region.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY adif.pas504 FROM 'adif-pas/pas504.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-504 FK
ALTER TABLE adif.pas504 ADD CONSTRAINT pas504_pas504_region_fkey
    FOREIGN KEY (pas504_region_id) REFERENCES adif.pas504_region (pas504_region_id);

-- PAS-504 View Region
CREATE OR REPLACE VIEW adif.view_pas504_region AS
    SELECT
        dxcc.dxcc_id AS "DXCC Code",
        dxcc.name AS "Country",
        pas504_region.region AS "Region"
    FROM adif.pas504_region
        JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas504_region.dxcc_code
    ORDER BY adif.pas504_region.region;

-- PAS-504 View Subdivision
CREATE OR REPLACE VIEW adif.view_pas504 AS
    SELECT
        pas504_region.region AS "Region",
        pas504.code AS "Code",
        pas504.subdivision AS "Pri. Subdivision"
    FROM adif.pas504
        JOIN adif.pas504_region ON
            adif.pas504_region.pas504_region_id = pas504.pas504_region_id
    ORDER BY pas504_region.region;



-- =============================================================================
--
--               ADIF SECONDARY ADMINISTRATION SUBDIVISION
--
-- =============================================================================


-- JARL JCC (Ku) ---------------------------------------------------------------

-- Japan Century Cities (JCC), SWL - Japan Century Cites (SWL - JCC)
-- Info Link   : https://www.jarl.org/English/4_Library/A-4-2_Awards/Aw_jcc.htm
-- Source Link : https://www.jarl.org/English/4_Library/A-4-5_jcc-jcg/jcc-list.txt

-- JARL JCC PREFECTURES
CREATE TABLE adif.jarl_jcc
(
    id SERIAL PRIMARY KEY,
    prefecture VARCHAR(30) NOT NULL,
    prefix CHAR(2) NOT NULL,
    CONSTRAINT jarl_jcc_uq UNIQUE(prefecture)
);

-- JARL JCC CITIES
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

-- JARL JCC DATA
\COPY adif.jarl_jcc FROM 'adif-sas/jarl_jcc.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY adif.jarl_jcc_city FROM 'adif-sas/jarl_jcc_city.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- JARL JCC FK
ALTER TABLE adif.jarl_jcc_city ADD CONSTRAINT jarl_jcc_city_jarl_jcc_fkey
    FOREIGN KEY (jcc_id) REFERENCES adif.jarl_jcc (id);

CREATE OR REPLACE VIEW adif.view_jcc_stats AS
    SELECT 
        adif.jarl_jcc.prefecture AS "Precefture",
        count(*) AS "City Count"
    FROM adif.jarl_jcc
        JOIN adif.jarl_jcc_city ON
            adif.jarl_jcc_city.jcc_id = jarl_jcc.id
    GROUP BY jarl_jcc.prefecture
    ORDER BY jarl_jcc.prefecture;

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

-- RDXC Data (Oblasts and Districts)
\COPY adif.rdxc FROM 'adif-sas/rdxc.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY adif.rdxc_district FROM 'adif-sas/rdxc_district.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- RDXC District FK
ALTER TABLE adif.rdxc_district ADD CONSTRAINT rdxc_district_rdxc_fkey
    FOREIGN KEY (rdxc_id) REFERENCES adif.rdxc (rdxc_id);

-- RDXC Oblast Stats
-- RDXC Oblasts Numbers do not match the 3.0.9 Spec
-- RDXC Number from the source dont match what's published by v3.0.9 Spec
CREATE OR REPLACE VIEW adif.view_rdxc_count_all AS
SELECT 
	rdxc.rdxc_code AS "RDXC Code",
    rdxc.prefix AS "Prefix", 
	rdxc.oblast AS "Oblast", 
	count(*) AS "District Count"
	FROM adif.rdxc JOIN adif.rdxc_district ON (rdxc_district.rdxc_id = rdxc.rdxc_id)
	WHERE rdxc.is_deleted = 'false' 
GROUP BY rdxc.oblast, rdxc.rdxc_code, rdxc.prefix 
ORDER BY rdxc.rdxc_code;