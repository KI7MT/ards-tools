using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.ViewModels
{
    [Table("arrl_section", Schema = "adif_view")]
    public partial class ArrlSection
    {
        [Key]
        [Display(Name = "ArrlSectionId")]
        [Column("arrl_section_id")]
        public int ArrlSectionId { get; set; }

        [Display(Name = "Abbreviation")]
        [Column("abbreviation")]
        [StringLength(4)]
        public string Abbreviation { get; set; }

        [Display(Name = "Section Name")]
        [Column("section_name")]
        [StringLength(70)]
        public string SectionName { get; set; }

        [Display(Name = "DXCC Code")]
        [Column("dxcc_code")]
        [StringLength(4)]
        public string DxccCode { get; set; }

        [Display(Name = "DXCC Name")]
        [Column("dxcc_name")]
        [StringLength(90)]
        public string DxccName { get; set; }

        [Display(Name = "From Date")]
        [Column("from_date", TypeName = "date")]
        public DateTime? FromDate { get; set; }

        [Display(Name = "Deleted On")]
        [Column("deleted_on", TypeName = "date")]
        public DateTime? DeletedOn { get; set; }
    }
}
