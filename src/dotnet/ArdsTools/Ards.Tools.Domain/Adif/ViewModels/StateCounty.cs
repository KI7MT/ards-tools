using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.ViewModels
{
    [Table("state_county", Schema = "adif_view")]
    public partial class StateCounty
    {
        [Key]
        [Display(Name = "StateCountyId")]
        [Column("state_county_id")]
        public int StateCountyId { get; set; }

        [Display(Name = "Abbreviation")]
        [Column("abbreviation")]
        [StringLength(2)]
        public string Abbreviation { get; set; }

        [Display(Name = "State name")]
        [Column("state_name")]
        [StringLength(20)]
        public string StateName { get; set; }

        [Display(Name = "County")]
        [Column("county")]
        [StringLength(60)]
        public string County { get; set; }
    }
}
