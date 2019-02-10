using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.NetCore.Entity.Models
{
    [Table("cq_zone", Schema = "adif")]
    public partial class CqZone
    {
        [Column("id")]
        public int Id { get; set; }
        [Required]
        [Column("short_description")]
        [StringLength(60)]
        public string ShortDescription { get; set; }
        [Required]
        [Column("long_description", TypeName = "character varying")]
        public string LongDescription { get; set; }
        [Column("weblink_id")]
        public int? WeblinkId { get; set; }
    }
}
