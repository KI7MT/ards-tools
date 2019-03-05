using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.Adif.Models
{
    [Table("itu_zone", Schema = "adif")]
    public partial class ItuZone
    {
        public ItuZone()
        {
            Pas001Ituzone = new HashSet<Pas001Ituzone>();
            Pas015Ituzone = new HashSet<Pas015Ituzone>();
            Pas054 = new HashSet<Pas054>();
            Pas126 = new HashSet<Pas126>();
            Pas291Ituzone = new HashSet<Pas291Ituzone>();
        }

        [Column("id")]
        public int Id { get; set; }
        [Column("ituzone")]
        public int Ituzone1 { get; set; }
        [Column("description")]
        [StringLength(300)]
        public string Description { get; set; }
        [Column("weblink_id")]
        public int? WeblinkId { get; set; }

        [ForeignKey("WeblinkId")]
        [InverseProperty("ItuZone")]
        public virtual Weblink Weblink { get; set; }
        [InverseProperty("ItuZone")]
        public virtual ICollection<Pas001Ituzone> Pas001Ituzone { get; set; }
        [InverseProperty("ItuZone")]
        public virtual ICollection<Pas015Ituzone> Pas015Ituzone { get; set; }
        [InverseProperty("ItuXone")]
        public virtual ICollection<Pas054> Pas054 { get; set; }
        [InverseProperty("ItuXone")]
        public virtual ICollection<Pas126> Pas126 { get; set; }
        [InverseProperty("ItuZone")]
        public virtual ICollection<Pas291Ituzone> Pas291Ituzone { get; set; }
    }
}
