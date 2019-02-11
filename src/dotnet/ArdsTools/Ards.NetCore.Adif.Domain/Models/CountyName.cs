using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.NetCore.Adif.Domain.Models
{
    [Table("county_name", Schema = "adif")]
    public partial class CountyName
    {
        public CountyName()
        {
            StateCounty = new HashSet<StateCounty>();
        }

        [Column("id")]
        public int Id { get; set; }

        [Required]
        [Column("name")]
        [StringLength(60)]
        public string Name { get; set; }

        [InverseProperty("CountyName")]
        public virtual ICollection<StateCounty> StateCounty { get; set; }
    }
}
