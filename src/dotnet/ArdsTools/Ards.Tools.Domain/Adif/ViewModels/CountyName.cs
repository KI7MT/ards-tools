using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.ViewModels
{
    [Table("county_name", Schema = "adif_view")]
    public partial class CountyName
    {
        [Key]
        [Display(Name = "CountyNameId")]
        [Column("county_name_id")]
        public int CountyNameId { get; set; }

        [Display(Name = "County Name")]
        [Column("county_name")]
        [StringLength(60)]
        public string CountyName1 { get; set; }
    }
}