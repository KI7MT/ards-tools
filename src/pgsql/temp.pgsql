/*
-- 110 Hawaii ------------------------------------------------------------------

-- TODO: view_pas108
CREATE TABLE adif.pas_110
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- assuming two char HI
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_110_uq UNIQUE (code,subdivision)
);

-- 112 Chile -------------------------------------------------------------------

-- TODO: view_pas_112
CREATE TABLE adif.pas_112
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(4) NOT NULL, -- four char XIII, XIV, XII, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_112_uq UNIQUE (code,subdivision)
);

-- 126 Kalingrad ---------------------------------------------------------------

-- NOTE: There are no multiple itu or cq zones for EU Russia
-- TODO: view_pas_126
CREATE TABLE adif.pas_126
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char KA, ...
    subdivision VARCHAR(60) NOT NULL,
    oblast CHAR(3) NOT NULL, -- three char, oblast numbers are 3 digits
    cq_zone_id INT NOT NULL,
    itu_xone_id INT NOT NULL,
    CONSTRAINT pas_126_uq UNIQUE (code,subdivision)
);

-- 130 Kazakhstan --------------------------------------------------------------

-- NOTE: This is a non-offical table. The Oblast is just an integer,
--       and should an FK in the future.
-- TODO: view_pas_130
CREATE TABLE adif.pas_130
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char AA, BB, CC, ...
    subdivision VARCHAR(60) NOT NULL,
    oblast INT NOT NULL,
    CONSTRAINT pas_130_uq UNIQUE (code,subdivision,oblast)
);

-- 132 Paraguay ----------------------------------------------------------------

-- TODO: view_pas_132
CREATE TABLE adif.pas_132
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(3) NOT NULL, -- three char 16, ASU, 11 
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_132_uq UNIQUE (code,subdivision)
);

-- 137 Republic of Korea -------------------------------------------------------

-- TODO: view_pas_137
CREATE TABLE adif.pas_137
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(1) NOT NULL, -- one char 1, 9, 8, ... 
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_137_uq UNIQUE (code,subdivision)
);

-- 138 Kure Island -------------------------------------------------------------

-- TODO: view_pas_138
CREATE TABLE adif.pas_138
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two two char KI, ... 
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_138_uq UNIQUE (code,subdivision)
);

-- 144 Uruguay -----------------------------------------------------------------

-- TODO: view_pas_144
CREATE TABLE adif.pas_144
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two two char MO, CA, SJ, ... 
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_144_uq UNIQUE (code,subdivision)
);

-- 147 Lord Howe Is. -----------------------------------------------------------

-- TODO: view_pas_147
CREATE TABLE adif.pas_147
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char LH, ... 
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_147_uq UNIQUE (code,subdivision)
);

-- 148 Venezuela ---------------------------------------------------------------

-- TODO: view_pas_148
CREATE TABLE adif.pas_148
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char AM, AN, AP, ... 
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_148_uq UNIQUE (code,subdivision)
);

-- 149 Azores ------------------------------------------------------------------

-- TODO: view_pas_149
CREATE TABLE adif.pas_149
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char AC, ... 
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_149_uq UNIQUE (code,subdivision)
);

-- 150 Australia ---------------------------------------------------------------

-- TODO: view_pas_150
CREATE TABLE adif.pas_150
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(3) NOT NULL, -- three char ACT, SA, NSW, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_150_uq UNIQUE (code,subdivision)
);

-- 151 Malyj Vysotski Is -------------------------------------------------------

-- TODO: view_pas_151
CREATE TABLE adif.pas_151
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char LO, MV, ...
    subdivision VARCHAR(60) NOT NULL,
    import_only BOOLEAN NOT NULL DEFAULT '0',
    CONSTRAINT pas_151_uq UNIQUE (code,subdivision)
);

-- 153 Macquarie Is. -----------------------------------------------------------

-- TODO: view_pas_153
CREATE TABLE adif.pas_153
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char MA, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_153_uq UNIQUE (code,subdivision)
);

-- 163 Papua New Guinea --------------------------------------------------------

-- TODO: view_pas_163
CREATE TABLE adif.pas_163
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(3) NOT NULL, -- three char NCD, CPM, CPK, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_163_uq UNIQUE (code,subdivision)
);

-- 170 New Zealand -------------------------------------------------------------

-- TODO: view_pas_170
CREATE TABLE adif.pas_170
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(3) NOT NULL, -- three char AUK, BUP, NTL, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_170_uq UNIQUE (code,subdivision)
);

-- 177 Minami Torishima --------------------------------------------------------

-- TODO: view_pas_177
CREATE TABLE adif.pas_177
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char MT, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_177_uq UNIQUE (code,subdivision)
);

-- 179 Moldova -----------------------------------------------------------------

-- TODO: view_pas_179
CREATE TABLE adif.pas_179
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(3) NOT NULL, -- three char AAA, BBB, CCC, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_179_uq UNIQUE (code,subdivision)
);

-- 192 Ogasawara ---------------------------------------------------------------

-- TODO: view_pas_179
CREATE TABLE adif.pas_192
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(1) NOT NULL, -- one char O, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_192_uq UNIQUE (code,subdivision)
);

-- 206 Austria -----------------------------------------------------------------

-- NOTE: Austria has Regions and Subdivisions
-- TODO: view_pas_206_region
-- TODO: view_pas_206_subdivision
-- For CSV File Conversion: IF(K2 <> "",TEXT(K2,"yyyy-mm-dd"),"")
CREATE TABLE adif.pas_206_subdivision
(
    id SERIAL PRIMARY KEY,
    pas_206_region_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char AM, BL, BN, ...
    subdivision VARCHAR(60) NOT NULL,
    before_date DATE,
    CONSTRAINT pas_206_subdivision_uq UNIQUE (code,subdivision)
);

CREATE TABLE adif.pas_206_region
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    region VARCHAR(60) NOT NULL,
    CONSTRAINT pas_206_region_uq UNIQUE (region)
);

-- 209 Belgium -----------------------------------------------------------------

-- TODO: Need CSV Data
-- TODO: view_pas_209
CREATE TABLE adif.pas_209
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char AN, BR, BW, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_209_uq UNIQUE (code,subdivision)
);

-- 212 Bulgaria ----------------------------------------------------------------

-- NOTE: Bulgaria has Regions and Subdivisions
-- TODO: view_pas_212_region
CREATE TABLE adif.pas_212_region
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    region VARCHAR(70) NOT NULL,
    CONSTRAINT pas_212_region_uq UNIQUE (region)
);

-- TODO: view_pas_212_subdivision
CREATE TABLE adif.pas_212_subdivision
(
    id SERIAL PRIMARY KEY,
    pas_212_region_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char AM, BL, BN, ...
    subdivision VARCHAR(70) NOT NULL,
    CONSTRAINT pas_212_subdivision_uq UNIQUE (code,subdivision)
);

-- 214 Corsica -----------------------------------------------------------------

-- TODO: view_pas_214
CREATE TABLE adif.pas_214
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char 2A, 2B, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_214_uq UNIQUE (code,subdivision)
);

-- 221 Denmark -----------------------------------------------------------------

-- TODO: view_pas_221
CREATE TABLE adif.pas_221
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(3) NOT NULL, -- three char 015, 025, 055, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_221_uq UNIQUE (code,subdivision)
);

-- 224 Finland -----------------------------------------------------------------

-- NOTE: Finland has Regions and Subdivisions
-- TODO: view_pas_224_region
CREATE TABLE adif.pas_224_region
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    region VARCHAR(70) NOT NULL,
    CONSTRAINT pas_224_region_uq UNIQUE (region)
);

-- TODO: view_pas_224_subdivision
CREATE TABLE adif.pas_224_subdivision
(
    id SERIAL PRIMARY KEY,
    pas_224_region_id INT NOT NULL,
    code CHAR(3) NOT NULL, -- three char 105, 106, 107, ...
    subdivision VARCHAR(70) NOT NULL,
    CONSTRAINT pas_224_subdivision_uq UNIQUE (code,subdivision)
);

-- 225 Sardinia ----------------------------------------------------------------

-- NOTE: Sardinia has Regions and Subdivisions
-- NOTE: Sardinia has one Import Only Subdivision
-- TODO: view_pas_225_region
CREATE TABLE adif.pas_225_region
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    region VARCHAR(40) NOT NULL,
    CONSTRAINT pas_225_region_uq UNIQUE (region)
);

-- TODO: view_pas_225_subdivision
CREATE TABLE adif.pas_225_subdivision
(
    id SERIAL PRIMARY KEY,
    pas_225_region_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char CA, CI, MD, ...
    subdivision VARCHAR(60) NOT NULL,
    import_only BOOLEAN NOT NULL DEFAULT '0',
    CONSTRAINT pas_225_subdivision_uq UNIQUE (code,subdivision)
);

-- 227 France ------------------------------------------------------------------

-- TODO: view_pas_227
CREATE TABLE adif.pas_227
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char 01, 02, 03, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_227_uq UNIQUE (code,subdivision)
);

-- 230 Fed. Rep. of Germany ----------------------------------------------------

-- TODO: view_pas_230
CREATE TABLE adif.pas_230
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- assuming two char BB, BW, BW, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_230_uq UNIQUE (code,subdivision)
);

-- 239 Hungary -----------------------------------------------------------------

-- TODO: view_pas_239
CREATE TABLE adif.pas_239
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- assuming two char GY, VA, ZA, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_239_uq UNIQUE (code,subdivision)
);

-- 245 Ireland -----------------------------------------------------------------

-- TODO: view_pas_245
CREATE TABLE adif.pas_245
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- assuming two char CW, CN, CE, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_245_uq UNIQUE (code,subdivision)
);

-- 248 Italy -------------------------------------------------------------------

-- NOTE: Italy has Regions and Subdivisions
-- NOTE: Italy has multiple Import Only Subdivisions
-- TODO: view_pas_248_region
CREATE TABLE adif.pas_248_region
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    region VARCHAR(60) NOT NULL,
    CONSTRAINT pas_248_region_uq UNIQUE (region)
);

-- TODO: view_pas_245_subdivision
CREATE TABLE adif.pas_248_subdivision
(
    id SERIAL PRIMARY KEY,
    pas_248_region_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- assuming two char BO, FE, FO, ...
    subdivision VARCHAR(60) NOT NULL,
    import_only BOOLEAN NOT NULL DEFAULT '0',
    CONSTRAINT pas_248_subdivision_uq UNIQUE (pas_248_region_id,code,subdivision)
);

-- 256 Maderia Is. -------------------------------------------------------------

-- TODO: view_pas_256
CREATE TABLE adif.pas_256
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- assuming two char MD, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_256_uq UNIQUE (code,subdivision)
);

-- 263 Netherlands -------------------------------------------------------------

-- TODO: view_pas_263
CREATE TABLE adif.pas_263
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char DR, FR, GR, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_263_uq UNIQUE (code,subdivision)
);

-- 269 Poland ------------------------------------------------------------------

-- TODO: view_pas_269
CREATE TABLE adif.pas_269
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(1) NOT NULL, -- one char Z, F, P, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_269_uq UNIQUE (code,subdivision)
);

-- 272 Portugal ----------------------------------------------------------------

-- TODO: view_pas_272
CREATE TABLE adif.pas_272
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char AV, BJ, BR, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_272_uq UNIQUE (code,subdivision)
);

-- 275 Romania -----------------------------------------------------------------

-- TODO: view_pas_275
CREATE TABLE adif.pas_275
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char AR, CS, HD, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_275_uq UNIQUE (code,subdivision)
);

-- 281 Spain -------------------------------------------------------------------

-- TODO: view_pas_281
CREATE TABLE adif.pas_281
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char AV, BU, C, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_281_uq UNIQUE (code,subdivision)
);

-- 284 Sweden ------------------------------------------------------------------

-- TODO: view_pas_284
CREATE TABLE adif.pas_284
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char AB, I, BD, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_284_uq UNIQUE (code,subdivision)
);

-- 287 Switzerland -------------------------------------------------------------

-- TODO: view_pas_287
CREATE TABLE adif.pas_287
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char AG, AR, AI, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_287_uq UNIQUE (code,subdivision)
);

-- 288 Ukraine -----------------------------------------------------------------

-- TODO: view_pas_287
CREATE TABLE adif.pas_288
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char SU, TE, CH, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_288_uq UNIQUE (code,subdivision)
);

-- 291 United States -----------------------------------------------------------

-- TODO: view_pas_291
CREATE TABLE adif.pas_291
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two letter state code
    subdivision VARCHAR(60) NOT NULL, -- state name
    CONSTRAINT pas_291_uq UNIQUE (code,subdivision)
);

-- PAS-291 United States CQ Zone
CREATE TABLE adif.pas_291_cqzone
(
    id SERIAL PRIMARY KEY,
    pas_291_id INT NOT NULL,
    cq_zone_id INT NOT NULL
);

-- PAS-291 United States ITU Zone
CREATE TABLE adif.pas_291_ituzone
(
    id SERIAL PRIMARY KEY,
    pas_291_id INT NOT NULL,
    itu_zone_id INT NOT NULL
);

-- 318 China -------------------------------------------------------------------

-- TODO: view_pas_287
CREATE TABLE adif.pas_318
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char AH, BJ, CQ, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_318_uq UNIQUE (code,subdivision)
);

-- 327 Indonesia ---------------------------------------------------------------

-- TODO: view_pas_327
CREATE TABLE adif.pas_327
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char BA, BB, BT, ...
    subdivision VARCHAR(60) NOT NULL,
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
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_375_subdivision_uq UNIQUE (code,subdivision)
);

-- 386 Taiwan ------------------------------------------------------------------

-- TODO: view_pas_386
CREATE TABLE adif.pas_386
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(3) NOT NULL, -- two char DAS, DAO, CAM, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_386_uq UNIQUE (code,subdivision)
);

-- 387 Thailand ----------------------------------------------------------------

-- TODO: view_pas_387
CREATE TABLE adif.pas_387
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char 37, 25, 81, ...
    subdivision VARCHAR(60) NOT NULL,
    CONSTRAINT pas_387_uq UNIQUE (code,subdivision)
);

-- 497 Croatia -----------------------------------------------------------------

-- TODO: view_pas_497
CREATE TABLE adif.pas_497
(
    id SERIAL PRIMARY KEY,
    dxcc_id INT NOT NULL,
    code CHAR(2) NOT NULL, -- two char 01, 02, 03, ...
    subdivision VARCHAR(60) NOT NULL,
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
    subdivision VARCHAR(60) NOT NULL,
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

-- PAS-110
\COPY pas_110 FROM 'adif-pas/pas_110.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-112
\COPY pas_112 FROM 'adif-pas/pas_112.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-126
\COPY pas_126 FROM 'adif-pas/pas_126.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-130
\COPY pas_130 FROM 'adif-pas/pas_130.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-132
\COPY pas_132 FROM 'adif-pas/pas_132.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-137
\COPY pas_137 FROM 'adif-pas/pas_137.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-138
\COPY pas_138 FROM 'adif-pas/pas_138.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-144
\COPY pas_144 FROM 'adif-pas/pas_144.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-147
\COPY pas_147 FROM 'adif-pas/pas_147.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-148
\COPY pas_148 FROM 'adif-pas/pas_147.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-149
\COPY pas_149 FROM 'adif-pas/pas_149.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-150
\COPY pas_150 FROM 'adif-pas/pas_150.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-151
\COPY pas_151 FROM 'adif-pas/pas_151.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-153
\COPY pas_153 FROM 'adif-pas/pas_153.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-163
\COPY pas_163 FROM 'adif-pas/pas_163.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-170
\COPY pas_170 FROM 'adif-pas/pas_170.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-177
\COPY pas_177 FROM 'adif-pas/pas_177.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-179
\COPY pas_179 FROM 'adif-pas/pas_179.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-192
\COPY pas_192 FROM 'adif-pas/pas_192.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-206
\COPY pas_206_region FROM 'adif-pas/pas_206_region.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY pas_206_subdivision FROM 'adif-pas/pas_206_subdivision.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-209
\COPY pas_209 FROM 'adif-pas/pas_209.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-212
\COPY pas_212_region FROM 'adif-pas/pas_212_region.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY pas_212_subdivision FROM 'adif-pas/pas_212_subdivision.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-214
\COPY pas_214 FROM 'adif-pas/pas_214.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-221
\COPY pas_221 FROM 'adif-pas/pas_221.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-224
\COPY pas_224_region FROM 'adif-pas/pas_224_region.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY pas_224_subdivision FROM 'adif-pas/pas_224_subdivision.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-225
\COPY pas_225_region FROM 'adif-pas/pas_225_region.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY pas_225_subdivision FROM 'adif-pas/pas_225_subdivision.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-227
\COPY pas_227 FROM 'adif-pas/pas_227.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-230
\COPY pas_230 FROM 'adif-pas/pas_230.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-239
\COPY pas_239 FROM 'adif-pas/pas_239.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-245
\COPY pas_245 FROM 'adif-pas/pas_245.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-248
\COPY pas_248_region FROM 'adif-pas/pas_248_region.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY pas_248_subdivision FROM 'adif-pas/pas_248_subdivision.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-256
\COPY pas_256 FROM 'adif-pas/pas_256.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-263
\COPY pas_263 FROM 'adif-pas/pas_263.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-269
\COPY pas_269 FROM 'adif-pas/pas_269.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-272
\COPY pas_272 FROM 'adif-pas/pas_272.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-275
\COPY pas_275 FROM 'adif-pas/pas_275.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-281
\COPY pas_281 FROM 'adif-pas/pas_281.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-284
\COPY pas_284 FROM 'adif-pas/pas_284.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-287
\COPY pas_287 FROM 'adif-pas/pas_287.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-288
\COPY pas_288 FROM 'adif-pas/pas_288.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-291
\COPY pas_291 FROM 'adif-pas/pas_291.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY pas_291_cqzone FROM 'adif-pas/pas_291_cqzone.csv' DELIMITER '|' QUOTE '"' HEADER CSV;
\COPY pas_291_ituzone FROM 'adif-pas/pas_291_ituzone.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

-- PAS-318
\COPY pas_318 FROM 'adif-pas/pas_318.csv' DELIMITER '|' QUOTE '"' HEADER CSV;

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

-- PAS-110 Hawaii --------------------------------------------------------------
ALTER TABLE pas_110 ADD CONSTRAINT pas_110_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES dxcc (dxcc_id);

-- PAS-112 Chile ---------------------------------------------------------------
ALTER TABLE pas_112 ADD CONSTRAINT pas_112_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES dxcc (dxcc_id);

-- PAS-126 Kalingrad -----------------------------------------------------------
ALTER TABLE pas_126 ADD CONSTRAINT pas_126_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES dxcc (dxcc_id);

ALTER TABLE pas_126 ADD CONSTRAINT pas_126_cq_zone_fkey
    FOREIGN KEY (cq_zone_id) REFERENCES cqzone (cqzone_id);

ALTER TABLE pas_126 ADD CONSTRAINT pas_126_itu_zone_fkey
    FOREIGN KEY (itu_zone_id) REFERENCES ituzone (cqzone_id);

-- PAS-130 Kazakhstan ----------------------------------------------------------
ALTER TABLE pas_130 ADD CONSTRAINT pas_130_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES dxcc (dxcc_id);

-- PAS-132 Paraguay ------------------------------------------------------------
ALTER TABLE pas_132 ADD CONSTRAINT pas_132_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES dxcc (dxcc_id);

-- PAS-137 Republic of Korea ---------------------------------------------------
ALTER TABLE pas_137 ADD CONSTRAINT pas_137_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES dxcc (dxcc_id);

-- PAS-138 Kure Island ---------------------------------------------------------
ALTER TABLE pas_138 ADD CONSTRAINT pas_138_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES dxcc (dxcc_id);

-- PAS-144 Uruguay -------------------------------------------------------------
ALTER TABLE pas_144 ADD CONSTRAINT pas_144_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES dxcc (dxcc_id);

-- PAS-147 Lord Howe Is. -------------------------------------------------------
ALTER TABLE pas_147 ADD CONSTRAINT pas_147_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES dxcc (dxcc_id);

-- PAS-148 Venezuela ---------------------------------------------------------------
ALTER TABLE pas_148 ADD CONSTRAINT pas_148_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES dxcc (dxcc_id);

-- PAS-149 Azores --------------------------------------------------------------
ALTER TABLE pas_149 ADD CONSTRAINT pas_149_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES dxcc (dxcc_id);

-- PAS-150 Australia -----------------------------------------------------------
ALTER TABLE pas_150 ADD CONSTRAINT pas_150_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES dxcc (dxcc_id);

-- 151 Malyj Vysotski Is -------------------------------------------------------
ALTER TABLE pas_151 ADD CONSTRAINT pas_151_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES dxcc (dxcc_id);

-- PAS-153 Macquarie Is. -------------------------------------------------------
ALTER TABLE pas_153 ADD CONSTRAINT pas_153_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES dxcc (dxcc_id);

-- PAS-163 Papua New Guinea ----------------------------------------------------
ALTER TABLE pas_163 ADD CONSTRAINT pas_163_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES dxcc (dxcc_id);

-- PAS-170 New Zealand ---------------------------------------------------------
ALTER TABLE pas_170 ADD CONSTRAINT pas_170_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES dxcc (dxcc_id);

-- PAS-177 Minami Torishima ----------------------------------------------------
ALTER TABLE pas_177 ADD CONSTRAINT pas_177_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES dxcc (dxcc_id);

-- PAS-179 Moldova -----------------------------------------------------------------
ALTER TABLE pas_179 ADD CONSTRAINT pas_179_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES dxcc (dxcc_id);

-- PAS-192 Ogasawara -----------------------------------------------------------
ALTER TABLE pas_192 ADD CONSTRAINT pas_192_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES dxcc (dxcc_id);

-- PAS-206 Austria -------------------------------------------------------------
ALTER TABLE pas_206_region ADD CONSTRAINT pas_206_region_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES dxcc (dxcc_id);

ALTER TABLE pas_206_subdivision ADD CONSTRAINT pas_206_subdivision_pas_206_region_fkey
    FOREIGN KEY (pas_206_region_id) REFERENCES pas_206_region (id);

-- PAS-209 Belgium -----------------------------------------------------------------
ALTER TABLE pas_209 ADD CONSTRAINT pas_209_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES dxcc (dxcc_id);

-- PAS-212 Bulgaria ------------------------------------------------------------
ALTER TABLE pas_212_region ADD CONSTRAINT pas_212_region_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES dxcc (dxcc_id);

ALTER TABLE pas_212_subdivision ADD CONSTRAINT pas_212_subdivision_pas_212_region_fkey
    FOREIGN KEY (pas_212_region_id) REFERENCES pas_212_region (id);

-- PAS-214 Corsica -------------------------------------------------------------
ALTER TABLE pas_214 ADD CONSTRAINT pas_214_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES dxcc (dxcc_id);

-- PAS-221 Denmark -------------------------------------------------------------
ALTER TABLE pas_221 ADD CONSTRAINT pas_221_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES dxcc (dxcc_id);

-- PAS-224 Finland -------------------------------------------------------------
ALTER TABLE pas_224_region ADD CONSTRAINT pas_224_region_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES dxcc (dxcc_id);

ALTER TABLE pas_224_subdivision ADD CONSTRAINT pas_224_subdivision_pas_224_region_fkey
    FOREIGN KEY (pas_224_region_id) REFERENCES pas_224_region (id);

-- PAS-225 Sardinia ------------------------------------------------------------
ALTER TABLE pas_225_region ADD CONSTRAINT pas_225_region_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES dxcc (dxcc_id);

ALTER TABLE pas_225_subdivision ADD CONSTRAINT pas_225_subdivision_pas_225_region_fkey
    FOREIGN KEY (pas_225_region_id) REFERENCES pas_225_region (id);

-- PAS-227 France --------------------------------------------------------------
ALTER TABLE pas_227 ADD CONSTRAINT pas_227_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES dxcc (dxcc_id);

-- PAS-230 Fed. Rep. of Germany ------------------------------------------------
ALTER TABLE pas_230 ADD CONSTRAINT pas_230_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES dxcc (dxcc_id);

-- PAS-239 Hungary -------------------------------------------------------------
ALTER TABLE pas_239 ADD CONSTRAINT pas_239_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES dxcc (dxcc_id);

-- PAS-245 Ireland -------------------------------------------------------------
ALTER TABLE pas_245 ADD CONSTRAINT pas_245_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES dxcc (dxcc_id);

-- PAS-248 Italy ---------------------------------------------------------------
ALTER TABLE pas_248_region ADD CONSTRAINT pas_248_region_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES dxcc (dxcc_id);

ALTER TABLE pas_248_subdivision ADD CONSTRAINT pas_248_subdivision_pas_248_region_fkey
    FOREIGN KEY (pas_248_region_id) REFERENCES pas_248_region (id);

-- PAS-256 Maderia Is. ---------------------------------------------------------
ALTER TABLE pas_256 ADD CONSTRAINT pas_256_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES dxcc (dxcc_id);

-- PAS-263 Netherlands ---------------------------------------------------------
ALTER TABLE pas_263 ADD CONSTRAINT pas_263_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES dxcc (dxcc_id);

-- PAS-269 Poland --------------------------------------------------------------
ALTER TABLE pas_269 ADD CONSTRAINT pas_269_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES dxcc (dxcc_id);

-- PAS-272 Portugal ------------------------------------------------------------
ALTER TABLE pas_272 ADD CONSTRAINT pas_272_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES dxcc (dxcc_id);

-- PAS-275 Romania -------------------------------------------------------------
ALTER TABLE pas_275 ADD CONSTRAINT pas_275_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES dxcc (dxcc_id);

-- PAS-281 Spain ---------------------------------------------------------------
ALTER TABLE pas_281 ADD CONSTRAINT pas_281_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES dxcc (dxcc_id);

-- 284 Sweden ------------------------------------------------------------------
ALTER TABLE pas_284 ADD CONSTRAINT pas_284_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES dxcc (dxcc_id);

-- 287 Switzerland -------------------------------------------------------------
ALTER TABLE pas_287 ADD CONSTRAINT pas_287_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES dxcc (dxcc_id);

-- 288 Ukraine -----------------------------------------------------------------
ALTER TABLE pas_288 ADD CONSTRAINT pas_288_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES dxcc (dxcc_id);

-- 291 United States -----------------------------------------------------------
ALTER TABLE pas_291 ADD CONSTRAINT pas_291_dxcc_fkey
    FOREIGN KEY (dxcc_id) REFERENCES dxcc (dxcc_id);

ALTER TABLE pas_291_cqzone ADD CONSTRAINT pas_291_cqzone_pas_291_fkey
    FOREIGN KEY (pas_291_id) REFERENCES pas_291 (id);

ALTER TABLE pas_291_cqzone ADD CONSTRAINT pas_291_cqzone_cq_zone_fkey
    FOREIGN KEY (cq_zone_id) REFERENCES cqzone (cqzone_id);

ALTER TABLE pas_291_ituzone ADD CONSTRAINT pas_291_ituzone_pas_291_fkey
    FOREIGN KEY (pas_291_id) REFERENCES pas_291 (id);

ALTER TABLE pas_291_ituzone ADD CONSTRAINT pas_291_ituzone_itu_zone_fkey
    FOREIGN KEY (itu_zone_id) REFERENCES ituzone (ituzone_id);

-- PAS-318 China ---------------------------------------------------------------
ALTER TABLE pas_318 ADD CONSTRAINT pas_318_dxcc_fkey
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