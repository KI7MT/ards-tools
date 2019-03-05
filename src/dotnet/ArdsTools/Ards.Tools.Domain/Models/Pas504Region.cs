using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.Adif.Models
{
    [Table("pas_504_region", Schema = "adif")]
    public partial class Pas504Region
    {
        public Pas504Region()
        {
            Pas504Subdivision = new HashSet<Pas504Subdivision>();
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
        [InverseProperty("Pas504Region")]
        public virtual Dxcc Dxcc { get; set; }
        [InverseProperty("Pas504Region")]
        public virtual ICollection<Pas504Subdivision> Pas504Subdivision { get; set; }
    }
}
