using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.ViewModels
{
    [Table("credit_sponsor", Schema = "adif_view")]
    public partial class CreditSponsor
    {
        [Key]
        [Display(Name = "CreditSponsorId")]
        [Column("credit_sponsor_id")]
        public int CreditSponsorId { get; set; }

        [Display(Name = "Sponsor")]
        [Column("sponsor")]
        [StringLength(20)]
        public string Sponsor { get; set; }
    }
}
