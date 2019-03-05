using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.Adif.Models
{
    /// <summary>
    /// Transmission Mode Description
    /// </summary>
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
        [StringLength(20)]
        public string Description { get; set; }
        [Column("weblink_id")]
        public int? WeblinkId { get; set; }

        [ForeignKey("WeblinkId")]
        [InverseProperty("ModeDescription")]
        public virtual Weblink Weblink { get; set; }
        [InverseProperty("ModeDescription")]
        public virtual ICollection<Mode> Mode { get; set; }
        [InverseProperty("ModeDescription")]
        public virtual ICollection<Submode> Submode { get; set; }
    }
}
