using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.Adif.Models
{
    [Table("pas_225_subdivision", Schema = "adif")]
    public partial class Pas225Subdivision
    {
        [Column("id")]
        public int Id { get; set; }
        [Column("pas_225_region_id")]
        public int Pas225RegionId { get; set; }
        [Required]
        [Column("code", TypeName = "character(2)")]
        public string Code { get; set; }
        [Required]
        [Column("subdivision")]
        [StringLength(60)]
        public string Subdivision { get; set; }
        [Column("import_only")]
        public bool ImportOnly { get; set; }

        [ForeignKey("Pas225RegionId")]
        [InverseProperty("Pas225Subdivision")]
        public virtual Pas225Region Pas225Region { get; set; }
    }
}
