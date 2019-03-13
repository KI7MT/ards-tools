using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.ViewModels
{
    [Table("pas339_region", Schema = "adif_view")]
    public partial class Pas339Region
    {
        [Key]
        [Display(Name = "Pas339RegionId")]
        [Column("pas339_region_id")]
        public int Pas339RegionId { get; set; }

        [Display(Name = "Region")]
        [Column("region")]
        [StringLength(120)]
        public string Region { get; set; }
    }
}
