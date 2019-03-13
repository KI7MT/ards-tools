using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.ViewModels
{
    [Table("qsl_via", Schema = "adif_view")]
    public partial class QslVia
    {
        [Key]
        [Display(Name = "QslViaId")]
        [Column("qsl_via_id")]
        public int QslViaId { get; set; }

        [Display(Name = "Via")]
        [Column("via")]
        [StringLength(1)]
        public string Via { get; set; }

        [Display(Name = "Description")]
        [Column("description")]
        [StringLength(20)]
        public string Description { get; set; }

        [Display(Name = "Is Import Only")]
        [Column("is_import_only")]
        public bool? IsImportOnly { get; set; }
    }
}
