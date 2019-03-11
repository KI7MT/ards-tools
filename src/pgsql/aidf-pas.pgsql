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