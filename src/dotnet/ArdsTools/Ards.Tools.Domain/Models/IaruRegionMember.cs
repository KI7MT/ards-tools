using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.Adif.Models
{
    /// <summary>
    /// IARU Region Members
    /// </summary>
    [Table("iaru_region_member", Schema = "adif")]
    public partial class IaruRegionMember
    {
        [Column("id")]
        public int Id { get; set; }
        [Column("iaru_region_id")]
        public int IaruRegionId { get; set; }
        [Column("name")]
        [StringLength(120)]
        public string Name { get; set; }
        [Column("country_territory")]
        [StringLength(60)]
        public string CountryTerritory { get; set; }

        [ForeignKey("IaruRegionId")]
        [InverseProperty("IaruRegionMember")]
        public virtual IaruRegion IaruRegion { get; set; }
    }
}
