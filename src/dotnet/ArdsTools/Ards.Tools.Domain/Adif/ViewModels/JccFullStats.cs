using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.ViewModels
{
    [Table("jcc_full_stats", Schema = "adif_view")]
    public partial class JccFullStats
    {
        [Key]
        [Display(Name = "JccFullStatsId")]
        [Column("jcc_full_stats_id")]
        public int JccFullStatsId { get; set; }

        [Display(Name = "Prefecture Count")]
        [Column("prefecture_count")]
        public long? PrefectureCount { get; set; }

        [Display(Name = "Total Cities")]
        [Column("total_cities")]
        public long? TotalCities { get; set; }

        [Display(Name = "Current Cities")]
        [Column("current_cities")]
        public long? CurrentCities { get; set; }

        [Display(Name = "Deleted Cities")]
        [Column("deleted_cities")]
        public long? DeletedCities { get; set; }

    }
}
