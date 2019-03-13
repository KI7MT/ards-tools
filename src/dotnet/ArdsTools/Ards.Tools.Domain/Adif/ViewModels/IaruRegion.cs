using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.ViewModels
{
    [Table("iaru_region", Schema = "adif_view")]
    public partial class IaruRegion
    {
        [Key]
        [Display(Name = "IaruRegionId")]
        [Column("iaru_region_id")]
        public int IaruRegionId { get; set; }

        [Display(Name = "Region")]
        [Column("region")]
        public int? Region { get; set; }

        [Display(Name = "Description")]
        [Column("description")]
        [StringLength(120)]
        public string Description { get; set; }
    }
}
