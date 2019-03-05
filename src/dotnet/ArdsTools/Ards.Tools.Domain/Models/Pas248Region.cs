using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.Adif.Models
{
    [Table("pas_248_region", Schema = "adif")]
    public partial class Pas248Region
    {
        public Pas248Region()
        {
            Pas248Subdivision = new HashSet<Pas248Subdivision>();
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
        [InverseProperty("Pas248Region")]
        public virtual Dxcc Dxcc { get; set; }
        [InverseProperty("Pas248Region")]
        public virtual ICollection<Pas248Subdivision> Pas248Subdivision { get; set; }
    }
}
