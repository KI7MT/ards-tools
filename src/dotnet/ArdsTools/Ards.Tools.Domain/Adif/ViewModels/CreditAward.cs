using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.ViewModels
{
    [Table("credit_award", Schema = "adif_view")]
    public partial class CreditAward
    {
        [Key]
        [Display(Name = "CreditAwardId")]
        [Column("credit_award_id")]
        public int CreditAwardId { get; set; }

        [Display(Name = "Award Name")]
        [Column("award_name")]
        [StringLength(60)]
        public string AwardName { get; set; }
    }
}