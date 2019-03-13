using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.ViewModels
{
    [Table("pas15_current", Schema = "adif_view")]
    public partial class Pas15Current
    {
        [Key]
        [Display(Name = "Pas15CurrentId")]
        [Column("pas15_current_id")]
        public int Pas15CurrentId { get; set; }

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
        [Column("cqzone")]
        public string Cqzone { get; set; }

        [Display(Name = "ITU ZOne")]
        [Column("ituzone")]
        public string Ituzone { get; set; }

        [Display(Name = "Oblast")]
        [Column("oblast", TypeName = "character(4)")]
        public string Oblast { get; set; }

        [Display(Name = "Before Date")]
        [Column("before_date", TypeName = "date")]
        public DateTime? BeforeDate { get; set; }

        [Display(Name = "Referred To As")]
        [Column("referred_to_as")]
        [StringLength(60)]
        public string ReferredToAs { get; set; }

        [Display(Name = "Pas15Id")]
        [Column("pas15_id")]
        public int? Pas15Id { get; set; }
    }
}
