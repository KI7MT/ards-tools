using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.ViewModels
{
    [Table("credit", Schema = "adif_view")]
    public partial class Credit
    {
        [Key]
        [Display(Name = "CreditId")]
        [Column("credit_id")]
        public int CreditId { get; set; }

        [Display(Name = "Credit For")]
        [Column("credit_for")]
        [StringLength(24)]
        public string CreditFor { get; set; }

        [Display(Name = "Sponsor")]
        [Column("sponsor")]
        [StringLength(20)]
        public string Sponsor { get; set; }

        [Display(Name = "Award")]
        [Column("award")]
        [StringLength(60)]
        public string Award { get; set; }

        [Display(Name = "Facet")]
        [Column("facet")]
        [StringLength(20)]
        public string Facet { get; set; }
    }
}
