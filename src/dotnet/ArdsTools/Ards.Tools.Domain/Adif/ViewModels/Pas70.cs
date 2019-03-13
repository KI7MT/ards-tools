using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.ViewModels
{
    [Table("pas70", Schema = "adif_view")]
    public partial class Pas70
    {
        [Key]
        [Display(Name = "Pas70Id")]
        [Column("pas70_id")]
        public int Pas70Id { get; set; }

        [Display(Name = "DXCC Code")]
        [Column("dxcc_code")]
        public int? DxccCode { get; set; }

        [Display(Name = "Cpimty")]
        [Column("country")]
        [StringLength(90)]
        public string Country { get; set; }

        [Display(Name = "Code")]
        [Column("code", TypeName = "character(4)")]
        public string Code { get; set; }

        [Display(Name = "Sundivision")]
        [Column("subdivision")]
        [StringLength(120)]
        public string Subdivision { get; set; }
    }
}
