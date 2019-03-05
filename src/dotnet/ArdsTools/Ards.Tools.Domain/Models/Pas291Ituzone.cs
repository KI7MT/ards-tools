using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.Adif.Models
{
    [Table("pas_291_ituzone", Schema = "adif")]
    public partial class Pas291Ituzone
    {
        [Column("id")]
        public int Id { get; set; }
        [Column("pas_291_id")]
        public int Pas291Id { get; set; }
        [Column("itu_zone_id")]
        public int ItuZoneId { get; set; }

        [ForeignKey("ItuZoneId")]
        [InverseProperty("Pas291Ituzone")]
        public virtual ItuZone ItuZone { get; set; }
        [ForeignKey("Pas291Id")]
        [InverseProperty("Pas291Ituzone")]
        public virtual Pas291 Pas291 { get; set; }
    }
}
