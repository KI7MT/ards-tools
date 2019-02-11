using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.NetCore.Adif.Domain.Models
{
    [Table("region", Schema = "adif")]
    public partial class Region
    {
        [Column("id")]
        public int Id { get; set; }

        [Column("code")]
        [StringLength(4)]
        public string Code { get; set; }

        [Column("dxcc_entity_id")]
        public int? DxccEntityId { get; set; }

        [Column("region")]
        [StringLength(120)]
        public string Region1 { get; set; }

        [Column("prefix")]
        [StringLength(10)]
        public string Prefix { get; set; }

        [ForeignKey("DxccEntityId")]
        [InverseProperty("Region")]
        public virtual DxccEntity DxccEntity { get; set; }
    }
}
