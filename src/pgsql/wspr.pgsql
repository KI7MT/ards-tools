/* 

    Project .............: ARDS Tools
    Author ..............: Greg, Beam, KI7MT, <ki7mt@yahoo.com>
    Copyright ...........: Copyright (C) 2018-2019 Greg Beam, KI7MT
    License .............: GPL-3

    File ................: wspr.pgsql
    Description .........: WSPR Data Tables, Views and Materalized Views
    Database Type .......: PostgreSQL v10 or later
    Version .............: 0.0.1
    ADIF Specification ..: 3.0.9

    Tool Requirments:

    * PostgreSQL v10 or above
    * Access to Curl (Native Linux, WSL, Powershell, WinSSL, other)

    Installation and Usage Instrucitons
    
    1. Download and update table for wsprspots-year-month.csv

        * Clone the repository

            git clone https://github.com/KI7MT/ards-tools.git

    2. Set PGPASSWORD Database / User Password

        Win32
            set PGPASSWORD=ards
        Linux
            export PGPASSWORD=ards

    3. In the Terminal, run the following command:

       psql -v ON_ERROR_STOP=1 -U ards -w -f wspr.pgsql

    4. After installation, run the following query to test the installaiton:

       psql -U postgres -c "select * from wspr.wspr_test_view"

*/

-- *****************************************************************************
--  BEGIN TABLE GENERATION and IMPORT
-- *****************************************************************************

-- Script Variables
\set name wspr
\set ver 0.0.1
\set adifv 0.0.0

\! clear
\echo ''
\echo '-------------------------------------'
\echo Regenerating Schema for ( :name )
\echo '-------------------------------------'

-- Drop, and re-create schema
DROP SCHEMA IF EXISTS :name CASCADE;

-- Create New Schema
CREATE SCHEMA :name;

INSERT INTO ards.schema_info(schema_name, schema_version, adif_spec, last_update)
VALUES(:'name', :'ver', :'adifv', CURRENT_TIMESTAMP)
ON CONFLICT (schema_name) DO UPDATE SET schema_version = :'ver',
                                        adif_spec = :'adifv',
                                        last_update = CURRENT_TIMESTAMP;

-- *****************************************************************************
--  Normal Form Tables (NF2/NF3)
-- *****************************************************************************

\echo ''
\echo '-------------------------------------'
\echo Create Tables for ( :name )
\echo '-------------------------------------'

-- Spot Table (NF3)
-- FKEY (rxcall_id) REFERENCES wspr.callsign (id);
-- FKEY (rxgrid_id) REFERENCES wspr.grid (id);
-- FKEY (txcall_id) REFERENCES wspr.callsign (id);
-- FKEY (txgrid_id) REFERENCES wspr.grid (id);
-- FKEY (band_id) REFERENCES wspr.namd (id);
-- FKEY (sw_version_id) REFERENCES wspr.software_version (id);
CREATE TABLE wspr.spot
(
    id BIGINT NOT NULL,           -- spot_id
    time_stamp INTEGER NOT NULL,  -- timestamp
    rxcall_id INTEGER,            -- Reporter callsign
    rxgrid_id INTEGER,            -- Reporter Grid
    snr SMALLINT,                 -- snr
    frequency NUMERIC(10,6),      -- frequency
    txcall_id INTEGER,            -- Transmitting Station Call
    txgrid_id INTEGER,            -- Transmitting Station Grid
    power SMALLINT,               -- power
    drift SMALLINT,               -- drift
    distance SMALLINT,            -- distance
    azimuth SMALLINT,             -- azimuth
    band_id SMALLINT,             -- band
    sw_version_id SMALLINT,       -- version
    code SMALLINT,                -- code
    CONSTRAINT spot_id_pkey PRIMARY KEY (id)
);

-- wspr.rxcall
-- IDX: wspr.callsign_idx
CREATE TABLE wspr.callsign
(
    id SERIAL,
    call VARCHAR(15),
    UNIQUE (call),
    CONSTRAINT callsign_id_pkey PRIMARY KEY (id)
);

-- wspr.grid
-- IDX: wspr.grid_idx
CREATE TABLE wspr.grid
(
    id SERIAL,
    grid VARCHAR(8),
    UNIQUE (grid),
    CONSTRAINT grid_id_pkey PRIMARY KEY (id)
);

-- wspr.band
-- IDX: wspr.band_idx
CREATE TABLE wspr.band
(
    id SERIAL,
    band SMALLINT,
    UNIQUE (band),
    CONSTRAINT band_id_pkey PRIMARY KEY (id)
);

-- wspr.software_version
-- IDX: wspr.software_version_idx
CREATE TABLE wspr.software_version
(
    id SERIAL,
    sw_version VARCHAR(20),
    UNIQUE (sw_version),
    CONSTRAINT software_version_id_pkey PRIMARY KEY (id)
);

-- WSPR Daily Spot CSV
-- Requires WSPR CSV Conversion of EPOCH (unix time) to Date | Time Columns
-- Schema-1: 15 Fields
CREATE TABLE wspr.raw_csv
(
    spot INTEGER NOT NULL,        -- unique identifier from WSPRnet
    time_stamp INTEGER NOT NULL,  -- EPOCH Timespamp 
    rx_call VARCHAR(15),          -- Recieve Station callsign
    rx_grid VARCHAR(8),           -- Recieve station grid square
    snr SMALLINT,                 -- range -100 db to +100 db
    frequency NUMERIC(10,6),      -- 9999.123456 MHZ
    tx_call VARCHAR(15),          -- Transmitting Station Call
    tx_grid VARCHAR(8),           -- Transmitting Station Grid
    power SMALLINT,               -- TX Power: range -99 to +99 in db
    drift SMALLINT,               -- Drift: range -99 to +99 in Herts (hz)
    distance SMALLINT,            -- Dinstace grid to grid in Kilometers (km)
    azimuth SMALLINT,             -- Direction, in degrees, from tx_call to rx_call
    band SMALLINT,                -- Band ELF to whatever
    software_version VARCHAR(20), -- Software version being used
    code SMALLINT,                -- Non-zero values will indicatea bad spot is likely
    CONSTRAINT raw_csv_spot_pkey PRIMARY KEY (spot)
);

