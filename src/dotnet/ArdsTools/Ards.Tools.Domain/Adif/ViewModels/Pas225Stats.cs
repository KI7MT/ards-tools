using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.ViewModels
{
    [Table("pas225_stats", Schema = "adif_view")]
    public partial class Pas225Stats
    {
        [Key]
        [Display(Name = "Pas225StatsId")]
        [Column("pas225_stats_id")]
        public int Pas225StatsId { get; set; }

        [Display(Name = "Region")]
        [Column("region")]
        [StringLength(120)]
        public string Region { get; set; }

        [Display(Name = "Subdivision Count")]
        [Column("subdivision_count")]
        public long? SubdivisionCount { get; set; }
    }
}
