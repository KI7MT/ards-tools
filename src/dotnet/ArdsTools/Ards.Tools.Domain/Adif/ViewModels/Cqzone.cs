using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.ViewModels
{
    [Table("cqzone", Schema = "adif_view")]
    public partial class Cqzone
    {
        [Key]
        [Display(Name = "CqzoneId")]
        [Column("cqzone_id")]
        public int CqzoneId { get; set; }

        [Display(Name = "CQ Zone")]
        [Column("cqzone")]
        public int? Cqzone1 { get; set; }

        [Display(Name = "Description")]
        [Column("description")]
        [StringLength(60)]
        public string Description { get; set; }
    }
}