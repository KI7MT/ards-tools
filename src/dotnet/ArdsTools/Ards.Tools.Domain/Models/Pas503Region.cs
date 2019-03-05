using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.Adif.Models
{
    [Table("pas_503_region", Schema = "adif")]
    public partial class Pas503Region
    {
        public Pas503Region()
        {
            Pas503Subdivision = new HashSet<Pas503Subdivision>();
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
        [InverseProperty("Pas503Region")]
        public virtual Dxcc Dxcc { get; set; }
        [InverseProperty("Pas503Region")]
        public virtual ICollection<Pas503Subdivision> Pas503Subdivision { get; set; }
    }
}
