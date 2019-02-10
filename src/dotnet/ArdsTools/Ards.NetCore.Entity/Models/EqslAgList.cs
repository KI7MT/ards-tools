using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.NetCore.Entity.Models
{
    [Table("eqsl_ag_list", Schema = "adif")]
    public partial class EqslAgList
    {
        [Column("id")]
        public int Id { get; set; }
        [Required]
        [Column("callsign")]
        public string Callsign { get; set; }
    }
}
