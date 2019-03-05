using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.Adif.Models
{
    [Table("credit_sponsor", Schema = "adif")]
    public partial class CreditSponsor
    {
        public CreditSponsor()
        {
            Credit = new HashSet<Credit>();
        }

        [Column("id")]
        public int Id { get; set; }
        [Column("name")]
        [StringLength(20)]
        public string Name { get; set; }

        [InverseProperty("Sponsor")]
        public virtual ICollection<Credit> Credit { get; set; }
    }
}
