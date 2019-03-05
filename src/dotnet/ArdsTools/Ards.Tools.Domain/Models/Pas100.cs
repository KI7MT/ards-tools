﻿using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.Adif.Models
{
    [Table("pas_100", Schema = "adif")]
    public partial class Pas100
    {
        [Column("id")]
        public int Id { get; set; }
        [Column("dxcc_id")]
        public int DxccId { get; set; }
        [Column("code")]
        public char Code { get; set; }
        [Required]
        [Column("subdivision")]
        [StringLength(60)]
        public string Subdivision { get; set; }

        [ForeignKey("DxccId")]
        [InverseProperty("Pas100")]
        public virtual Dxcc Dxcc { get; set; }
    }
}
