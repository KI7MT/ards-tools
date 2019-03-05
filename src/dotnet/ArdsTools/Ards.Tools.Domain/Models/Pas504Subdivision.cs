using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.Adif.Models
{
    [Table("pas_504_subdivision", Schema = "adif")]
    public partial class Pas504Subdivision
    {
        [Column("id")]
        public int Id { get; set; }
        [Column("pas_504_region_id")]
        public int Pas504RegionId { get; set; }
        [Required]
        [Column("code", TypeName = "character(3)")]
        public string Code { get; set; }
        [Required]
        [Column("subdivision")]
        [StringLength(20)]
        public string Subdivision { get; set; }

        [ForeignKey("Pas504RegionId")]
        [InverseProperty("Pas504Subdivision")]
        public virtual Pas504Region Pas504Region { get; set; }
    }
}