-- *****************************************************************************
--  FKEY
-- *****************************************************************************

\echo ''
\echo '-------------------------------------'
\echo Add Foreign Keys for ( :name )
\echo '-------------------------------------'

ALTER TABLE wspr.spot ADD CONSTRAINT spot_rxcall_fkey
    FOREIGN KEY (rxcall_id) REFERENCES wspr.callsign (id);

ALTER TABLE wspr.spot ADD CONSTRAINT spot_rxgrid_fkey
    FOREIGN KEY (rxgrid_id) REFERENCES wspr.grid (id);

ALTER TABLE wspr.spot ADD CONSTRAINT spot_txcall_fkey
    FOREIGN KEY (txcall_id) REFERENCES wspr.callsign (id);

ALTER TABLE wspr.spot ADD CONSTRAINT spot_txgrid_fkey
    FOREIGN KEY (txgrid_id) REFERENCES wspr.grid (id);

ALTER TABLE wspr.spot ADD CONSTRAINT spot_band_fkey
    FOREIGN KEY (band_id) REFERENCES wspr.band (id);

ALTER TABLE wspr.spot ADD CONSTRAINT spot_sw_versoin_fkey
    FOREIGN KEY (sw_version_id) REFERENCES wspr.software_version (id);

\echo ''
\echo '-------------------------------------'
\echo Creating Views for ( :name )
\echo '-------------------------------------'

-- Create Test View: wspr.raw_csv_view
CREATE OR REPLACE VIEW wspr.raw_csv_view AS
    SELECT
        to_timestamp(raw_csv.time_stamp)::date AS "Date",
        to_timestamp(raw_csv.time_stamp)::time AS "Time",
        raw_csv.rx_call AS "RxCall",
        raw_csv.rx_grid AS "RxGrid",
        raw_csv.snr AS "SNR",
        raw_csv.band AS "Band",
        raw_csv.frequency AS "Freq",
        raw_csv.tx_call AS "TxCall",
        raw_csv.tx_grid AS "TxGrid",
        raw_csv.power AS "Pwr",
        raw_csv.drift AS "Drift",
        raw_csv.distance AS "Dist(km)",
        raw_csv.azimuth AS "Az",
        raw_csv.software_version AS "SW",
        raw_csv.code AS "Code"
    FROM wspr.raw_csv;

-- Unique stats
CREATE OR REPLACE VIEW wspr.unique_stats AS
	SELECT  (
			SELECT COUNT(*)
				FROM   wspr.callsign
			) AS "UQ Calls",
			(
			SELECT COUNT(*)
				FROM wspr.grid
			) AS "UQ Grids",
			(
			SELECT COUNT(*)
				FROM wspr.band
			) AS "UQ Bands",
			(
			SELECT COUNT(*)
				FROM wspr.software_version
			) AS "UQ Software";

\echo ''
\echo '-------------------------------------'
\echo Create Store Procedures for ( :name )
\echo '-------------------------------------'

-- Procedure: Import Unique RxCall adn TxCall into wspr.callsign
CREATE OR REPLACE PROCEDURE wspr.update_rxcall()
LANGUAGE SQL
AS $BODY$
	INSERT INTO wspr.callsign(call)
	SELECT DISTINCT rx_call FROM wspr.raw_csv
	ON CONFLICT DO NOTHING;
$BODY$;

-- Procedure: Import Unique TxCall into wspe.callsign
CREATE OR REPLACE PROCEDURE wspr.update_txcall()
LANGUAGE SQL
AS $BODY$
	INSERT INTO wspr.callsign(call)
	SELECT DISTINCT tx_call FROM wspr.raw_csv
	ON CONFLICT DO NOTHING;   
$BODY$;

-- Procedure: Import Unique RxGrid into wspe.grid
CREATE OR REPLACE PROCEDURE wspr.update_rxgrid()
LANGUAGE SQL
AS $BODY$
	INSERT INTO wspr.grid(grid)
	SELECT DISTINCT rx_grid FROM wspr.raw_csv
	ON CONFLICT DO NOTHING;   
$BODY$;

-- Procedure: Import Unique TxGrid into wspe.grid
CREATE OR REPLACE PROCEDURE wspr.update_txgrid()
LANGUAGE SQL
AS $BODY$
	INSERT INTO wspr.grid(grid)
	SELECT DISTINCT rx_grid FROM wspr.raw_csv
	ON CONFLICT DO NOTHING;   
$BODY$;

-- Procedure: Import Unique Band into wspr.band
CREATE OR REPLACE PROCEDURE wspr.update_band()
LANGUAGE SQL
AS $BODY$
	INSERT INTO wspr.band(band)
	SELECT DISTINCT band FROM wspr.raw_csv
	ON CONFLICT DO NOTHING;   
$BODY$;

-- Procedure: Import Unique Software into wspe.sw_version
CREATE OR REPLACE PROCEDURE wspr.update_software_version()
LANGUAGE SQL
AS $BODY$
    INSERT INTO wspr.software_version(sw_version)
    SELECT DISTINCT software_version FROM wspr.raw_csv
        WHERE software_version IS NOT NULL
    ON CONFLICT DO NOTHING;
$BODY$;

\echo ''
\echo 'Finished'