using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.ViewModels
{
    [Table("pas_summary", Schema = "adif_view")]
    public partial class PasSummary
    {
        [Key]
        [Display(Name = "PasSummaryId")]
        [Column("pas_summary_id")]
        public int PasSummaryId { get; set; }

        [Display(Name = "DXCC Code")]
        [Column("dxcc_code")]
        public int? DxccCode { get; set; }

        [Display(Name = "Country")]
        [Column("country")]
        [StringLength(90)]
        public string Country { get; set; }

        [Display(Name = "Pri. Subdivision")]
        [Column("pri_subdivision")]
        [StringLength(20)]
        public string PriSubdivision { get; set; }

        [Display(Name = "Has Oblast")]
        [Column("has_oblast")]
        public bool? HasOblast { get; set; }

        [Display(Name = "has Secondary")]
        [Column("has_secondary")]
        public bool? HasSecondary { get; set; }

        [Display(Name = "Sec. Subdivision")]
        [Column("sec_subdivision")]
        [StringLength(20)]
        public string SecSubdivision { get; set; }
    }
}