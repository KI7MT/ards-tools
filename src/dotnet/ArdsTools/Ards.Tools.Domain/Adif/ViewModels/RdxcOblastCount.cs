using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.ViewModels
{
    [Table("rdxc_oblast_count", Schema = "adif_view")]
    public partial class RdxcOblastCount
    {
        [Key]
        [Display(Name = "RdxcOblastCountId")]
        [Column("rdxc_oblast_count_id")]
        public int RdxcOblastCountId { get; set; }

        [Display(Name = "RDXC Code")]
        [Column("rdxc_code", TypeName = "character(4)")]
        public string RdxcCode { get; set; }

        [Display(Name = "Prefix")]
        [Column("prefix", TypeName = "character(4)")]
        public string Prefix { get; set; }

        [Display(Name = "Oblast")]
        [Column("oblast")]
        [StringLength(60)]
        public string Oblast { get; set; }

        [Display(Name = "Total Count")]
        [Column("total_count")]
        public long? TotalCount { get; set; }
    }
}
