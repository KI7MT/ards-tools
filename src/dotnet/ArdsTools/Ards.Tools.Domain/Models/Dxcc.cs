using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.Adif.Models
{
    /// <summary>
    /// DXCC Entity Code Enumeration
    /// </summary>
    [Table("dxcc", Schema = "adif")]
    public partial class Dxcc
    {
        [Column("id")]
        public int Id { get; set; }

        [Required]
        [Column("code")]
        [StringLength(4)]
        public string Code { get; set; }

        [Required]
        [Column("name")]
        [StringLength(90)]
        public string Name { get; set; }

        [Column("is_deleted")]
        public bool? IsDeleted { get; set; }
    }
}
