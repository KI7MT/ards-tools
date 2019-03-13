using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.ViewModels
{
    [Table("pas212_stats", Schema = "adif_view")]
    public partial class Pas212Stats
    {
        [Key]
        [Display(Name = "Pas212StatsId")]
        [Column("pas212_stats_id")]
        public int Pas212StatsId { get; set; }

        [Display(Name = "Region")]
        [Column("region")]
        [StringLength(120)]
        public string Region { get; set; }

        [Display(Name = "Subdivision Count")]
        [Column("subdivision_count")]
        public long? SubdivisionCount { get; set; }
    }
}
