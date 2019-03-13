using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.ViewModels
{
    [Table("pas503_region", Schema = "adif_view")]
    public partial class Pas503Region
    {
        [Key]
        [Display(Name = "Pas503RegionId")]
        [Column("pas503_region_id")]
        public int Pas503RegionId { get; set; }

        [Display(Name = "Region")]
        [Column("region")]
        [StringLength(120)]
        public string Region { get; set; }
    }
}
