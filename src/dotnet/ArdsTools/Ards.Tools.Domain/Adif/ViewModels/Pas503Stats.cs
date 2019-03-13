using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.ViewModels
{
    [Table("pas503_stats", Schema = "adif_view")]
    public partial class Pas503Stats
    {
        [Key]
        [Display(Name = "Pas503StatsId")]
        [Column("pas503_stats_id")]
        public int Pas503StatsId { get; set; }

        [Display(Name = "Region")]
        [Column("region")]
        [StringLength(120)]
        public string Region { get; set; }

        [Display(Name = "Subdivision")]
        [Column("subdivision_count")]
        public long? SubdivisionCount { get; set; }
    }
}
