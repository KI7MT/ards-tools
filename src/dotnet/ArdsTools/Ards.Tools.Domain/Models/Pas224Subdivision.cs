using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.Adif.Models
{
    [Table("pas_224_subdivision", Schema = "adif")]
    public partial class Pas224Subdivision
    {
        [Column("id")]
        public int Id { get; set; }
        [Column("pas_224_region_id")]
        public int Pas224RegionId { get; set; }
        [Required]
        [Column("code", TypeName = "character(3)")]
        public string Code { get; set; }
        [Required]
        [Column("subdivision")]
        [StringLength(70)]
        public string Subdivision { get; set; }

        [ForeignKey("Pas224RegionId")]
        [InverseProperty("Pas224Subdivision")]
        public virtual Pas224Region Pas224Region { get; set; }
    }
}
