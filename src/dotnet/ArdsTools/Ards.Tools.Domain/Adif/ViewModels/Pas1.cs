using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.ViewModels
{
    [Table("pas1", Schema = "adif_view")]
    public partial class Pas1
    {
        [Key]
        [Display(Name = "Pas1Id")]
        [Column("pas1_id")]
        public int Pas1Id { get; set; }

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

        [Display(Name = "CQ Zone")]
        [Column("cq_zone")]
        public string CqZone { get; set; }

        [Display(Name = "ITU Zone")]
        [Column("itu_zone")]
        public string ItuZone { get; set; }

    }
}
