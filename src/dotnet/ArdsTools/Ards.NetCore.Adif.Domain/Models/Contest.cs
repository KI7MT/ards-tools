using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.NetCore.Adif.Domain.Models
{
    [Table("contest", Schema = "adif")]
    public partial class Contest
    {
        [Column("id")]
        public int Id { get; set; }

        [Column("name")]
        [StringLength(60)]
        public string Name { get; set; }

        [Column("description")]
        [StringLength(120)]
        public string Description { get; set; }

        [Column("import_only")]
        public bool ImportOnly { get; set; }

        [Column("weblink_id")]
        public int? WeblinkId { get; set; }

        [ForeignKey("WeblinkId")]
        [InverseProperty("Contest")]
        public virtual Weblink Weblink { get; set; }
    }
}
