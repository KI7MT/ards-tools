using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.ViewModels
{
    [Table("region", Schema = "adif_view")]
    public partial class Region
    {
        [Key]
        [Display(Name = "RegionId")]
        [Column("region_id")]
        public int RegionId { get; set; }

        [Display(Name = "Code")]
        [Column("code")]
        [StringLength(4)]
        public string Code { get; set; }

        [Display(Name = "DXCC Code")]
        [Column("dxcc_code")]
        [StringLength(4)]
        public string DxccCode { get; set; }

        [Display(Name = "Region")]
        [Column("region")]
        [StringLength(120)]
        public string Region1 { get; set; }

        [Display(Name = "Prefix")]
        [Column("prefix")]
        [StringLength(10)]
        public string Prefix { get; set; }
    }
}
