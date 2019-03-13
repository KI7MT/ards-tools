using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.ViewModels
{
    [Table("sas_type", Schema = "adif_view")]
    public partial class SasType
    {
        [Key]
        [Display(Name = "SasTypeId")]
        [Column("sas_type_id")]
        public int SasTypeId { get; set; }

        [Display(Name = "Sec. Subdivision")]
        [Column("sec_subdivision")]
        [StringLength(20)]
        public string SecSubdivision { get; set; }
    }
}
