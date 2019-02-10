using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.NetCore.Entity.Models
{
    [Table("eqsl_ag", Schema = "eqsl")]
    public partial class EqslAg
    {
        [Column("id")]
        public int Id { get; set; }
        [Required]
        [Column("callsign")]
        public string Callsign { get; set; }
        [Column("last_update", TypeName = "date")]
        public DateTime? LastUpdate { get; set; }
    }
}
