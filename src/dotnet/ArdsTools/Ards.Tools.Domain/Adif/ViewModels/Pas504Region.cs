using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.ViewModels
{
    [Table("pas504_region", Schema = "adif_view")]
    public partial class Pas504Region
    {
        [Key]
        [Display(Name = "Pas504RegionId")]
        [Column("pas504_region_id")]
        public int Pas504RegionId { get; set; }

        [Display(Name = "Region")]
        [Column("region")]
        [StringLength(120)]
        public string Region { get; set; }
    }
}
