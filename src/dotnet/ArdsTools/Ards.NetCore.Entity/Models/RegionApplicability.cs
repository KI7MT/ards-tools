using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.NetCore.Entity.Models
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
    }
}
