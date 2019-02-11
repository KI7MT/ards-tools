using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.NetCore.Adif.Domain.Models
{
    [Table("award", Schema = "adif")]
    public partial class Award
    {
        [Column("id")]
        public int Id { get; set; }

        [Column("name")]
        [StringLength(15)]
        public string Name { get; set; }

        [Required]
        [Column("import_only")]
        public bool? ImportOnly { get; set; }
    }
}
