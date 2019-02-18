using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.NetCore.Adif.Api.Models
{
    [Table("antenna_path", Schema = "adif")]
    public partial class AntennaPath
    {
        [Column("id")]
        public int Id { get; set; }
        [Required]
        [Column("abbreviation")]
        [StringLength(1)]
        public string Abbreviation { get; set; }
        [Required]
        [Column("meaning")]
        [StringLength(15)]
        public string Meaning { get; set; }
    }
}
