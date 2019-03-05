using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.Adif.Models
{
    [Table("pas_015_ituzone", Schema = "adif")]
    public partial class Pas015Ituzone
    {
        [Column("id")]
        public int Id { get; set; }
        [Column("pas_015_id")]
        public int Pas015Id { get; set; }
        [Column("itu_zone_id")]
        public int ItuZoneId { get; set; }

        [ForeignKey("ItuZoneId")]
        [InverseProperty("Pas015Ituzone")]
        public virtual ItuZone ItuZone { get; set; }
        [ForeignKey("Pas015Id")]
        [InverseProperty("Pas015Ituzone")]
        public virtual Pas015 Pas015 { get; set; }
    }
}
