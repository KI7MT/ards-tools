using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.Adif.Models
{
    [Table("pas_015_cqzone", Schema = "adif")]
    public partial class Pas015Cqzone
    {
        [Column("id")]
        public int Id { get; set; }
        [Column("pas_015_id")]
        public int Pas015Id { get; set; }
        [Column("cq_zone_id")]
        public int CqZoneId { get; set; }

        [ForeignKey("CqZoneId")]
        [InverseProperty("Pas015Cqzone")]
        public virtual CqZone CqZone { get; set; }
        [ForeignKey("Pas015Id")]
        [InverseProperty("Pas015Cqzone")]
        public virtual Pas015 Pas015 { get; set; }
    }
}
