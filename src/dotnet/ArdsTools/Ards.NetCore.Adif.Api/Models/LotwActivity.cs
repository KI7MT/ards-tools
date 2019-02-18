using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.NetCore.Adif.Api.Models
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
