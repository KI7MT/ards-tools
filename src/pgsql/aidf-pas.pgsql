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