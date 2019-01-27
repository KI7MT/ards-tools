/*
    Project .............: ARDS Tools
    Author ..............: Greg, Beam, KI7MT, <ki7mt@yahoo.com>
    Copyright ...........: Copyright (C) 2018 Greg Beam, KI7MT
    License .............: GPL-3

    File ................: fcc.pgsql
    Description .........: FCC ULS Tables and Views
    Database Type .......: PostgreSQL v10 or later
    Version .............: 0.0.1
    ADIF Specification ..: 3.0.8

      * FCC ULS: Data Table Schemas are taken directly from the FCC utils
        webtites.

      Documentation
            pdf: http://wireless.fcc.gov/uls/documentation/pa_intro24.pdf
      
      Schemas
            mssql: https://www.fcc.gov/file/14479/download

      Schema Modifications

            pubacc_hd: certifier_last_name varchar(30) null,
            pubacc_en: po_box varchar(30) null,

      Main Database
            zip-file: http://wireless.fcc.gov/uls/data/complete/l_amat.zip
      
      Daily Transaction Files
            Sun:  http://wireless.fcc.gov/uls/data/daily/l_am_sun.zip
            Mon:  http://wireless.fcc.gov/uls/data/daily/l_am_mon.zip
            Tue:  http://wireless.fcc.gov/uls/data/daily/l_am_tue.zip
            Wed:  http://wireless.fcc.gov/uls/data/daily/l_am_wed.zip
            Thu:  http://wireless.fcc.gov/uls/data/daily/l_am_thu.zip
            Fri:  http://wireless.fcc.gov/uls/data/daily/l_am_fri.zip
            Sat:  http://wireless.fcc.gov/uls/data/daily/l_am_sat.zip

      Comments

            Each week, the Main database is updated with the daily incremental
            updates as they are released each day. On Sundays, the week is
            pulled and then published as the main database again.

            The archive contails several files that also match the tables listed
            below. For the purpses of ARDS Tools, only four file / table
            combinations are used:

            Abrv  Table       Description
            --------------------------------------------------------------------
            HD    PUBACC_HD   Main Form 605 data that carries over to the license
            EN    PUBACC_EN   Names and addresses
            HS    PUBACC_HS   Application/License History
            AM    PUBACC_AM   Amateur data

      Primary Keys

            Each table has the same unique_system_identifier. Either this, or a
            combination of record_type and unoque_system_identifer could be used.

      Normilization

            The data, as if it presented from the FCC is NOT normalized in any
            fashion. The fields that are consistent accross each data set are:

            Field                         HD    EN    HS    AM
            --------------------------------------------------
            record_type                   Y     Y     Y     Y
            unique_system_identifier      Y     Y     Y     Y
            uls_file_number               Y     Y     Y     Y
            ebf_number
            call_sign                     Y
            callsign                            Y     Y     Y

            For some reason, call_sugn field has an underscore it in for HD. It
            is assumed this is to indicate the top of the hierarchy, and the
            remaintables link back to it in the real database.

            As for the remaining fields, many should / could be normalized. If
            and when this will happen in ARDS is yet to be determined.

      Indexing

            As there are no Fkeys in the four tables, indxing will be placed on
            any fields that are JOINED, or WHERE clause is used.

      Installation
      
            * Clone the repository

                  git clone https://github.com/KI7MT/ards-tools.git
            
            * Change directories and run the sql script

                  cd ards-tools\src\pgsql

                  psql -v ON_ERROR_STOP=1 -U postgres -f fcc.pgsql

*/

-- *****************************************************************************
--  BEGIN TABLE GENERATION and IMPORT
-- *****************************************************************************

-- Script Variables
\set name fcc
\set ver 0.0.1
\set adifv 3.0.9

\echo ''
\echo '-----------------------------------'
\echo Regenerating Schema for ( :name )
\echo '-----------------------------------'

-- Drop, and re-create schema
DROP SCHEMA IF EXISTS :name CASCADE;

-- Create New Schema
CREATE SCHEMA :name;

INSERT INTO ards.schema_info(schema_name, schema_version, adif_spec, last_update)
VALUES(:'name', :'ver', :'adifv', CURRENT_TIMESTAMP)
ON CONFLICT (schema_name) DO UPDATE SET schema_version = :'ver',
                                        adif_spec = :'adifv',
                                        last_update = CURRENT_TIMESTAMP;

