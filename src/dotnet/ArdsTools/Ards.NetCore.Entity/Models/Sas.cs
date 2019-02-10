﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.NetCore.Entity.Models
{
    [Table("sas", Schema = "adif")]
    public partial class Sas
    {
        [Column("id")]
        public int Id { get; set; }
        [Required]
        [Column("name")]
        [StringLength(80)]
        public string Name { get; set; }
        [Column("pas_id")]
        public int PasId { get; set; }

        [ForeignKey("PasId")]
        [InverseProperty("Sas")]
        public virtual Pas Pas { get; set; }
    }
}
