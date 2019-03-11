-- -----------------------------------------------------------------------------
-- Primary Administrative Subdivision
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

-- PAS Type
CREATE TABLE adif.pas_type
(
    pas_type_id SERIAL PRIMARY KEY,
    pas_type VARCHAR(120) NOT NULL,
);
