using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.Adif.Models
{
    [Table("sas_subdivision_type", Schema = "adif")]
    public partial class SasSubdivisionType
    {
        public SasSubdivisionType()
        {
            PasSummary = new HashSet<PasSummary>();
        }

        [Column("id")]
        public int Id { get; set; }
        [Required]
        [Column("sas_subdivision_type")]
        [StringLength(20)]
        public string SasSubdivisionType1 { get; set; }

        [InverseProperty("SasSubdivisionType")]
        public virtual ICollection<PasSummary> PasSummary { get; set; }
    }
}
