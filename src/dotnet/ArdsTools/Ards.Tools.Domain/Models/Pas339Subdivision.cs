using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.Adif.Models
{
    [Table("pas_339_subdivision", Schema = "adif")]
    public partial class Pas339Subdivision
    {
        [Column("id")]
        public int Id { get; set; }
        [Column("pas_339_region_id")]
        public int Pas339RegionId { get; set; }
        [Required]
        [Column("code", TypeName = "character(2)")]
        public string Code { get; set; }
        [Required]
        [Column("subdivision")]
        [StringLength(20)]
        public string Subdivision { get; set; }

        [ForeignKey("Pas339RegionId")]
        [InverseProperty("Pas339Subdivision")]
        public virtual Pas339Region Pas339Region { get; set; }
    }
}
