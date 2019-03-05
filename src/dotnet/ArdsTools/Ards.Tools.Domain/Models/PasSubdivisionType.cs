using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.Adif.Models
{
    [Table("pas_subdivision_type", Schema = "adif")]
    public partial class PasSubdivisionType
    {
        public PasSubdivisionType()
        {
            PasSummary = new HashSet<PasSummary>();
        }

        [Column("id")]
        public int Id { get; set; }
        [Required]
        [Column("pas_subdivision_type")]
        [StringLength(20)]
        public string PasSubdivisionType1 { get; set; }

        [InverseProperty("PasSubdivisionType")]
        public virtual ICollection<PasSummary> PasSummary { get; set; }
    }
}
