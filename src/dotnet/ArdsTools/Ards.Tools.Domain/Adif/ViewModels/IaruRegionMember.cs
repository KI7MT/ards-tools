using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.ViewModels
{
    [Table("iaru_region_member", Schema = "adif_view")]
    public partial class IaruRegionMember
    {
        [Key]
        [Display(Name = "IaruRegionMemberId")]
        [Column("iaru_region_member_id")]
        public int IaruRegionMemberId { get; set; }

        [Display(Name = "Region")]
        [Column("region")]
        public int? Region { get; set; }

        [Display(Name = "Name")]
        [Column("name")]
        [StringLength(120)]
        public string Name { get; set; }

        [Display(Name = "Territory")]
        [Column("territory")]
        [StringLength(60)]
        public string Territory { get; set; }
    }
}
