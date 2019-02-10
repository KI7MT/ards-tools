using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.NetCore.Entity.Models
{
    [Table("jtalert_data", Schema = "adif")]
    public partial class JtalertData
    {
        [Column("call")]
        [StringLength(20)]
        public string Call { get; set; }
        [Column("state")]
        [StringLength(4)]
        public string State { get; set; }
        [Column("lotw")]
        public bool? Lotw { get; set; }
        [Column("eqsl")]
        public bool? Eqsl { get; set; }
        [Column("lotw_date", TypeName = "date")]
        public DateTime? LotwDate { get; set; }
    }
}
