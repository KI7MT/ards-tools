using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.Adif.Models
{
    /// <summary>
    /// DXCC Entity Code Enumeration
    /// </summary>
    [Table("dxcc", Schema = "adif")]
    public partial class DxccOrig
    {
        public DxccOrig()
        {
            ArrlSection = new HashSet<ArrlSection>();
            Pas001 = new HashSet<Pas001>();
            Pas005 = new HashSet<Pas005>();
            Pas006 = new HashSet<Pas006>();
            Pas015 = new HashSet<Pas015>();
            Pas021 = new HashSet<Pas021>();
            Pas027 = new HashSet<Pas027>();
            Pas029 = new HashSet<Pas029>();
            Pas032 = new HashSet<Pas032>();
            Pas050 = new HashSet<Pas050>();
            Pas052 = new HashSet<Pas052>();
            Pas054 = new HashSet<Pas054>();
            Pas061 = new HashSet<Pas061>();
            Pas070 = new HashSet<Pas070>();
            Pas074 = new HashSet<Pas074>();
            Pas086 = new HashSet<Pas086>();
            Pas100 = new HashSet<Pas100>();
            Pas104 = new HashSet<Pas104>();
            Pas108 = new HashSet<Pas108>();
            Pas110 = new HashSet<Pas110>();
            Pas112 = new HashSet<Pas112>();
            Pas126 = new HashSet<Pas126>();
            Pas130 = new HashSet<Pas130>();
            Pas132 = new HashSet<Pas132>();
            Pas137 = new HashSet<Pas137>();
            Pas138 = new HashSet<Pas138>();
            Pas144 = new HashSet<Pas144>();
            Pas147 = new HashSet<Pas147>();
            Pas148 = new HashSet<Pas148>();
            Pas149 = new HashSet<Pas149>();
            Pas150 = new HashSet<Pas150>();
            Pas151 = new HashSet<Pas151>();
            Pas153 = new HashSet<Pas153>();
            Pas163 = new HashSet<Pas163>();
            Pas170 = new HashSet<Pas170>();
            Pas177 = new HashSet<Pas177>();
            Pas179 = new HashSet<Pas179>();
            Pas192 = new HashSet<Pas192>();
            Pas206Region = new HashSet<Pas206Region>();
            Pas209 = new HashSet<Pas209>();
            Pas212Region = new HashSet<Pas212Region>();
            Pas214 = new HashSet<Pas214>();
            Pas221 = new HashSet<Pas221>();
            Pas224Region = new HashSet<Pas224Region>();
            Pas225Region = new HashSet<Pas225Region>();
            Pas227 = new HashSet<Pas227>();
            Pas230 = new HashSet<Pas230>();
            Pas239 = new HashSet<Pas239>();
            Pas245 = new HashSet<Pas245>();
            Pas248Region = new HashSet<Pas248Region>();
            Pas256 = new HashSet<Pas256>();
            Pas263 = new HashSet<Pas263>();
            Pas269 = new HashSet<Pas269>();
            Pas272 = new HashSet<Pas272>();
            Pas275 = new HashSet<Pas275>();
            Pas281 = new HashSet<Pas281>();
            Pas284 = new HashSet<Pas284>();
            Pas287 = new HashSet<Pas287>();
            Pas288 = new HashSet<Pas288>();
            Pas291 = new HashSet<Pas291>();
            Pas318 = new HashSet<Pas318>();
            Pas327 = new HashSet<Pas327>();
            Pas339Region = new HashSet<Pas339Region>();
            Pas375Region = new HashSet<Pas375Region>();
            Pas386 = new HashSet<Pas386>();
            Pas387 = new HashSet<Pas387>();
            Pas497 = new HashSet<Pas497>();
            Pas503Region = new HashSet<Pas503Region>();
            Pas504Region = new HashSet<Pas504Region>();
            PasSummary = new HashSet<PasSummary>();
            Region = new HashSet<Region>();
        }

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

        [InverseProperty("Dxcc")]
        public virtual ICollection<ArrlSection> ArrlSection { get; set; }
        [InverseProperty("Dxcc")]
        public virtual ICollection<Pas001> Pas001 { get; set; }
        [InverseProperty("Dxcc")]
        public virtual ICollection<Pas005> Pas005 { get; set; }
        [InverseProperty("Dxcc")]
        public virtual ICollection<Pas006> Pas006 { get; set; }
        [InverseProperty("Dxcc")]
        public virtual ICollection<Pas015> Pas015 { get; set; }
        [InverseProperty("Dxcc")]
        public virtual ICollection<Pas021> Pas021 { get; set; }
        [InverseProperty("Dxcc")]
        public virtual ICollection<Pas027> Pas027 { get; set; }
        [InverseProperty("Dxcc")]
        public virtual ICollection<Pas029> Pas029 { get; set; }
        [InverseProperty("Dxcc")]
        public virtual ICollection<Pas032> Pas032 { get; set; }
        [InverseProperty("Dxcc")]
        public virtual ICollection<Pas050> Pas050 { get; set; }
        [InverseProperty("Dxcc")]
        public virtual ICollection<Pas052> Pas052 { get; set; }
        [InverseProperty("Dxcc")]
        public virtual ICollection<Pas054> Pas054 { get; set; }
        [InverseProperty("Dxcc")]
        public virtual ICollection<Pas061> Pas061 { get; set; }
        [InverseProperty("Dxcc")]
        public virtual ICollection<Pas070> Pas070 { get; set; }
        [InverseProperty("Dxcc")]
        public virtual ICollection<Pas074> Pas074 { get; set; }
        [InverseProperty("Dxcc")]
        public virtual ICollection<Pas086> Pas086 { get; set; }
        [InverseProperty("Dxcc")]
        public virtual ICollection<Pas100> Pas100 { get; set; }
        [InverseProperty("Dxcc")]
        public virtual ICollection<Pas104> Pas104 { get; set; }
        [InverseProperty("Dxcc")]
        public virtual ICollection<Pas108> Pas108 { get; set; }
        [InverseProperty("Dxcc")]
        public virtual ICollection<Pas110> Pas110 { get; set; }
        [InverseProperty("Dxcc")]
        public virtual ICollection<Pas112> Pas112 { get; set; }
        [InverseProperty("Dxcc")]
        public virtual ICollection<Pas126> Pas126 { get; set; }
        [InverseProperty("Dxcc")]
        public virtual ICollection<Pas130> Pas130 { get; set; }
        [InverseProperty("Dxcc")]
        public virtual ICollection<Pas132> Pas132 { get; set; }
        [InverseProperty("Dxcc")]
        public virtual ICollection<Pas137> Pas137 { get; set; }
        [InverseProperty("Dxcc")]
        public virtual ICollection<Pas138> Pas138 { get; set; }
        [InverseProperty("Dxcc")]
        public virtual ICollection<Pas144> Pas144 { get; set; }
        [InverseProperty("Dxcc")]
        public virtual ICollection<Pas147> Pas147 { get; set; }
        [InverseProperty("Dxcc")]
        public virtual ICollection<Pas148> Pas148 { get; set; }
        [InverseProperty("Dxcc")]
        public virtual ICollection<Pas149> Pas149 { get; set; }
        [InverseProperty("Dxcc")]
        public virtual ICollection<Pas150> Pas150 { get; set; }
        [InverseProperty("Dxcc")]
        public virtual ICollection<Pas151> Pas151 { get; set; }
        [InverseProperty("Dxcc")]
        public virtual ICollection<Pas153> Pas153 { get; set; }
        [InverseProperty("Dxcc")]
        public virtual ICollection<Pas163> Pas163 { get; set; }
        [InverseProperty("Dxcc")]
        public virtual ICollection<Pas170> Pas170 { get; set; }
        [InverseProperty("Dxcc")]
        public virtual ICollection<Pas177> Pas177 { get; set; }
        [InverseProperty("Dxcc")]
        public virtual ICollection<Pas179> Pas179 { get; set; }
        [InverseProperty("Dxcc")]
        public virtual ICollection<Pas192> Pas192 { get; set; }
        [InverseProperty("Dxcc")]
        public virtual ICollection<Pas206Region> Pas206Region { get; set; }
        [InverseProperty("Dxcc")]
        public virtual ICollection<Pas209> Pas209 { get; set; }
        [InverseProperty("Dxcc")]
        public virtual ICollection<Pas212Region> Pas212Region { get; set; }
        [InverseProperty("Dxcc")]
        public virtual ICollection<Pas214> Pas214 { get; set; }
        [InverseProperty("Dxcc")]
        public virtual ICollection<Pas221> Pas221 { get; set; }
        [InverseProperty("Dxcc")]
        public virtual ICollection<Pas224Region> Pas224Region { get; set; }
        [InverseProperty("Dxcc")]
        public virtual ICollection<Pas225Region> Pas225Region { get; set; }
        [InverseProperty("Dxcc")]
        public virtual ICollection<Pas227> Pas227 { get; set; }
        [InverseProperty("Dxcc")]
        public virtual ICollection<Pas230> Pas230 { get; set; }
        [InverseProperty("Dxcc")]
        public virtual ICollection<Pas239> Pas239 { get; set; }
        [InverseProperty("Dxcc")]
        public virtual ICollection<Pas245> Pas245 { get; set; }
        [InverseProperty("Dxcc")]
        public virtual ICollection<Pas248Region> Pas248Region { get; set; }
        [InverseProperty("Dxcc")]
        public virtual ICollection<Pas256> Pas256 { get; set; }
        [InverseProperty("Dxcc")]
        public virtual ICollection<Pas263> Pas263 { get; set; }
        [InverseProperty("Dxcc")]
        public virtual ICollection<Pas269> Pas269 { get; set; }
        [InverseProperty("Dxcc")]
        public virtual ICollection<Pas272> Pas272 { get; set; }
        [InverseProperty("Dxcc")]
        public virtual ICollection<Pas275> Pas275 { get; set; }
        [InverseProperty("Dxcc")]
        public virtual ICollection<Pas281> Pas281 { get; set; }
        [InverseProperty("Dxcc")]
        public virtual ICollection<Pas284> Pas284 { get; set; }
        [InverseProperty("Dxcc")]
        public virtual ICollection<Pas287> Pas287 { get; set; }
        [InverseProperty("Dxcc")]
        public virtual ICollection<Pas288> Pas288 { get; set; }
        [InverseProperty("Dxcc")]
        public virtual ICollection<Pas291> Pas291 { get; set; }
        [InverseProperty("Dxcc")]
        public virtual ICollection<Pas318> Pas318 { get; set; }
        [InverseProperty("Dxcc")]
        public virtual ICollection<Pas327> Pas327 { get; set; }
        [InverseProperty("Dxcc")]
        public virtual ICollection<Pas339Region> Pas339Region { get; set; }
        [InverseProperty("Dxcc")]
        public virtual ICollection<Pas375Region> Pas375Region { get; set; }
        [InverseProperty("Dxcc")]
        public virtual ICollection<Pas386> Pas386 { get; set; }
        [InverseProperty("Dxcc")]
        public virtual ICollection<Pas387> Pas387 { get; set; }
        [InverseProperty("Dxcc")]
        public virtual ICollection<Pas497> Pas497 { get; set; }
        [InverseProperty("Dxcc")]
        public virtual ICollection<Pas503Region> Pas503Region { get; set; }
        [InverseProperty("Dxcc")]
        public virtual ICollection<Pas504Region> Pas504Region { get; set; }
        [InverseProperty("Dxcc")]
        public virtual ICollection<PasSummary> PasSummary { get; set; }
        [InverseProperty("Dxcc")]
        public virtual ICollection<Region> Region { get; set; }
    }
}
