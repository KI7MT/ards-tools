using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.NetCore.Adif.Api.Models
{
    [Table("qsl_via", Schema = "adif")]
    public partial class QslVia
    {
        [Column("id")]
        public int Id { get; set; }
        [Required]
        [Column("via")]
        [StringLength(1)]
        public string Via { get; set; }
        [Required]
        [Column("description")]
        [StringLength(20)]
        public string Description { get; set; }
        [Column("import_only")]
        public bool ImportOnly { get; set; }
    }
}
