using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.ViewModels
{
    [Table("pas291", Schema = "adif_view")]
    public partial class Pas291
    {
        [Key]
        [Display(Name = "Pas291Id")]
        [Column("pas291_id")]
        public int Pas291Id { get; set; }

        [Display(Name = "DXCC Code")]
        [Column("dxcc_code")]
        public int? DxccCode { get; set; }

        [Display(Name = "Country")]
        [Column("country")]
        [StringLength(90)]
        public string Country { get; set; }

        [Display(Name = "Code")]
        [Column("code", TypeName = "character(4)")]
        public string Code { get; set; }

        [Display(Name = "Subdivision")]
        [Column("subdivision")]
        [StringLength(120)]
        public string Subdivision { get; set; }

        [Display(Name = "CQ ZOne")]
        [Column("cq_zone")]
        public string CqZone { get; set; }

        [Display(Name = "ITU ZOne")]
        [Column("itu_zone")]
        public string ItuZone { get; set; }
    }
}
