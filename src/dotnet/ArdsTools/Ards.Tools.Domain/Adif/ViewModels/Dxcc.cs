using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.ViewModels
{
    [Table("dxcc", Schema = "adif_view")]
    public partial class Dxcc
    {
        [Key]
        [Display(Name = "DxccId")]
        [Column("dxcc_id")]
        public int DxccId { get; set; }

        [Display(Name = "DXCC Code")]
        [Column("dxcc_code")]
        [StringLength(4)]
        public string DxccCode { get; set; }

        [Display(Name = "DXCC Name")]
        [Column("dxcc_name")]
        [StringLength(90)]
        public string DxccName { get; set; }

        [Display(Name = "Is Deleted")]
        [Column("is_deleted")]
        public bool? IsDeleted { get; set; }
    }
}
