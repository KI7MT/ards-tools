using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.Adif.Models
{
    [Table("pas_339_region", Schema = "adif")]
    public partial class Pas339Region
    {
        public Pas339Region()
        {
            Pas339Subdivision = new HashSet<Pas339Subdivision>();
        }

        [Column("id")]
        public int Id { get; set; }
        [Column("dxcc_id")]
        public int DxccId { get; set; }
        [Required]
        [Column("region")]
        [StringLength(20)]
        public string Region { get; set; }

        [ForeignKey("DxccId")]
        [InverseProperty("Pas339Region")]
        public virtual Dxcc Dxcc { get; set; }
        [InverseProperty("Pas339Region")]
        public virtual ICollection<Pas339Subdivision> Pas339Subdivision { get; set; }
    }
}
