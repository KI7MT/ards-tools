using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.Adif.Models
{
    [Table("pas_375_subdivision", Schema = "adif")]
    public partial class Pas375Subdivision
    {
        [Column("id")]
        public int Id { get; set; }
        [Column("pas_375_region_id")]
        public int Pas375RegionId { get; set; }
        [Required]
        [Column("code", TypeName = "character(3)")]
        public string Code { get; set; }
        [Required]
        [Column("subdivision")]
        [StringLength(60)]
        public string Subdivision { get; set; }

        [ForeignKey("Pas375RegionId")]
        [InverseProperty("Pas375Subdivision")]
        public virtual Pas375Region Pas375Region { get; set; }
    }
}
