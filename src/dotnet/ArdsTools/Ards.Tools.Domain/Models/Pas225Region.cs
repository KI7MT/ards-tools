using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.Adif.Models
{
    [Table("pas_225_region", Schema = "adif")]
    public partial class Pas225Region
    {
        public Pas225Region()
        {
            Pas225Subdivision = new HashSet<Pas225Subdivision>();
        }

        [Column("id")]
        public int Id { get; set; }
        [Column("dxcc_id")]
        public int DxccId { get; set; }
        [Required]
        [Column("region")]
        [StringLength(40)]
        public string Region { get; set; }

        [ForeignKey("DxccId")]
        [InverseProperty("Pas225Region")]
        public virtual Dxcc Dxcc { get; set; }
        [InverseProperty("Pas225Region")]
        public virtual ICollection<Pas225Subdivision> Pas225Subdivision { get; set; }
    }
}
