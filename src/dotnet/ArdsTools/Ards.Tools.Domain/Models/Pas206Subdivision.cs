using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.Adif.Models
{
    [Table("pas_206_subdivision", Schema = "adif")]
    public partial class Pas206Subdivision
    {
        [Column("id")]
        public int Id { get; set; }
        [Column("pas_206_region_id")]
        public int Pas206RegionId { get; set; }
        [Required]
        [Column("code", TypeName = "character(2)")]
        public string Code { get; set; }
        [Required]
        [Column("subdivision")]
        [StringLength(60)]
        public string Subdivision { get; set; }
        [Column("before_date", TypeName = "date")]
        public DateTime? BeforeDate { get; set; }

        [ForeignKey("Pas206RegionId")]
        [InverseProperty("Pas206Subdivision")]
        public virtual Pas206Region Pas206Region { get; set; }
    }
}
