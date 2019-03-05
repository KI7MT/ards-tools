using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.Adif.Models
{
    /// <summary>
    /// CQ Zones for Primary Enumeration DXCC Entity Code 001
    /// </summary>
    [Table("pas_001_cqzone", Schema = "adif")]
    public partial class Pas001Cqzone
    {
        [Column("id")]
        public int Id { get; set; }
        [Column("pas_001_id")]
        public int Pas001Id { get; set; }
        [Column("cq_zone_id")]
        public int CqZoneId { get; set; }

        [ForeignKey("CqZoneId")]
        [InverseProperty("Pas001Cqzone")]
        public virtual CqZone CqZone { get; set; }
        [ForeignKey("Pas001Id")]
        [InverseProperty("Pas001Cqzone")]
        public virtual Pas001 Pas001 { get; set; }
    }
}
