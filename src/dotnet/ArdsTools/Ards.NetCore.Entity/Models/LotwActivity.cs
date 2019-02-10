using System;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.NetCore.Entity.Models
{
    [Table("lotw_activity", Schema = "adif")]
    public partial class LotwActivity
    {
        [Column("callsign")]
        public string Callsign { get; set; }
        [Column("last_update", TypeName = "date")]
        public DateTime LastUpdate { get; set; }
        [Column("last_time", TypeName = "time without time zone")]
        public TimeSpan LastTime { get; set; }
    }
}
