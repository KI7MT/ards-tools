using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.Adif.Models
{
    [Table("rdxc", Schema = "adif")]
    public partial class Rdxc
    {
        public Rdxc()
        {
            RdxcDistrict = new HashSet<RdxcDistrict>();
        }

        [Column("id")]
        public int Id { get; set; }
        [Required]
        [Column("prefix", TypeName = "character(4)")]
        public string Prefix { get; set; }
        [Required]
        [Column("rdxc_code", TypeName = "character(2)")]
        public string RdxcCode { get; set; }
        [Required]
        [Column("oblast")]
        [StringLength(60)]
        public string Oblast { get; set; }
        [Column("is_deleted")]
        public bool IsDeleted { get; set; }

        [InverseProperty("Rdxc")]
        public virtual ICollection<RdxcDistrict> RdxcDistrict { get; set; }
    }
}
