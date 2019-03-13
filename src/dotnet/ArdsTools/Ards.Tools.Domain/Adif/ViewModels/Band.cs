using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.ViewModels
{
    [Table("band", Schema = "adif_view")]
    public partial class Band
    {
        [Key]
        [Display(Name = "BandId")]
        [Column("band_id")]
        public int BandId { get; set; }

        [Display(Name = "Band")]
        [Column("band")]
        [StringLength(6)]
        public string Band1 { get; set; }

        [Display(Name = "Lower Freq (MHZ)")]
        [Column("lower_freq", TypeName = "numeric")]
        public decimal? LowerFreq { get; set; }

        [Display(Name = "Upper Freq (MHZ)")]
        [Column("upper_freq", TypeName = "numeric")]
        public decimal? UpperFreq { get; set; }
    }
}
