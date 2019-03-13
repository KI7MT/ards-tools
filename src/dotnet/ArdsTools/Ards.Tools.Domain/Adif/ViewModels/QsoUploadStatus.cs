using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.ViewModels
{
    [Table("qso_upload_status", Schema = "adif_view")]
    public partial class QsoUploadStatus
    {
        [Key]
        [Display(Name = "QsoUploadStatusId")]
        [Column("qso_upload_status_id")]
        public int QsoUploadStatusId { get; set; }

        [Display(Name = "Abbreviation")]
        [Column("abbreviation")]
        [StringLength(1)]
        public string Abbreviation { get; set; }

        [Display(Name = "Description")]
        [Column("description")]
        [StringLength(120)]
        public string Description { get; set; }
    }
}
