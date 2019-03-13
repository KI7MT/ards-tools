using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.ViewModels
{
    [Table("submode", Schema = "adif_view")]
    public partial class Submode
    {
        [Key]
        [Display(Name = "SubmodeId")]
        [Column("submode_id")]
        public int SubmodeId { get; set; }

        [Display(Name = "Mode")]
        [Column("mode")]
        [StringLength(20)]
        public string Mode { get; set; }

        [Display(Name = "Submode")]
        [Column("submode")]
        [StringLength(20)]
        public string Submode1 { get; set; }
    }
}
