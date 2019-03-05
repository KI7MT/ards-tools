using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.Adif.Models
{
    [Table("qsl_sent", Schema = "adif")]
    public partial class QslSent
    {
        [Column("id")]
        public int Id { get; set; }
        [Required]
        [Column("status")]
        [StringLength(1)]
        public string Status { get; set; }
        [Required]
        [Column("meaning")]
        [StringLength(20)]
        public string Meaning { get; set; }
        [Column("description")]
        [StringLength(255)]
        public string Description { get; set; }
    }
}
