using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.ViewModels
{
    [Table("antenna_path", Schema = "adif_view")]
    public partial class AntennaPath
    {
        [Key]
        [Display(Name = "AntennaPathId")]
        [Column("antenna_path_id")]
        public int AntennaPathId { get; set; }

        [Display(Name = "Abbreviation")]
        [Column("abbreviation")]
        [StringLength(1)]
        public string Abbreviation { get; set; }

        [Display(Name = "Meaning")]
        [Column("meaning")]
        [StringLength(15)]
        public string Meaning { get; set; }
    }
}
