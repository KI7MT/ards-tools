using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.Adif.Models
{
    [Table("pas_503_subdivision", Schema = "adif")]
    public partial class Pas503Subdivision
    {
        [Column("id")]
        public int Id { get; set; }
        [Column("pas_503_region_id")]
        public int Pas503RegionId { get; set; }
        [Required]
        [Column("code", TypeName = "character(3)")]
        public string Code { get; set; }
        [Required]
        [Column("subdivision")]
        [StringLength(60)]
        public string Subdivision { get; set; }

        [ForeignKey("Pas503RegionId")]
        [InverseProperty("Pas503Subdivision")]
        public virtual Pas503Region Pas503Region { get; set; }
    }
}
