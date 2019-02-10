using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.NetCore.Entity.Models
{
    [Table("arrl_section", Schema = "adif")]
    public partial class ArrlSection
    {
        [Column("id")]
        public int Id { get; set; }
        [Required]
        [Column("abbreviation")]
        [StringLength(4)]
        public string Abbreviation { get; set; }
        [Required]
        [Column("name")]
        [StringLength(70)]
        public string Name { get; set; }
        [Column("dxcc_entity_id")]
        public int DxccEntityId { get; set; }
        [Column("from_date", TypeName = "date")]
        public DateTime? FromDate { get; set; }
        [Column("deleted_date", TypeName = "date")]
        public DateTime? DeletedDate { get; set; }

        [ForeignKey("DxccEntityId")]
        [InverseProperty("ArrlSection")]
        public virtual DxccEntity DxccEntity { get; set; }
    }
}
