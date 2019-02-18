using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.NetCore.Adif.Api.Models
{
    [Table("continent", Schema = "adif")]
    public partial class Continent
    {
        [Column("id")]
        public int Id { get; set; }
        [Column("abbreviation")]
        [StringLength(2)]
        public string Abbreviation { get; set; }
        [Column("name")]
        [StringLength(14)]
        public string Name { get; set; }
    }
}
