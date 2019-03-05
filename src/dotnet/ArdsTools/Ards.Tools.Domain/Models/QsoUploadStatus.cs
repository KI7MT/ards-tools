using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.Adif.Models
{
    [Table("qso_upload_status", Schema = "adif")]
    public partial class QsoUploadStatus
    {
        [Column("id")]
        public int Id { get; set; }
        [Required]
        [Column("abbreviaiton")]
        [StringLength(1)]
        public string Abbreviaiton { get; set; }
        [Required]
        [Column("description")]
        [StringLength(120)]
        public string Description { get; set; }
    }
}
