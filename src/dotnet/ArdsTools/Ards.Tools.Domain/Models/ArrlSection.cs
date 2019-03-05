using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.Adif.Models
{   
    /// <summary>
    /// ARRL Section Enumeration
    /// </summary>
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
        [Column("dxcc_id")]
        public int DxccId { get; set; }
        [Column("from_date", TypeName = "date")]
        public DateTime? FromDate { get; set; }
        [Column("deleted_date", TypeName = "date")]
        public DateTime? DeletedDate { get; set; }

        [ForeignKey("DxccId")]
        [InverseProperty("ArrlSection")]
        public virtual Dxcc Dxcc { get; set; }
    }
}
