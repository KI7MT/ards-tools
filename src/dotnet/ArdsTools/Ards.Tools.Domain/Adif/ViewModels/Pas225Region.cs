using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.ViewModels
{
    [Table("pas225_region", Schema = "adif_view")]
    public partial class Pas225Region
    {
        [Key]
        [Display(Name = "Pas225RegionId")]
        [Column("pas225_region_id")]
        public int Pas225RegionId { get; set; }

        [Display(Name = "Region")]
        [Column("region")]
        [StringLength(120)]
        public string Region { get; set; }
    }
}
