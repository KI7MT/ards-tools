using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.NetCore.Adif.Api.Models
{
    [Table("propogation_mode", Schema = "adif")]
    public partial class PropogationMode
    {
        [Column("id")]
        public int Id { get; set; }
        [Required]
        [Column("enumeration")]
        [StringLength(20)]
        public string Enumeration { get; set; }
        [Required]
        [Column("description")]
        [StringLength(120)]
        public string Description { get; set; }
    }
}
