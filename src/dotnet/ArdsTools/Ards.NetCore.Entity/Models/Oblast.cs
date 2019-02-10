using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.NetCore.Entity.Models
{
    [Table("oblast", Schema = "adif")]
    public partial class Oblast
    {
        [Column("id")]
        public int Id { get; set; }
        [Required]
        [Column("code")]
        [StringLength(10)]
        public string Code { get; set; }
        [Required]
        [Column("name")]
        [StringLength(120)]
        public string Name { get; set; }
        [Column("is_deleted")]
        public bool IsDeleted { get; set; }
        [Required]
        [Column("comment")]
        [StringLength(120)]
        public string Comment { get; set; }
    }
}
