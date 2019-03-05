using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.Adif.Models
{
    [Table("pas_291_cqzone", Schema = "adif")]
    public partial class Pas291Cqzone
    {
        [Column("id")]
        public int Id { get; set; }
        [Column("pas_291_id")]
        public int Pas291Id { get; set; }
        [Column("cq_zone_id")]
        public int CqZoneId { get; set; }

        [ForeignKey("CqZoneId")]
        [InverseProperty("Pas291Cqzone")]
        public virtual CqZone CqZone { get; set; }
        [ForeignKey("Pas291Id")]
        [InverseProperty("Pas291Cqzone")]
        public virtual Pas291 Pas291 { get; set; }
    }
}
