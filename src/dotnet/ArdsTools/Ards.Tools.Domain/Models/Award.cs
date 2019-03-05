using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.Adif.Models
{
    [Table("award", Schema = "adif")]
    public partial class Award
    {
        [Column("id")]
        public int Id { get; set; }
        [Required]
        [Column("name")]
        [StringLength(15)]
        public string Name { get; set; }
        [Column("import_only")]
        public bool? ImportOnly { get; set; }
    }
}
