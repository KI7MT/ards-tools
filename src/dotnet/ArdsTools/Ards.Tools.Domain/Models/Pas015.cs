using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.Adif.Models
{
    /// <summary>
    /// Primary Subdivision Enumeration for DXCC Entity Code 015
    /// </summary>
    [Table("pas_015", Schema = "adif")]
    public partial class Pas015
    {
        public Pas015()
        {
            Pas015Cqzone = new HashSet<Pas015Cqzone>();
            Pas015Ituzone = new HashSet<Pas015Ituzone>();
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
        [StringLength(80)]
        public string Subdivision { get; set; }
        [Required]
        [Column("oblast")]
        [StringLength(3)]
        public string Oblast { get; set; }
        [Column("before_date", TypeName = "date")]
        public DateTime? BeforeDate { get; set; }
        [Column("referred_to_as")]
        [StringLength(80)]
        public string ReferredToAs { get; set; }

        [ForeignKey("DxccId")]
        [InverseProperty("Pas015")]
        public virtual Dxcc Dxcc { get; set; }
        [InverseProperty("Pas015")]
        public virtual ICollection<Pas015Cqzone> Pas015Cqzone { get; set; }
        [InverseProperty("Pas015")]
        public virtual ICollection<Pas015Ituzone> Pas015Ituzone { get; set; }
    }
}
