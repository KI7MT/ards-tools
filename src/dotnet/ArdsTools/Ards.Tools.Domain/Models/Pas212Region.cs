using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.Adif.Models
{
    [Table("pas_212_region", Schema = "adif")]
    public partial class Pas212Region
    {
        public Pas212Region()
        {
            Pas212Subdivision = new HashSet<Pas212Subdivision>();
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
        [InverseProperty("Pas212Region")]
        public virtual Dxcc Dxcc { get; set; }
        [InverseProperty("Pas212Region")]
        public virtual ICollection<Pas212Subdivision> Pas212Subdivision { get; set; }
    }
}
