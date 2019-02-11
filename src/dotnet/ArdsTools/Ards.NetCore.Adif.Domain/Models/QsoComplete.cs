using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.NetCore.Adif.Domain.Models
{
    [Table("qso_complete", Schema = "adif")]
    public partial class QsoComplete
    {
        [Column("id")]
        public int Id { get; set; }

        [Required]
        [Column("abbreviation")]
        [StringLength(5)]
        public string Abbreviation { get; set; }

        [Required]
        [Column("meaning")]
        [StringLength(20)]
        public string Meaning { get; set; }
    }
}
