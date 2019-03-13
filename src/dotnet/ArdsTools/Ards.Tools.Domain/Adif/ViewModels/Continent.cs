using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.ViewModels
{
    [Table("continent", Schema = "adif_view")]
    public partial class Continent
    {
        [Key]
        [Display(Name = "ContinentId")]
        [Column("continent_id")]
        public int ContinentId { get; set; }

        [Display(Name = "Abbreviation")]
        [Column("abbreviation")]
        [StringLength(2)]
        public string Abbreviation { get; set; }

        [Display(Name = "Continent")]
        [Column("continent")]
        [StringLength(14)]
        public string Continent1 { get; set; }
    }
}
