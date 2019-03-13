using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.ViewModels
{
    [Table("pas206_region", Schema = "adif_view")]
    public partial class Pas206Region
    {
        [Key]
        [Display(Name = "Pas206RegionId")]
        [Column("pas206_region_id")]
        public int Pas206RegionId { get; set; }

        [Display(Name = "Region")]
        [Column("region")]
        [StringLength(120)]
        public string Region { get; set; }
    }
}
