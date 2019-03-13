using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.ViewModels
{
    [Table("pas15_stats", Schema = "adif_view")]
    public partial class Pas15Stats
    {
        [Key]
        [Display(Name = "PasStatsId")]
        [Column("pas15_stats_id")]
        public int Pas15StatsId { get; set; }

        [Display(Name = "Total Count")]
        [Column("Total Count")]
        public long? TotalCount { get; set; }

        [Display(Name = "Before Count")]
        [Column("Before Count")]
        public long? BeforeCount { get; set; }

        [Display(Name = "Current Count")]
        [Column("Current Count")]
        public long? CurrentCount { get; set; }

    }
}
