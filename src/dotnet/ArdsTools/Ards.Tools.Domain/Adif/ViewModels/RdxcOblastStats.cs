using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.ViewModels
{
    [Table("rdxc_oblast_stats", Schema = "adif_view")]
    public partial class RdxcOblastStats
    {

        [Key]
        [Display(Name = "RdxcOblastStatsId")]
        [Column("rdxc_oblast_stats_id")]
        public int RdxcOblastStatsId { get; set; }

        [Display(Name = "Oblast Count")]
        [Column("oblast_count")]
        public long? OblastCount { get; set; }

        [Display(Name = "Total Districts")]
        [Column("total_districts")]
        public long? TotalDistricts { get; set; }

        [Display(Name = "Current Districts")]
        [Column("current_districts")]
        public long? CurrentDistricts { get; set; }

        [Display(Name = "New Districts")]
        [Column("new_districts")]
        public long? NewDistricts { get; set; }

        [Display(Name = "Deleted Districts")]
        [Column("deleted_districts")]
        public long? DeletedDistricts { get; set; }

    }
}
