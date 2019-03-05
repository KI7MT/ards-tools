using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.Adif.Models
{
    [Table("pas_248_subdivision", Schema = "adif")]
    public partial class Pas248Subdivision
    {
        [Column("id")]
        public int Id { get; set; }
        [Column("pas_248_region_id")]
        public int Pas248RegionId { get; set; }
        [Required]
        [Column("code", TypeName = "character(2)")]
        public string Code { get; set; }
        [Required]
        [Column("subdivision")]
        [StringLength(60)]
        public string Subdivision { get; set; }
        [Column("import_only")]
        public bool ImportOnly { get; set; }

        [ForeignKey("Pas248RegionId")]
        [InverseProperty("Pas248Subdivision")]
        public virtual Pas248Region Pas248Region { get; set; }
    }
}
