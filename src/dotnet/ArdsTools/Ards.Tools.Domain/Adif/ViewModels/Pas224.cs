﻿using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.ViewModels
{
    [Table("pas224", Schema = "adif_view")]
    public partial class Pas224
    {
        [Key]
        [Display(Name = "Pas224Id")]
        [Column("pas224_id")]
        public int Pas224Id { get; set; }

        [Display(Name = "DXCC Code")]
        [Column("dxcc_code")]
        public int? DxccCode { get; set; }

        [Display(Name = "Country")]
        [Column("country")]
        [StringLength(90)]
        public string Country { get; set; }

        [Display(Name = "Region")]
        [Column("region")]
        [StringLength(120)]
        public string Region { get; set; }

        [Display(Name = "Code")]
        [Column("code", TypeName = "character(4)")]
        public string Code { get; set; }

        [Display(Name = "Subdivision")]
        [Column("subdivision")]
        [StringLength(120)]
        public string Subdivision { get; set; }
    }
}
