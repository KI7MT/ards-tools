using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.Adif.Models
{
    /// <summary>
    /// Primary Administration Subdivision JARL JCC Cities
    /// </summary>
    [Table("jarl_jcc_city", Schema = "adif")]
    public partial class JarlJccCity
    {
        [Column("id")]
        public int Id { get; set; }
        [Column("jcc_id")]
        public int JccId { get; set; }
        [Column("number", TypeName = "character(6)")]
        public string Number { get; set; }
        [Column("city")]
        [StringLength(30)]
        public string City { get; set; }
        [Column("is_deleted")]
        public bool IsDeleted { get; set; }
        [Column("deleted_date", TypeName = "date")]
        public DateTime? DeletedDate { get; set; }

        [ForeignKey("JccId")]
        [InverseProperty("JarlJccCity")]
        public virtual JarlJcc Jcc { get; set; }
    }
}
