-- -----------------------------------------------------------------------------
--
--                  Primary Administrative Subdivision
--
-- -----------------------------------------------------------------------------

DROP TABLE IF EXISTS adif.pas;

CREATE TABLE adif.pas
(
    pas_id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,                           -- DXCC Country
    pas_region_id INT,                              -- Region, if applicable
    pas_code CHAR(4) NOT NULL,                      -- code for the subdivision
    subdivision VARCHAR(120) NOT NULL,              -- subdivision name
    oblast VARCHAR(90),                             -- Oblast number
    referred_to_as VARCHAR(60),                     -- Alias Names
    is_deleted BOOLEAN DEFAULT '0',                 -- is a deleted subdivision
    is_import_only BOOLEAN DEFAULT '0',             -- Can only be imported
    before_date DATE,                               -- For QSO's Made BEFORE date
    after_date DATE,                                -- For QSO's made ON or AFTER date
    CONSTRAINT pas_uq UNIQUE (dxcc_id,pas_code,subdivision)
);

-- PAS Region
DROP TABLE IF EXISTS adif.pas_region;

CREATE TABLE adif.pas_region
(
    pas_region_id SERIAL PRIMARY KEY,
    region VARCHAR(120) NOT NULL,
    CONSTRAINT pas_region_uq UNIQUE (region)
);

-- PAS CQ Zone
DROP TABLE IF EXISTS adif.pas_cqzone;

CREATE TABLE adif.pas_cqzone
(
    pas_cqzone_id SERIAL PRIMARY KEY,
    pas_id INT NOT NULL,
    cqzone_id INT NOT NULL
);

-- PAS ITU Zone
DROP TABLE IF EXISTS adif.pas_ituzone;

CREATE TABLE adif.pas_ituzone
(
    pas_ituzone_id SERIAL PRIMARY KEY,
    pas_id INT NOT NULL,
    ituzone_id INT NOT NULL
);



-- -----------------------------------------------------------------------------
-- PAS SUMMARY Tables
-- -----------------------------------------------------------------------------

-- Primary Administration Subdivision Summary ----------------------------------
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

-- Secondary Administration Subdivision
CREATE TABLE adif.sas_type
(
    sas_type_id SERIAL PRIMARY KEY,
    sas_type VARCHAR(20) NOT NULL,
    CONSTRAINT sas_type_uq UNIQUE (sas_type)
);

-- PAS Summary Data
\COPY adif.pas_type FROM 'adif-pas/pas_type.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY adif.sas_type FROM 'adif-pas/sas_type.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY adif.pas_summary FROM 'adif-pas/pas_summary.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS Summary FK's
ALTER TABLE adif.pas_summary ADD CONSTRAINT pas_summary_pas_type_fkey
    FOREIGN KEY (pas_type_id) REFERENCES adif.pas_type (pas_type_id);

ALTER TABLE adif.pas_summary ADD CONSTRAINT pas_summary_sas_type_fkey
    FOREIGN KEY (sas_type_id) REFERENCES adif.sas_type (sas_type_id);

-- view_pas_summary
CREATE OR REPLACE VIEW adif.view_pas_summary AS
    SELECT
        dxcc.dxcc_id AS "DXCC Code",
        dxcc.name AS "Country",
        pas_type.pas_type AS "Pri. Subdivision",
        pas_summary.has_oblast AS "Has Oblast",
        pas_summary.has_sas AS "Has Secondary",
        sas_type.sas_type AS "Sec. Subdivision"
    FROM adif.pas_summary
        LEFT JOIN adif.dxcc ON
            adif.dxcc.dxcc_id = pas_summary.dxcc_code
        LEFT JOIN adif.pas_type ON
            adif.pas_summary.pas_type_id = adif.pas_type.pas_type_id
        LEFT JOIN adif.sas_type ON
            adif.pas_summary.sas_type_id = adif.sas_type.sas_type_id
    ORDER BY adif.pas_summary.pas_summary_id;

-- view_pas_type
CREATE OR REPLACE VIEW adif.view_pas_type AS
    SELECT
        pas_type AS "Pri. Subdivision"
    FROM adif.pas_type
    ORDER BY pas_type;

-- view_sas_type 
CREATE OR REPLACE VIEW adif.view_sas_type AS
    SELECT
        sas_type AS "Sec. Subdivision"
    FROM adif.sas_type
    ORDER BY sas_type;
