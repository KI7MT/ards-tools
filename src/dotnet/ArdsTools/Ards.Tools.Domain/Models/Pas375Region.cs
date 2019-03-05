using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.Adif.Models
{
    [Table("pas_375_region", Schema = "adif")]
    public partial class Pas375Region
    {
        public Pas375Region()
        {
            Pas375Subdivision = new HashSet<Pas375Subdivision>();
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
        [InverseProperty("Pas375Region")]
        public virtual Dxcc Dxcc { get; set; }
        [InverseProperty("Pas375Region")]
        public virtual ICollection<Pas375Subdivision> Pas375Subdivision { get; set; }
    }
}
