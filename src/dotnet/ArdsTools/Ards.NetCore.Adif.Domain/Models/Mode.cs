using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.NetCore.Adif.Domain.Models
{
    [Table("mode", Schema = "adif")]
    public partial class Mode
    {
        public Mode()
        {
            Submode = new HashSet<Submode>();
        }

        [Column("id")]
        public int Id { get; set; }

        [Required]
        [Column("name")]
        [StringLength(20)]
        public string Name { get; set; }

        [Column("mode_description_id")]
        public int? ModeDescriptionId { get; set; }

        [Column("import_only")]
        public bool ImportOnly { get; set; }

        // ForeignKey's and Navigation Properties
        [ForeignKey("ModeDescriptionId")]
        [InverseProperty("Mode")]
        public virtual ModeDescription ModeDescription { get; set; }

        [InverseProperty("Mode")]
        public virtual ICollection<Submode> Submode { get; set; }
    }
}
