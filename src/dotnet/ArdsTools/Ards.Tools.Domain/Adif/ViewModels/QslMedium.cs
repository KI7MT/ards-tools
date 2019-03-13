using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.ViewModels
{
    [Table("qsl_medium", Schema = "adif_view")]
    public partial class QslMedium
    {
        [Key]
        [Display(Name = "QslMediumId")]
        [Column("qsl_medium_id")]
        public int QslMediumId { get; set; }

        [Display(Name = "Medium")]
        [Column("medium")]
        [StringLength(10)]
        public string Medium { get; set; }

        [Display(Name = "Description")]
        [Column("description")]
        [StringLength(120)]
        public string Description { get; set; }
    }
}
