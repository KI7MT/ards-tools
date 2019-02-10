using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.NetCore.Entity.Models
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

        [ForeignKey("CountyNameId")]
        [InverseProperty("StateCounty")]
        public virtual CountyName CountyName { get; set; }
        [ForeignKey("StateId")]
        [InverseProperty("StateCounty")]
        public virtual State State { get; set; }
    }
}
