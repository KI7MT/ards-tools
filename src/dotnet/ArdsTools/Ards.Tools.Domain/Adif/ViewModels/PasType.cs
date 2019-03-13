using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.ViewModels
{
    [Table("pas_type", Schema = "adif_view")]
    public partial class PasType
    {
        [Key]
        [Display(Name = "PasTypeId")]
        [Column("pas_type_id")]
        public int PasTypeId { get; set; }

        [Display(Name = "Pri. Subdivision Type")]
        [Column("pri_subdivision_type")]
        [StringLength(20)]
        public string PriSubdivisionType { get; set; }
    }
}
