using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.Adif.Models
{
    [Table("pas_summary", Schema = "adif")]
    public partial class PasSummary
    {
        [Column("id")]
        public int Id { get; set; }
        [Column("dxcc_id")]
        public int DxccId { get; set; }
        [Column("pas_subdivision_type_id")]
        public int PasSubdivisionTypeId { get; set; }
        [Column("has_oblast")]
        public bool HasOblast { get; set; }
        [Column("has_sas")]
        public bool HasSas { get; set; }
        [Column("sas_subdivision_type_id")]
        public int? SasSubdivisionTypeId { get; set; }

        [ForeignKey("DxccId")]
        [InverseProperty("PasSummary")]
        public virtual Dxcc Dxcc { get; set; }
        [ForeignKey("PasSubdivisionTypeId")]
        [InverseProperty("PasSummary")]
        public virtual PasSubdivisionType PasSubdivisionType { get; set; }
        [ForeignKey("SasSubdivisionTypeId")]
        [InverseProperty("PasSummary")]
        public virtual SasSubdivisionType SasSubdivisionType { get; set; }
    }
}
