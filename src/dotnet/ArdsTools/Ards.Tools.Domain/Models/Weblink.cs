using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.Adif.Models
{
    [Table("weblink", Schema = "adif")]
    public partial class Weblink
    {
        public Weblink()
        {
            Contest = new HashSet<Contest>();
            CqZone = new HashSet<CqZone>();
            IaruRegion = new HashSet<IaruRegion>();
            ItuZone = new HashSet<ItuZone>();
            ModeDescription = new HashSet<ModeDescription>();
            RegionApplicability = new HashSet<RegionApplicability>();
            SourceList = new HashSet<SourceList>();
            SponsoredAward = new HashSet<SponsoredAward>();
        }

        [Column("id")]
        public int Id { get; set; }
        [Required]
        [Column("display_text")]
        [StringLength(120)]
        public string DisplayText { get; set; }
        [Required]
        [Column("url")]
        [StringLength(255)]
        public string Url { get; set; }

        [InverseProperty("Weblink")]
        public virtual ICollection<Contest> Contest { get; set; }
        [InverseProperty("Weblink")]
        public virtual ICollection<CqZone> CqZone { get; set; }
        [InverseProperty("Weblink")]
        public virtual ICollection<IaruRegion> IaruRegion { get; set; }
        [InverseProperty("Weblink")]
        public virtual ICollection<ItuZone> ItuZone { get; set; }
        [InverseProperty("Weblink")]
        public virtual ICollection<ModeDescription> ModeDescription { get; set; }
        [InverseProperty("Weblink")]
        public virtual ICollection<RegionApplicability> RegionApplicability { get; set; }
        [InverseProperty("Weblink")]
        public virtual ICollection<SourceList> SourceList { get; set; }
        [InverseProperty("Weblink")]
        public virtual ICollection<SponsoredAward> SponsoredAward { get; set; }
    }
}
