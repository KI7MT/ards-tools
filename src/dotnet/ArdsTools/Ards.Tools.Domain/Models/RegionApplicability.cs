using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.Adif.Models
{
    [Table("region_applicability", Schema = "adif")]
    public partial class RegionApplicability
    {
        [Column("id")]
        public int Id { get; set; }
        [Column("region_id")]
        public int RegionId { get; set; }
        [Column("weblink_id")]
        public int WeblinkId { get; set; }

        [ForeignKey("RegionId")]
        [InverseProperty("RegionApplicability")]
        public virtual Region Region { get; set; }
        [ForeignKey("WeblinkId")]
        [InverseProperty("RegionApplicability")]
        public virtual Weblink Weblink { get; set; }
    }
}
