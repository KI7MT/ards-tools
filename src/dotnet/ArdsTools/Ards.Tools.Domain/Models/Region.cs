using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.Adif.Models
{
    [Table("region", Schema = "adif")]
    public partial class Region
    {
        public Region()
        {
            RegionApplicability = new HashSet<RegionApplicability>();
        }

        [Column("id")]
        public int Id { get; set; }
        [Column("code")]
        [StringLength(4)]
        public string Code { get; set; }
        [Column("dxcc_id")]
        public int? DxccId { get; set; }
        [Column("region")]
        [StringLength(120)]
        public string Region1 { get; set; }
        [Column("prefix")]
        [StringLength(10)]
        public string Prefix { get; set; }

        [ForeignKey("DxccId")]
        [InverseProperty("Region")]
        public virtual Dxcc Dxcc { get; set; }
        [InverseProperty("Region")]
        public virtual ICollection<RegionApplicability> RegionApplicability { get; set; }
    }
}
