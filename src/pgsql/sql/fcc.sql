\echo ''
\echo '---------------------------'
\echo 'Creating FCC ULS Schema'
\echo '---------------------------'

-- Drop, and re-create schema
DROP SCHEMA IF EXISTS fcc CASCADE;

\echo ''
\echo '==========================='
\echo 'Creating Schema FCC'
\echo '==========================='

-- Create New Schema
CREATE SCHEMA fcc;

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
      involved_reserved      	    char(1)              null,
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
      certifier_last_name           varchar(20)          null,
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
      licensee_name_change          char(1)              null
);

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
      po_box                        varchar(20)          null,
      attention_line                varchar(35)          null,
      sgin                          char(3)              null,
      frn                           char(10)             null,
      applicant_type_code           char(1)              null,
      applicant_type_other          char(40)             null,
      status_code                   char(1)              null,
      status_date		            timestamp(3)         null
);

create table fcc.PUBACC_HS
(
      record_type                   char(2)              not null,
      unique_system_identifier      numeric(9,0)         not null,
      uls_file_number               char(14)             null,
      callsign                      char(10)             null,
      log_date                      char(10)             null,
      code                          char(6)              null
);

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
      trustee_name                  varchar(50)          null
);