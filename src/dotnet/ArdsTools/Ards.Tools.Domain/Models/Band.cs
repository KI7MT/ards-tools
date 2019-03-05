using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.Adif.Models
{
    [Table("band", Schema = "adif")]
    public partial class Band
    {
        [Column("id")]
        public int Id { get; set; }
        [Required]
        [Column("name")]
        [StringLength(6)]
        public string Name { get; set; }
        [Column("lower_freq", TypeName = "numeric")]
        public decimal LowerFreq { get; set; }
        [Column("upper_freq", TypeName = "numeric")]
        public decimal UpperFreq { get; set; }
    }
}
