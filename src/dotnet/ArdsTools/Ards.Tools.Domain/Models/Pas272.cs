﻿using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.Adif.Models
{
    [Table("pas_272", Schema = "adif")]
    public partial class Pas272
    {
        [Column("id")]
        public int Id { get; set; }
        [Column("dxcc_id")]
        public int DxccId { get; set; }
        [Required]
        [Column("code", TypeName = "character(2)")]
        public string Code { get; set; }
        [Required]
        [Column("subdivision")]
        [StringLength(60)]
        public string Subdivision { get; set; }

        [ForeignKey("DxccId")]
        [InverseProperty("Pas272")]
        public virtual Dxcc Dxcc { get; set; }
    }
}