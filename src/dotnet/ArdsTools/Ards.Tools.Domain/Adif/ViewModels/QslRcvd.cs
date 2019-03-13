using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.ViewModels
{
    [Table("qsl_rcvd", Schema = "adif_view")]
    public partial class QslRcvd
    {
        [Key]
        [Display(Name = "QslRcvdId")]
        [Column("qsl_rcvd_id")]
        public int QslRcvdId { get; set; }

        [Display(Name = "Status")]
        [Column("status")]
        [StringLength(1)]
        public string Status { get; set; }

        [Display(Name = "Meaning")]
        [Column("meaning")]
        [StringLength(20)]
        public string Meaning { get; set; }

        [Display(Name = "Description")]
        [Column("description")]
        [StringLength(255)]
        public string Description { get; set; }

        [Display(Name = "Is Import Only")]
        [Column("is_import_only")]
        public bool? IsImportOnly { get; set; }
    }
}
