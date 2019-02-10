using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.NetCore.Entity.Models
{
    [Table("weblink", Schema = "adif")]
    public partial class Weblink
    {
        public Weblink()
        {
            Contest = new HashSet<Contest>();
        }

        [Column("id")]
        public int Id { get; set; }
        [Required]
        [Column("display_text")]
        [StringLength(120)]
        public string DisplayText { get; set; }
        [Required]
        [Column("url")]
        [StringLength(255)]
        public string Url { get; set; }

        [InverseProperty("Weblink")]
        public virtual ICollection<Contest> Contest { get; set; }
    }
}
