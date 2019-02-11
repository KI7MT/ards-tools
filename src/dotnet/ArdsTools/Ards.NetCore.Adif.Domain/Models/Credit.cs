using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.NetCore.Adif.Domain.Models
{
    [Table("credit", Schema = "adif")]
    public partial class Credit
    {
        [Column("id")]
        public int Id { get; set; }

        [Required]
        [Column("credit_for")]
        [StringLength(24)]
        public string CreditFor { get; set; }

        [Column("sponsor_id")]
        public int SponsorId { get; set; }

        [Column("award_id")]
        public int AwardId { get; set; }

        [Column("facet_id")]
        public int FacetId { get; set; }

        [ForeignKey("AwardId")]
        [InverseProperty("Credit")]
        public virtual CreditAward Award { get; set; }

        [ForeignKey("FacetId")]
        [InverseProperty("Credit")]
        public virtual CreditFacet Facet { get; set; }

        [ForeignKey("SponsorId")]
        [InverseProperty("Credit")]
        public virtual CreditSponsor Sponsor { get; set; }
    }
}
