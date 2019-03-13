using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.ViewModels
{
    [Table("sas15", Schema = "adif_view")]
    public partial class Sas15
    {
        [Key]
        [Display(Name = "Sas15Id")]
        [Column("sas15_id")]
        public int Sas15Id { get; set; }

        [Display(Name = "DXCC Code")]
        [Column("dxcc_code")]
        public int? DxccCode { get; set; }

        [Display(Name = "DXCC Name")]
        [Column("dxcc_name")]
        [StringLength(90)]
        public string DxccName { get; set; }

        [Display(Name = "Prefix")]
        [Column("prefix")]
        [StringLength(120)]
        public string Prefix { get; set; }

        [Display(Name = "Name")]
        [Column("name")]
        [StringLength(120)]
        public string Name { get; set; }

        [Display(Name = "Code")]
        [Column("code")]
        [StringLength(120)]
        public string Code { get; set; }

        [Display(Name = "Description")]
        [Column("description")]
        [StringLength(120)]
        public string Description { get; set; }
    }
}
