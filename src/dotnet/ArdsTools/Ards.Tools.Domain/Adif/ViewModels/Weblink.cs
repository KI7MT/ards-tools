using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.ViewModels
{
    [Table("weblink", Schema = "adif_view")]
    public partial class Weblink
    {
        [Key]
        [Display(Name = "WeblinkId")]
        [Column("weblink_id")]
        public int WeblinkId { get; set; }

        [Display(Name = "Orginazation")]
        [Column("orginization")]
        [StringLength(120)]
        public string Orginization { get; set; }

        [Display(Name = "Weblink URL")]
        [Column("weblink_url")]
        [StringLength(255)]
        public string WeblinkUrl { get; set; }
    }
}
