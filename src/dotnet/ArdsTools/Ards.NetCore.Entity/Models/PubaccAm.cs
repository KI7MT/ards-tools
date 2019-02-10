using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.NetCore.Entity.Models
{
    [Table("pubacc_am", Schema = "fcc")]
    public partial class PubaccAm
    {
        [Required]
        [Column("record_type", TypeName = "character(2)")]
        public string RecordType { get; set; }
        [Column("unique_system_identifier", TypeName = "numeric(9,0)")]
        public decimal UniqueSystemIdentifier { get; set; }
        [Column("uls_file_num", TypeName = "character(14)")]
        public string UlsFileNum { get; set; }
        [Column("ebf_number")]
        [StringLength(30)]
        public string EbfNumber { get; set; }
        [Column("callsign", TypeName = "character(10)")]
        public string Callsign { get; set; }
        [Column("operator_class")]
        public char? OperatorClass { get; set; }
        [Column("group_code")]
        public char? GroupCode { get; set; }
        [Column("region_code")]
        public short? RegionCode { get; set; }
        [Column("trustee_callsign", TypeName = "character(10)")]
        public string TrusteeCallsign { get; set; }
        [Column("trustee_indicator")]
        public char? TrusteeIndicator { get; set; }
        [Column("physician_certification")]
        public char? PhysicianCertification { get; set; }
        [Column("ve_signature")]
        public char? VeSignature { get; set; }
        [Column("systematic_callsign_change")]
        public char? SystematicCallsignChange { get; set; }
        [Column("vanity_callsign_change")]
        public char? VanityCallsignChange { get; set; }
        [Column("vanity_relationship", TypeName = "character(12)")]
        public string VanityRelationship { get; set; }
        [Column("previous_callsign", TypeName = "character(10)")]
        public string PreviousCallsign { get; set; }
        [Column("previous_operator_class")]
        public char? PreviousOperatorClass { get; set; }
        [Column("trustee_name")]
        [StringLength(50)]
        public string TrusteeName { get; set; }
    }
}
