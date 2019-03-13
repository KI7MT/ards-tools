using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.ViewModels
{
    [Table("mode", Schema = "adif_view")]
    public partial class Mode
    {
        [Key]
        [Display(Name = "ModeId")]
        [Column("mode_id")]
        public int ModeId { get; set; }

        [Display(Name = "Mode")]
        [Column("mode")]
        [StringLength(20)]
        public string Mode1 { get; set; }

        [Display(Name = "Is Import Only")]
        [Column("is_import_only")]
        public bool? IsImportOnly { get; set; }
    }
}
