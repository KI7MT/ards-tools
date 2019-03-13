using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.ViewModels
{
    [Table("ituzone", Schema = "adif_view")]
    public partial class Ituzone
    {
        [Key]
        [Display(Name = "ItuZoneId")]
        [Column("ituzone_id")]
        public int ItuzoneId { get; set; }

        [Display(Name = "ITU Zone")]
        [Column("ituzone")]
        public int? Ituzone1 { get; set; }

        [Display(Name = "Description")]
        [Column("description")]
        [StringLength(300)]
        public string Description { get; set; }
    }
}
