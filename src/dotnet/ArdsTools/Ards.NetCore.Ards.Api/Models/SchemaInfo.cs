using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.NetCore.Ards.Api.Models
{
    /// <summary>
    /// SchemaInfo Table
    /// </summary>
    [Table("schema_info", Schema = "ards")]
    public partial class SchemaInfo
    {
        /// <summary>
        /// Schema Name Property
        /// </summary>
        [Column("schema_name")]
        [StringLength(10)]
        public string SchemaName { get; set; }

        /// <summary>
        /// Schema Version Property
        /// </summary>
        [Column("schema_version")]
        [StringLength(10)]
        public string SchemaVersion { get; set; }

        /// <summary>
        /// ADIF Spec Property
        /// </summary>
        [Column("adif_spec")]
        [StringLength(10)]
        public string AdifSpec { get; set; }

        /// <summary>
        /// Last Update Property
        /// </summary>
        [Column("last_update")]
        public DateTime? LastUpdate { get; set; }
    }
}
