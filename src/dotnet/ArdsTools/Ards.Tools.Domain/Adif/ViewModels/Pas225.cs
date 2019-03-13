using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.ViewModels
{
    [Table("pas225", Schema = "adif_view")]
    public partial class Pas225
    {
        [Key]
        [Display(Name = "Pas225Id")]
        [Column("pas225_id")]
        public int Pas225Id { get; set; }

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
        [Column("pas_code", TypeName = "character(4)")]
        public string PasCode { get; set; }

        [Display(Name = "Subdivision")]
        [Column("subdivision")]
        [StringLength(120)]
        public string Subdivision { get; set; }

        [Display(Name = "Is Import Only")]
        [Column("is_import_only")]
        public bool? IsImportOnly { get; set; }
    }
}
