using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.Adif.Models
{
    [Table("rdxc_district", Schema = "adif")]
    public partial class RdxcDistrict
    {
        [Column("id")]
        public int Id { get; set; }
        [Column("rdxc_id")]
        public int RdxcId { get; set; }
        [Required]
        [Column("code", TypeName = "character(5)")]
        public string Code { get; set; }
        [Column("district")]
        [StringLength(120)]
        public string District { get; set; }
        [Column("valid_since", TypeName = "date")]
        public DateTime? ValidSince { get; set; }
        [Column("is_deleted")]
        public bool IsDeleted { get; set; }
        [Column("is_new_rda")]
        public bool IsNewRda { get; set; }
        [Column("has_replacement")]
        public bool HasReplacement { get; set; }
        [Column("migration_district", TypeName = "character(5)")]
        public string MigrationDistrict { get; set; }

        [ForeignKey("RdxcId")]
        [InverseProperty("RdxcDistrict")]
        public virtual Rdxc Rdxc { get; set; }
    }
}
