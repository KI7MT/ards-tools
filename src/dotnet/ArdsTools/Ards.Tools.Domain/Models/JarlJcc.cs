using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.Adif.Models
{
    /// <summary>
    /// Primary Administration Subdivision JARL JCC Prefectures
    /// </summary>
    [Table("jarl_jcc", Schema = "adif")]
    public partial class JarlJcc
    {
        public JarlJcc()
        {
            JarlJccCity = new HashSet<JarlJccCity>();
        }

        [Column("id")]
        public int Id { get; set; }
        [Required]
        [Column("prefecture")]
        [StringLength(30)]
        public string Prefecture { get; set; }
        [Required]
        [Column("prefix", TypeName = "character(2)")]
        public string Prefix { get; set; }

        [InverseProperty("Jcc")]
        public virtual ICollection<JarlJccCity> JarlJccCity { get; set; }
    }
}
