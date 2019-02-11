using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.NetCore.Adif.Domain.Models
{
    [Table("state_county", Schema = "adif")]
    public partial class StateCounty
    {
        [Column("id")]
        public int Id { get; set; }

        [Column("state_id")]
        public int StateId { get; set; }

        [Column("county_name_id")]
        public int CountyNameId { get; set; }

        // ForeignKey's and Navigation Properties
        [ForeignKey("CountyNameId")]
        [InverseProperty("StateCounty")]
        public virtual CountyName CountyName { get; set; }

        [ForeignKey("StateId")]
        [InverseProperty("StateCounty")]
        public virtual State State { get; set; }
    }
}
