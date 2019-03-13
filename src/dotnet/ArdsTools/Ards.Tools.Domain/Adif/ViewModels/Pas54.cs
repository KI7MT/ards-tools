using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.ViewModels
{
    [Table("pas54", Schema = "adif_view")]
    public partial class Pas54
    {
        [Key]
        [Display(Name = "Pas54Id")]
        [Column("pas54_id")]
        public int Pas54Id { get; set; }

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

        [Display(Name = "Oblast")]
        [Column("oblast", TypeName = "character(4)")]
        public string Oblast { get; set; }

        [Display(Name = "CQ Zone")]
        [Column("cqzone")]
        public int? Cqzone { get; set; }

        [Display(Name = "ITU Zone")]
        [Column("ituzone")]
        public int? Ituzone { get; set; }
    }
}
