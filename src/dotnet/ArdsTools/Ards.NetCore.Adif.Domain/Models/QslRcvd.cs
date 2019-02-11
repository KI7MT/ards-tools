using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.NetCore.Adif.Domain.Models
{
    [Table("qsl_rcvd", Schema = "adif")]
    public partial class QslRcvd
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

        [Column("import_only")]
        public bool ImportOnly { get; set; }

        [Column("description")]
        [StringLength(255)]
        public string Description { get; set; }
    }
}
