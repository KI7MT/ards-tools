using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.Adif.Models
{
    [Table("pas_054", Schema = "adif")]
    public partial class Pas054
    {
        [Column("id")]
        public int Id { get; set; }
        [Column("dxcc_id")]
        public int DxccId { get; set; }
        [Required]
        [Column("code", TypeName = "character(2)")]
        public string Code { get; set; }
        [Required]
        [Column("subdivision")]
        [StringLength(60)]
        public string Subdivision { get; set; }
        [Required]
        [Column("oblast", TypeName = "character(3)")]
        public string Oblast { get; set; }
        [Column("cq_zone_id")]
        public int CqZoneId { get; set; }
        [Column("itu_xone_id")]
        public int ItuXoneId { get; set; }

        [ForeignKey("CqZoneId")]
        [InverseProperty("Pas054")]
        public virtual CqZone CqZone { get; set; }
        [ForeignKey("DxccId")]
        [InverseProperty("Pas054")]
        public virtual Dxcc Dxcc { get; set; }
        [ForeignKey("ItuXoneId")]
        [InverseProperty("Pas054")]
        public virtual ItuZone ItuXone { get; set; }
    }
}
