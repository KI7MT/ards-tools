using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.ViewModels
{
    [Table("contest", Schema = "adif_view")]
    public partial class Contest
    {
        [Key]
        [Display(Name = "ContestId")]
        [Column("contest_id")]
        public int ContestId { get; set; }

        [Display(Name = "Contest Name")]
        [Column("contest_name")]
        [StringLength(60)]
        public string ContestName { get; set; }

        [Display(Name = "Description")]
        [Column("description")]
        [StringLength(120)]
        public string Description { get; set; }

        [Display(Name = "Is Import Only")]
        [Column("is_import_only")]
        public bool? IsImportOnly { get; set; }

        [Display(Name = "Weblink URL")]
        [Column("weblink_url")]
        [StringLength(255)]
        public string WeblinkUrl { get; set; }
    }
}
