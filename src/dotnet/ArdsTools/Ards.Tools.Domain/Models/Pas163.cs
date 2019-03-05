using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.Adif.Models
{
    [Table("pas_163", Schema = "adif")]
    public partial class Pas163
    {
        [Column("id")]
        public int Id { get; set; }
        [Column("dxcc_id")]
        public int DxccId { get; set; }
        [Required]
        [Column("code", TypeName = "character(3)")]
        public string Code { get; set; }
        [Required]
        [Column("subdivision")]
        [StringLength(60)]
        public string Subdivision { get; set; }

        [ForeignKey("DxccId")]
        [InverseProperty("Pas163")]
        public virtual Dxcc Dxcc { get; set; }
    }
}
