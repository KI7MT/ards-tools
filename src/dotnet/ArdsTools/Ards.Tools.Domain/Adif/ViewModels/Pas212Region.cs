using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.ViewModels
{
    [Table("pas212_region", Schema = "adif_view")]
    public partial class Pas212Region
    {
        [Key]
        [Display(Name = "Pas212RegionId")]
        [Column("pas212_region_id")]
        public int Pas212RegionId { get; set; }

        [Display(Name = "Region")]
        [Column("region")]
        [StringLength(120)]
        public string Region { get; set; }
    }
}