-- HD: Main Form 605 data that carries over to the license
create table fcc.PUBACC_HD
(
      record_type                   char(2)              not null,
      unique_system_identifier      numeric(9,0)         not null,
      uls_file_number               char(14)             null,
      ebf_number                    varchar(30)          null,
      call_sign                     char(10)             null,
      license_status                char(1)              null,
      radio_service_code            char(2)              null,
      grant_date                    char(10)             null,
      expired_date                  char(10)             null,
      cancellation_date             char(10)             null,
      eligibility_rule_num          char(10)             null,
      applicant_type_code_reserved  char(1)              null,
      alien                         char(1)              null,
      alien_government              char(1)              null,
      alien_corporation             char(1)              null,
      alien_officer                 char(1)              null,
      alien_control                 char(1)              null,
      revoked                       char(1)              null,
      convicted                     char(1)              null,
      adjudged                      char(1)              null,
      involved_reserved      	      char(1)              null,
      common_carrier                char(1)              null,
      non_common_carrier            char(1)              null,
      private_comm                  char(1)              null,
      fixed                         char(1)              null,
      mobile                        char(1)              null,
      radiolocation                 char(1)              null,
      satellite                     char(1)              null,
      developmental_or_sta          char(1)              null,
      interconnected_service        char(1)              null,
      certifier_first_name          varchar(20)          null,
      certifier_mi                  char(1)              null,
      certifier_last_name           varchar(30)          null,
      certifier_suffix              char(3)              null,
      certifier_title               char(40)             null,
      gender                        char(1)              null,
      african_american              char(1)              null,
      native_american               char(1)              null,
      hawaiian                      char(1)              null,
      asian                         char(1)              null,
      white                         char(1)              null,
      ethnicity                     char(1)              null,
      effective_date                char(10)             null,
      last_action_date              char(10)             null,
      auction_id                    int                  null,
      reg_stat_broad_serv           char(1)              null,
      band_manager                  char(1)              null,
      type_serv_broad_serv          char(1)              null,
      alien_ruling                  char(1)              null,
      licensee_name_change          char(1)              null,
      CONSTRAINT pubacc_hd_usi_pkey PRIMARY KEY (unique_system_identifier)      
);

-- EN: Names and addresses
create table fcc.PUBACC_EN
(
      record_type                   char(2)              not null,
      unique_system_identifier      numeric(9,0)         not null,
      uls_file_number               char(14)             null,
      ebf_number                    varchar(30)          null,
      call_sign                     char(10)             null,
      entity_type                   char(2)              null,
      licensee_id                   char(9)              null,
      entity_name                   varchar(200)         null,
      first_name                    varchar(20)          null,
      mi                            char(1)              null,
      last_name                     varchar(20)          null,
      suffix                        char(3)              null,
      phone                         char(10)             null,
      fax                           char(10)             null,
      email                         varchar(50)          null,
      street_address                varchar(60)          null,
      city                          varchar(20)          null,
      state                         char(2)              null,
      zip_code                      char(9)              null,
      po_box                        varchar(25)          null,
      attention_line                varchar(35)          null,
      sgin                          char(3)              null,
      frn                           char(10)             null,
      applicant_type_code           char(1)              null,
      applicant_type_other          char(40)             null,
      status_code                   char(1)              null,
      status_date		            timestamp(3)         null,
      CONSTRAINT pubacc_en_usi_pkey PRIMARY KEY (unique_system_identifier)      
);

-- AM: Amateur data
create table fcc.PUBACC_AM
(
      record_type                   char(2)              not null,
      unique_system_identifier      numeric(9,0)         not null,
      uls_file_num                  char(14)             null,
      ebf_number                    varchar(30)          null,
      callsign                      char(10)             null,
      operator_class                char(1)              null,
      group_code                    char(1)              null,
      region_code                   smallint             null,
      trustee_callsign              char(10)             null,
      trustee_indicator             char(1)              null,
      physician_certification       char(1)              null,
      ve_signature                  char(1)              null,
      systematic_callsign_change    char(1)              null,
      vanity_callsign_change        char(1)              null,
      vanity_relationship           char(12)             null,
      previous_callsign             char(10)             null,
      previous_operator_class       char(1)              null,
      trustee_name                  varchar(50)          null,
      CONSTRAINT pubacc_am_usi_pkey PRIMARY KEY (unique_system_identifier)      
);

-- HS: Application/License History
create table fcc.PUBACC_HS
(
      record_type                   char(2)              not null,
      unique_system_identifier      numeric(9,0)         not null,
      uls_file_number               char(14)             null,
      callsign                      char(10)             null,
      log_date                      char(10)             null,
      code                          char(6)              null   
);

-- Only Add Data from DAT file during Development testing
-- \echo ''
-- \echo '---------------------------'
-- \echo 'Importing DAT Files'
-- \echo '---------------------------'
-- \echo ''
-- \echo 'Adding HD'
-- \COPY fcc.pubacc_hd FROM 'fcc/HD.dat' DELIMITER '|' QUOTE '"' CSV;
-- \echo 'Adding AM'
-- \COPY fcc.pubacc_AM FROM 'fcc/AM.dat' DELIMITER '|' QUOTE '"' CSV;
-- \echo 'Adding EN'
-- \COPY fcc.pubacc_en FROM 'fcc/EN.dat' DELIMITER '|' QUOTE '"' CSV;
-- \echo 'Adding HS'
-- \COPY fcc.pubacc_hs FROM 'fcc/HS.dat' DELIMITER '|' QUOTE '"' CSV;

-- *****************************************************************************
--  FOOTER - Finished
-- *****************************************************************************

\echo ''
\echo Finished Creating ARDS Schema for ( :name )
\echo ''
\echo 'Schema Informaiton'
\echo ''
SELECT * FROM ards.schema_info_view WHERE schema_info_view."Schema Name" = :'name';
