using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.Adif.Models
{
    [Table("schema_info", Schema = "ards")]
    public partial class SchemaInfo
    {
        [Column("schema_name")]
        [StringLength(10)]
        public string SchemaName { get; set; }
        [Column("schema_version")]
        [StringLength(10)]
        public string SchemaVersion { get; set; }
        [Column("adif_spec")]
        [StringLength(10)]
        public string AdifSpec { get; set; }
        [Column("last_update")]
        public DateTime? LastUpdate { get; set; }
    }
}
