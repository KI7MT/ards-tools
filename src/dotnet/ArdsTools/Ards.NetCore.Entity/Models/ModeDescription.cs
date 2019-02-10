using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.NetCore.Entity.Models
{
    [Table("mode_description", Schema = "adif")]
    public partial class ModeDescription
    {
        public ModeDescription()
        {
            Mode = new HashSet<Mode>();
            Submode = new HashSet<Submode>();
        }

        [Column("id")]
        public int Id { get; set; }
        [Required]
        [Column("description")]
        [StringLength(120)]
        public string Description { get; set; }

        [InverseProperty("ModeDescription")]
        public virtual ICollection<Mode> Mode { get; set; }
        [InverseProperty("ModeDescription")]
        public virtual ICollection<Submode> Submode { get; set; }
    }
}
