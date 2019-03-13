using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.ViewModels
{
    [Table("qso_complete", Schema = "adif_view")]
    public partial class QsoComplete
    {
        [Key]
        [Display(Name = "QsoCompleteId")]
        [Column("qso_complete_id")]
        public int QsoCompleteId { get; set; }

        [Display(Name = "Abbreviation")]
        [Column("abbreviation")]
        [StringLength(5)]
        public string Abbreviation { get; set; }

        [Display(Name = "meaning")]
        [Column("meaning")]
        [StringLength(20)]
        public string Meaning { get; set; }
    }
}
