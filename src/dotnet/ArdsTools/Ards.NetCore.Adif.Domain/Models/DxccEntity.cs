using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.NetCore.Adif.Domain.Models
{
    [Table("dxcc_entity", Schema = "adif")]
    public partial class DxccEntity
    {
        public DxccEntity()
        {
            ArrlSection = new HashSet<ArrlSection>();
            Pas = new HashSet<Pas>();
            Region = new HashSet<Region>();
        }

        [Column("id")]
        public int Id { get; set; }

        [Required]
        [Column("code")]
        [StringLength(4)]
        public string Code { get; set; }

        [Required]
        [Column("name")]
        [StringLength(90)]
        public string Name { get; set; }

        [Column("is_deleted")]
        public bool? IsDeleted { get; set; }

        [InverseProperty("DxccEntity")]
        public virtual ICollection<ArrlSection> ArrlSection { get; set; }
        [InverseProperty("DxccEntity")]
        public virtual ICollection<Pas> Pas { get; set; }
        [InverseProperty("DxccEntity")]
        public virtual ICollection<Region> Region { get; set; }
    }
}
