﻿using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.ViewModels
{
    [Table("qsl_sent", Schema = "adif_view")]
    public partial class QslSent
    {
        [Key]
        [Display(Name = "QslSentId")]
        [Column("qsl_sent_id")]
        public int QslSentId { get; set; }

        [Display(Name = "Status")]
        [Column("status")]
        [StringLength(1)]
        public string Status { get; set; }

        [Display(Name = "Meaning")]
        [Column("meaning")]
        [StringLength(20)]
        public string Meaning { get; set; }

        [Display(Name = "Description")]
        [Column("description")]
        [StringLength(255)]
        public string Description { get; set; }
    }
}
