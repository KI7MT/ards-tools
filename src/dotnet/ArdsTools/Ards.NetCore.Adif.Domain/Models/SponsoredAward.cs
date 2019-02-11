using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.NetCore.Adif.Domain.Models
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
    }
}
