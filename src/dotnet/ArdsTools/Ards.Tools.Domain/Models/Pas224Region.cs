using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.Adif.Models
{
    [Table("pas_224_region", Schema = "adif")]
    public partial class Pas224Region
    {
        public Pas224Region()
        {
            Pas224Subdivision = new HashSet<Pas224Subdivision>();
        }

        [Column("id")]
        public int Id { get; set; }
        [Column("dxcc_id")]
        public int DxccId { get; set; }
        [Required]
        [Column("region")]
        [StringLength(70)]
        public string Region { get; set; }

        [ForeignKey("DxccId")]
        [InverseProperty("Pas224Region")]
        public virtual Dxcc Dxcc { get; set; }
        [InverseProperty("Pas224Region")]
        public virtual ICollection<Pas224Subdivision> Pas224Subdivision { get; set; }
    }
}
