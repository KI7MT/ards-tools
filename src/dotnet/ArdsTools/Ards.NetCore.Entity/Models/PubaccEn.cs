using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.NetCore.Entity.Models
{
    [Table("pubacc_en", Schema = "fcc")]
    public partial class PubaccEn
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
        [Column("entity_type", TypeName = "character(2)")]
        public string EntityType { get; set; }
        [Column("licensee_id", TypeName = "character(9)")]
        public string LicenseeId { get; set; }
        [Column("entity_name")]
        [StringLength(200)]
        public string EntityName { get; set; }
        [Column("first_name")]
        [StringLength(20)]
        public string FirstName { get; set; }
        [Column("mi")]
        public char? Mi { get; set; }
        [Column("last_name")]
        [StringLength(20)]
        public string LastName { get; set; }
        [Column("suffix", TypeName = "character(3)")]
        public string Suffix { get; set; }
        [Column("phone", TypeName = "character(10)")]
        public string Phone { get; set; }
        [Column("fax", TypeName = "character(10)")]
        public string Fax { get; set; }
        [Column("email")]
        [StringLength(50)]
        public string Email { get; set; }
        [Column("street_address")]
        [StringLength(60)]
        public string StreetAddress { get; set; }
        [Column("city")]
        [StringLength(20)]
        public string City { get; set; }
        [Column("state", TypeName = "character(2)")]
        public string State { get; set; }
        [Column("zip_code", TypeName = "character(9)")]
        public string ZipCode { get; set; }
        [Column("po_box")]
        [StringLength(25)]
        public string PoBox { get; set; }
        [Column("attention_line")]
        [StringLength(35)]
        public string AttentionLine { get; set; }
        [Column("sgin", TypeName = "character(3)")]
        public string Sgin { get; set; }
        [Column("frn", TypeName = "character(10)")]
        public string Frn { get; set; }
        [Column("applicant_type_code")]
        public char? ApplicantTypeCode { get; set; }
        [Column("applicant_type_other", TypeName = "character(40)")]
        public string ApplicantTypeOther { get; set; }
        [Column("status_code")]
        public char? StatusCode { get; set; }
        [Column("status_date", TypeName = "timestamp(3) without time zone")]
        public DateTime? StatusDate { get; set; }
    }
}
