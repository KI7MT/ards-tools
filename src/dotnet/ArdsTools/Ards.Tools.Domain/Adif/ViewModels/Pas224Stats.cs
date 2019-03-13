using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.ViewModels
{
    [Table("pas224_stats", Schema = "adif_view")]
    public partial class Pas224Stats
    {
        [Key]
        [Display(Name = "Pas224StatsId")]
        [Column("pas224_stats_id")]
        public int Pas224StatsId { get; set; }

        [Display(Name = "Region")]
        [Column("region")]
        [StringLength(120)]
        public string Region { get; set; }

        [Display(Name = "Subdivision Count")]
        [Column("subdivision_count")]
        public long? SubdivisionCount { get; set; }
    }
}
