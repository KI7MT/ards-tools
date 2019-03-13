using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.ViewModels
{
    [Table("sponsored_award", Schema = "adif_view")]
    public partial class SponsoredAward
    {
        [Key]
        [Display(Name = "SponsoredAwardId")]
        [Column("sponsored_award_id")]
        public int SponsoredAwardId { get; set; }

        [Display(Name = "Spomsor")]
        [Column("sponsor")]
        [StringLength(20)]
        public string Sponsor { get; set; }

        [Display(Name = "Orginization")]
        [Column("orginization")]
        [StringLength(120)]
        public string Orginization { get; set; }
    }
}
