﻿using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.ViewModels
{
    [Table("pas224_region", Schema = "adif_view")]
    public partial class Pas224Region
    {
        [Key]
        [Display(Name = "Pas224RegionId")]
        [Column("pas224_region_id")]
        public int Pas224RegionId { get; set; }

        [Display(Name = "Region")]
        [Column("region")]
        [StringLength(120)]
        public string Region { get; set; }
    }
}
