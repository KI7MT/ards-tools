using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.Adif.Models
{
    [Table("sponsored_award", Schema = "adif")]
    public partial class SponsoredAward
    {
        [Column("id")]
        public int Id { get; set; }
        [Required]
        [Column("sponsor")]
        [StringLength(20)]
        public string Sponsor { get; set; }
        [Column("weblink_id")]
        public int WeblinkId { get; set; }

        [ForeignKey("WeblinkId")]
        [InverseProperty("SponsoredAward")]
        public virtual Weblink Weblink { get; set; }
    }
}
