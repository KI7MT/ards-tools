using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.ViewModels
{
    [Table("jcc_prefecture_stats", Schema = "adif_view")]
    public partial class JccPrefectureStats
    {
        [Key]
        [Display(Name = "JccPrefectureStatsId")]
        [Column("jcc_prefecture_stats_id")]
        public int JccPrefectureStatsId { get; set; }

        [Display(Name = "Prefecture")]
        [Column("prefecture")]
        [StringLength(30)]
        public string Prefecture { get; set; }

        [Display(Name = "City Count")]
        [Column("city_count")]
        public long? CityCount { get; set; }

    }
}
