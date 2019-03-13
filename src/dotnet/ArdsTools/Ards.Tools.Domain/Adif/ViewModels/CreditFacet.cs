using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.ViewModels
{
    [Table("credit_facet", Schema = "adif_view")]
    public partial class CreditFacet
    {
        [Key]
        [Display(Name = "CreditFacetId")]
        [Column("credit_facet_id")]
        public int CreditFacetId { get; set; }

        [Display(Name = "Facet")]
        [Column("facet")]
        [StringLength(20)]
        public string Facet { get; set; }
    }
}
