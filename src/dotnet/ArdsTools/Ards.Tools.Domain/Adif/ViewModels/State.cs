using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.ViewModels
{
    [Table("state", Schema = "adif_view")]
    public partial class State
    {
        [Key]
        [Display(Name = "StateId")]
        [Column("state_id")]
        public int StateId { get; set; }

        [Display(Name = "Abbreviation")]
        [Column("abbreviation")]
        [StringLength(2)]
        public string Abbreviation { get; set; }

        [Display(Name = "State Name")]
        [Column("state_name")]
        [StringLength(20)]
        public string StateName { get; set; }
    }
}
