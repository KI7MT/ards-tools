using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.Adif.Models
{
    /// <summary>
    /// IARU Regions
    /// </summary>
    [Table("iaru_region", Schema = "adif")]
    public partial class IaruRegion
    {
        public IaruRegion()
        {
            IaruRegionMember = new HashSet<IaruRegionMember>();
        }

        [Column("id")]
        public int Id { get; set; }
        [Column("region")]
        public int Region { get; set; }
        [Column("description")]
        [StringLength(120)]
        public string Description { get; set; }
        [Column("weblink_id")]
        public int? WeblinkId { get; set; }

        [ForeignKey("WeblinkId")]
        [InverseProperty("IaruRegion")]
        public virtual Weblink Weblink { get; set; }
        [InverseProperty("IaruRegion")]
        public virtual ICollection<IaruRegionMember> IaruRegionMember { get; set; }
    }
}
