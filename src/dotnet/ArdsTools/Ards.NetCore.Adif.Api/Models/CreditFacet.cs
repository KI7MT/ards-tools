using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.NetCore.Adif.Api.Models
{
    [Table("credit_facet", Schema = "adif")]
    public partial class CreditFacet
    {
        public CreditFacet()
        {
            Credit = new HashSet<Credit>();
        }

        [Column("id")]
        public int Id { get; set; }
        [Column("name")]
        [StringLength(20)]
        public string Name { get; set; }

        [InverseProperty("Facet")]
        public virtual ICollection<Credit> Credit { get; set; }
    }
}
