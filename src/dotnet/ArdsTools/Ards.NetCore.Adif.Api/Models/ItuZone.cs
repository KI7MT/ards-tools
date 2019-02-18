using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.NetCore.Adif.Api.Models
{
    [Table("itu_zone", Schema = "adif")]
    public partial class ItuZone
    {
        [Column("id")]
        public int Id { get; set; }
        [Column("number")]
        public int Number { get; set; }
        [Column("short_description")]
        [StringLength(120)]
        public string ShortDescription { get; set; }
        [Column("long_description")]
        [StringLength(255)]
        public string LongDescription { get; set; }
        [Column("weblink_id")]
        public int? WeblinkId { get; set; }
    }
}
