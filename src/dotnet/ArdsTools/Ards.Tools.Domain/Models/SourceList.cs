using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.Adif.Models
{
    [Table("source_list", Schema = "adif")]
    public partial class SourceList
    {
        [Column("id")]
        public int Id { get; set; }
        [Required]
        [Column("source_name", TypeName = "character varying")]
        public string SourceName { get; set; }
        [Column("source_date", TypeName = "date")]
        public DateTime SourceDate { get; set; }
        [Column("verified_date", TypeName = "date")]
        public DateTime VerifiedDate { get; set; }
        [Column("weblink_id")]
        public int WeblinkId { get; set; }

        [ForeignKey("WeblinkId")]
        [InverseProperty("SourceList")]
        public virtual Weblink Weblink { get; set; }
    }
}
