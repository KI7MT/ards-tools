using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

// TODO: Pas should be primary_administrative_authority
namespace Ards.NetCore.Adif.Domain.Models
{
    [Table("pas", Schema = "adif")]
    public partial class Pas
    {
        public Pas()
        {
            Sas = new HashSet<Sas>();
        }

        [Column("id")]
        public int Id { get; set; }
        [Column("dxcc_entity_id")]
        public int DxccEntityId { get; set; }
        [Required]
        [Column("code")]
        [StringLength(10)]
        public string Code { get; set; }
        [Required]
        [Column("subdivision")]
        [StringLength(80)]
        public string Subdivision { get; set; }

        [ForeignKey("DxccEntityId")]
        [InverseProperty("Pas")]
        public virtual DxccEntity DxccEntity { get; set; }
        [InverseProperty("Pas")]
        public virtual ICollection<Sas> Sas { get; set; }
    }
}
