using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.ViewModels
{
    [Table("rdxc_district_list", Schema = "adif_view")]
    public partial class RdxcDistrictList
    {
        [Key]
        [Display(Name = "RdxcDistrictListId")]
        [Column("rdxc_district_list_id")]
        public int RdxcDistrictListId { get; set; }

        [Display(Name = "RDXC Code")]
        [Column("rdxc_code", TypeName = "character(4)")]
        public string RdxcCode { get; set; }

        [Display(Name = "Oblast")]
        [Column("oblast")]
        [StringLength(60)]
        public string Oblast { get; set; }

        [Display(Name = "Prefix")]
        [Column("prefix", TypeName = "character(4)")]
        public string Prefix { get; set; }

        [Display(Name = "Oblast Is Deleted")]
        [Column("oblast_is_deleted")]
        public bool? OblastIsDeleted { get; set; }

        [Display(Name = "Code")]
        [Column("code", TypeName = "character(5)")]
        public string Code { get; set; }

        [Display(Name = "District")]
        [Column("district")]
        [StringLength(120)]
        public string District { get; set; }

        [Display(Name = "Valid Since")]
        [Column("valid_since", TypeName = "date")]
        public DateTime? ValidSince { get; set; }

        [Display(Name = "District Is Deleted")]
        [Column("district_is_deleted")]
        public bool? DistrictIsDeleted { get; set; }

        [Display(Name = "Is New RDA")]
        [Column("is_new_rda")]
        public bool? IsNewRda { get; set; }

        [Display(Name = "Has Replacement")]
        [Column("has_replacement")]
        public bool? HasReplacement { get; set; }

        [Display(Name = "Migration District")]
        [Column("migration_district", TypeName = "character(5)")]
        public string MigrationDistrict { get; set; }
    }
}
