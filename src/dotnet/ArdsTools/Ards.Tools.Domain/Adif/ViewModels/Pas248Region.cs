using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.ViewModels
{
    [Table("pas248_region", Schema = "adif_view")]
    public partial class Pas248Region
    {
        [Key]
        [Display(Name = "Pas248RegionId")]
        [Column("pas248_region_id")]
        public int Pas248RegionId { get; set; }

        [Display(Name = "Region")]
        [Column("region")]
        [StringLength(120)]
        public string Region { get; set; }
    }
}
