using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.NetCore.Entity.Models
{
    [Table("pubacc_hd", Schema = "fcc")]
    public partial class PubaccHd
    {
        [Required]
        [Column("record_type", TypeName = "character(2)")]
        public string RecordType { get; set; }
        [Column("unique_system_identifier", TypeName = "numeric(9,0)")]
        public decimal UniqueSystemIdentifier { get; set; }
        [Column("uls_file_number", TypeName = "character(14)")]
        public string UlsFileNumber { get; set; }
        [Column("ebf_number")]
        [StringLength(30)]
        public string EbfNumber { get; set; }
        [Column("call_sign", TypeName = "character(10)")]
        public string CallSign { get; set; }
        [Column("license_status")]
        public char? LicenseStatus { get; set; }
        [Column("radio_service_code", TypeName = "character(2)")]
        public string RadioServiceCode { get; set; }
        [Column("grant_date", TypeName = "character(10)")]
        public string GrantDate { get; set; }
        [Column("expired_date", TypeName = "character(10)")]
        public string ExpiredDate { get; set; }
        [Column("cancellation_date", TypeName = "character(10)")]
        public string CancellationDate { get; set; }
        [Column("eligibility_rule_num", TypeName = "character(10)")]
        public string EligibilityRuleNum { get; set; }
        [Column("applicant_type_code_reserved")]
        public char? ApplicantTypeCodeReserved { get; set; }
        [Column("alien")]
        public char? Alien { get; set; }
        [Column("alien_government")]
        public char? AlienGovernment { get; set; }
        [Column("alien_corporation")]
        public char? AlienCorporation { get; set; }
        [Column("alien_officer")]
        public char? AlienOfficer { get; set; }
        [Column("alien_control")]
        public char? AlienControl { get; set; }
        [Column("revoked")]
        public char? Revoked { get; set; }
        [Column("convicted")]
        public char? Convicted { get; set; }
        [Column("adjudged")]
        public char? Adjudged { get; set; }
        [Column("involved_reserved")]
        public char? InvolvedReserved { get; set; }
        [Column("common_carrier")]
        public char? CommonCarrier { get; set; }
        [Column("non_common_carrier")]
        public char? NonCommonCarrier { get; set; }
        [Column("private_comm")]
        public char? PrivateComm { get; set; }
        [Column("fixed")]
        public char? Fixed { get; set; }
        [Column("mobile")]
        public char? Mobile { get; set; }
        [Column("radiolocation")]
        public char? Radiolocation { get; set; }
        [Column("satellite")]
        public char? Satellite { get; set; }
        [Column("developmental_or_sta")]
        public char? DevelopmentalOrSta { get; set; }
        [Column("interconnected_service")]
        public char? InterconnectedService { get; set; }
        [Column("certifier_first_name")]
        [StringLength(20)]
        public string CertifierFirstName { get; set; }
        [Column("certifier_mi")]
        public char? CertifierMi { get; set; }
        [Column("certifier_last_name")]
        [StringLength(30)]
        public string CertifierLastName { get; set; }
        [Column("certifier_suffix", TypeName = "character(3)")]
        public string CertifierSuffix { get; set; }
        [Column("certifier_title", TypeName = "character(40)")]
        public string CertifierTitle { get; set; }
        [Column("gender")]
        public char? Gender { get; set; }
        [Column("african_american")]
        public char? AfricanAmerican { get; set; }
        [Column("native_american")]
        public char? NativeAmerican { get; set; }
        [Column("hawaiian")]
        public char? Hawaiian { get; set; }
        [Column("asian")]
        public char? Asian { get; set; }
        [Column("white")]
        public char? White { get; set; }
        [Column("ethnicity")]
        public char? Ethnicity { get; set; }
        [Column("effective_date", TypeName = "character(10)")]
        public string EffectiveDate { get; set; }
        [Column("last_action_date", TypeName = "character(10)")]
        public string LastActionDate { get; set; }
        [Column("auction_id")]
        public int? AuctionId { get; set; }
        [Column("reg_stat_broad_serv")]
        public char? RegStatBroadServ { get; set; }
        [Column("band_manager")]
        public char? BandManager { get; set; }
        [Column("type_serv_broad_serv")]
        public char? TypeServBroadServ { get; set; }
        [Column("alien_ruling")]
        public char? AlienRuling { get; set; }
        [Column("licensee_name_change")]
        public char? LicenseeNameChange { get; set; }
    }
}
