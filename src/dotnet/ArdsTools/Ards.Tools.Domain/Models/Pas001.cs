using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.Adif.Models
{
    /// <summary>
    /// Primary Subdivision Enumeration for DXCC Entity Code 001
    /// </summary>
    [Table("pas_001", Schema = "adif")]
    public partial class Pas001
    {
        public Pas001()
        {
            Pas001Cqzone = new HashSet<Pas001Cqzone>();
            Pas001Ituzone = new HashSet<Pas001Ituzone>();
        }

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

        [ForeignKey("DxccId")]
        [InverseProperty("Pas001")]
        public virtual Dxcc Dxcc { get; set; }
        [InverseProperty("Pas001")]
        public virtual ICollection<Pas001Cqzone> Pas001Cqzone { get; set; }
        [InverseProperty("Pas001")]
        public virtual ICollection<Pas001Ituzone> Pas001Ituzone { get; set; }
    }
}
