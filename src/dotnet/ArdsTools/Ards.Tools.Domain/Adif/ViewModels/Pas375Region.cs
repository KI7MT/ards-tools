using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.ViewModels
{
    [Table("pas375_region", Schema = "adif_view")]
    public partial class Pas375Region
    {
        [Key]
        [Display(Name = "Pas375RegionId")]
        [Column("pas375_region_id")]
        public int Pas375RegionId { get; set; }

        [Display(Name = "Region")]
        [Column("region")]
        [StringLength(120)]
        public string Region { get; set; }
    }
}
