using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.Adif.Models
{
    [Table("cq_zone", Schema = "adif")]
    public partial class CqZone
    {
        public CqZone()
        {
            Pas001Cqzone = new HashSet<Pas001Cqzone>();
            Pas015Cqzone = new HashSet<Pas015Cqzone>();
            Pas054 = new HashSet<Pas054>();
            Pas126 = new HashSet<Pas126>();
            Pas291Cqzone = new HashSet<Pas291Cqzone>();
        }

        [Column("id")]
        public int Id { get; set; }
        [Column("cqzone")]
        public int Cqzone1 { get; set; }
        [Required]
        [Column("description")]
        [StringLength(60)]
        public string Description { get; set; }
        [Column("weblink_id")]
        public int? WeblinkId { get; set; }

        [ForeignKey("WeblinkId")]
        [InverseProperty("CqZone")]
        public virtual Weblink Weblink { get; set; }
        [InverseProperty("CqZone")]
        public virtual ICollection<Pas001Cqzone> Pas001Cqzone { get; set; }
        [InverseProperty("CqZone")]
        public virtual ICollection<Pas015Cqzone> Pas015Cqzone { get; set; }
        [InverseProperty("CqZone")]
        public virtual ICollection<Pas054> Pas054 { get; set; }
        [InverseProperty("CqZone")]
        public virtual ICollection<Pas126> Pas126 { get; set; }
        [InverseProperty("CqZone")]
        public virtual ICollection<Pas291Cqzone> Pas291Cqzone { get; set; }
    }
}
