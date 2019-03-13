using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.ViewModels
{
    [Table("pas206", Schema = "adif_view")]
    public partial class Pas206
    {
        [Key]
        [Display(Name = "Pas206Id")]
        [Column("pas206_id")]
        public int Pas206Id { get; set; }

        [Display(Name = "DXCC Code")]
        [Column("dxcc_code")]
        public int? DxccCode { get; set; }

        [Display(Name = "Country")]
        [Column("country")]
        [StringLength(90)]
        public string Country { get; set; }

        [Display(Name = "Region")]
        [Column("region")]
        [StringLength(120)]
        public string Region { get; set; }

        [Display(Name = "Code")]
        [Column("code", TypeName = "character(4)")]
        public string Code { get; set; }

        [Display(Name = "Subdivision")]
        [Column("subdivision")]
        [StringLength(120)]
        public string Subdivision { get; set; }

        [Display(Name = "Before Date")]
        [Column("before_date", TypeName = "date")]
        public DateTime? BeforeDate { get; set; }

        [Display(Name = "After Date")]
        [Column("after_date", TypeName = "date")]
        public DateTime? AfterDate { get; set; }

    }
}
