using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.ViewModels
{
    [Table("propogation_mode", Schema = "adif_view")]
    public partial class PropogationMode
    {
        [Key]
        [Display(Name = "PropogationModeId")]
        [Column("propogation_mode_id")]
        public int PropogationModeId { get; set; }

        [Display(Name = "Enumeration")]
        [Column("enumeration")]
        [StringLength(20)]
        public string Enumeration { get; set; }

        [Display(Name = "Description")]
        [Column("description")]
        [StringLength(120)]
        public string Description { get; set; }
    }
}
