using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.Adif.Models
{
    [Table("pas_206_region", Schema = "adif")]
    public partial class Pas206Region
    {
        public Pas206Region()
        {
            Pas206Subdivision = new HashSet<Pas206Subdivision>();
        }

        [Column("id")]
        public int Id { get; set; }
        [Column("dxcc_id")]
        public int DxccId { get; set; }
        [Required]
        [Column("region")]
        [StringLength(60)]
        public string Region { get; set; }

        [ForeignKey("DxccId")]
        [InverseProperty("Pas206Region")]
        public virtual Dxcc Dxcc { get; set; }
        [InverseProperty("Pas206Region")]
        public virtual ICollection<Pas206Subdivision> Pas206Subdivision { get; set; }
    }
}
