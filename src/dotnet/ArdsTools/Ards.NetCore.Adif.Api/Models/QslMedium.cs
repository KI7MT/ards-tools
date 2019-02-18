using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.NetCore.Adif.Api.Models
{
    [Table("qsl_medium", Schema = "adif")]
    public partial class QslMedium
    {
        [Column("id")]
        public int Id { get; set; }
        [Required]
        [Column("medium")]
        [StringLength(10)]
        public string Medium { get; set; }
        [Required]
        [Column("description")]
        [StringLength(120)]
        public string Description { get; set; }
    }
}
