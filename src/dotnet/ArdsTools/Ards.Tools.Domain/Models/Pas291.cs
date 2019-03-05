using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.Adif.Models
{
    [Table("pas_291", Schema = "adif")]
    public partial class Pas291
    {
        public Pas291()
        {
            Pas291Cqzone = new HashSet<Pas291Cqzone>();
            Pas291Ituzone = new HashSet<Pas291Ituzone>();
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
        [InverseProperty("Pas291")]
        public virtual Dxcc Dxcc { get; set; }
        [InverseProperty("Pas291")]
        public virtual ICollection<Pas291Cqzone> Pas291Cqzone { get; set; }
        [InverseProperty("Pas291")]
        public virtual ICollection<Pas291Ituzone> Pas291Ituzone { get; set; }
    }
}
