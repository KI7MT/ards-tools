using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.ViewModels
{
    [Table("jcc", Schema = "adif_view")]
    public partial class Jcc
    {
        [Key]
        [Display(Name = "JccId")]
        [Column("jcc_id")]
        public int JccId { get; set; }

        [Display(Name = "Prefecture")]
        [Column("prefecture")]
        [StringLength(30)]
        public string Prefecture { get; set; }

        [Display(Name = "Number")]
        [Column("number", TypeName = "character(6)")]
        public string Number { get; set; }

        [Display(Name = "City")]
        [Column("city")]
        [StringLength(30)]
        public string City { get; set; }

        [Display(Name = "Is Deleted")]
        [Column("is_deleted")]
        public bool? IsDeleted { get; set; }

        [Display(Name = "Date Deleted")]
        [Column("deleted_date", TypeName = "date")]
        public DateTime? DeletedDate { get; set; }

    }
}
