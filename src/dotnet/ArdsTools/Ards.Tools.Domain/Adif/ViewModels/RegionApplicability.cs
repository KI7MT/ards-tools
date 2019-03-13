using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.ViewModels
{
    [Table("region_applicability", Schema = "adif_view")]
    public partial class RegionApplicability
    {
        [Key]
        [Display(Name = "RegionApplicabilityId")]
        [Column("region_applicability_id")]
        public int RegionApplicabilityId { get; set; }

        [Display(Name = "Code")]
        [Column("code")]
        [StringLength(4)]
        public string Code { get; set; }

        [Display(Name = "DXCC Coe")]
        [Column("dxcc_code")]
        [StringLength(4)]
        public string DxccCode { get; set; }

        [Display(Name = "Region")]
        [Column("region")]
        [StringLength(120)]
        public string Region { get; set; }

        [Display(Name = "Prefix")]
        [Column("prefix")]
        [StringLength(10)]
        public string Prefix { get; set; }

        [Display(Name = "Applicability")]
        [Column("applicability")]
        public string Applicability { get; set; }
    }
}
