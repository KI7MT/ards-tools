using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.Adif.Models
{
    /// <summary>
    /// Primary Subdivision Enumeration for DXCC Entity Code 001
    /// </summary>
    [Table("pas_001_ituzone", Schema = "adif")]
    public partial class Pas001Ituzone
    {
        [Column("id")]
        public int Id { get; set; }
        [Column("pas_001_id")]
        public int Pas001Id { get; set; }
        [Column("itu_zone_id")]
        public int ItuZoneId { get; set; }

        [ForeignKey("ItuZoneId")]
        [InverseProperty("Pas001Ituzone")]
        public virtual ItuZone ItuZone { get; set; }
        [ForeignKey("Pas001Id")]
        [InverseProperty("Pas001Ituzone")]
        public virtual Pas001 Pas001 { get; set; }
    }
}
