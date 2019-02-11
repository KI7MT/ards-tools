using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.NetCore.Adif.Domain.Models
{
    [Table("submode", Schema = "adif")]
    public partial class Submode
    {
        [Column("id")]
        public int Id { get; set; }

        [Column("mode_id")]
        public int ModeId { get; set; }

        [Required]
        [Column("name")]
        [StringLength(20)]
        public string Name { get; set; }

        [Column("mode_description_id")]
        public int? ModeDescriptionId { get; set; }

        // ForeignKey's and Navigation Properties
        [ForeignKey("ModeId")]
        [InverseProperty("Submode")]
        public virtual Mode Mode { get; set; }

        [ForeignKey("ModeDescriptionId")]
        [InverseProperty("Submode")]
        public virtual ModeDescription ModeDescription { get; set; }
    }
}
