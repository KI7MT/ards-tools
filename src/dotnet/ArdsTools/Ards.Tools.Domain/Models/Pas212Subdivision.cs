using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.Adif.Models
{
    [Table("pas_212_subdivision", Schema = "adif")]
    public partial class Pas212Subdivision
    {
        [Column("id")]
        public int Id { get; set; }
        [Column("pas_212_region_id")]
        public int Pas212RegionId { get; set; }
        [Required]
        [Column("code", TypeName = "character(2)")]
        public string Code { get; set; }
        [Required]
        [Column("subdivision")]
        [StringLength(70)]
        public string Subdivision { get; set; }

        [ForeignKey("Pas212RegionId")]
        [InverseProperty("Pas212Subdivision")]
        public virtual Pas212Region Pas212Region { get; set; }
    }
}
