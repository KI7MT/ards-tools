using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.Adif.Models
{
    /// <summary>
    /// Primary Subdivision Enumeration for DXCC Entity Code 005
    /// </summary>
    [Table("pas_005", Schema = "adif")]
    public partial class Pas005
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
        [Column("is_deleted")]
        public bool IsDeleted { get; set; }

        [ForeignKey("DxccId")]
        [InverseProperty("Pas005")]
        public virtual Dxcc Dxcc { get; set; }
    }
}
