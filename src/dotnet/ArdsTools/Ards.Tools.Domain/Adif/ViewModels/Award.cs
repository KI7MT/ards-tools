using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.ViewModels
{
    [Table("award", Schema = "adif_view")]
    public partial class Award
    {
        [Key]
        [Display(Name = "AwardId")]
        [Column("award_id")]
        public int AwardId { get; set; }

        [Display(Name = "Award Name")]
        [Column("award_name")]
        [StringLength(15)]
        public string AwardName { get; set; }

        [Display(Name = "Is Import Only")]
        [Column("is_import_only")]
        public bool? IsImportOnly { get; set; }
    }
}
