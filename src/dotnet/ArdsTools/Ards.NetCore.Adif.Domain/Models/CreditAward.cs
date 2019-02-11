﻿using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.NetCore.Adif.Domain.Models
{
    [Table("credit_award", Schema = "adif")]
    public partial class CreditAward
    {
        public CreditAward()
        {
            Credit = new HashSet<Credit>();
        }

        [Column("id")]
        public int Id { get; set; }

        [Column("name")]
        [StringLength(60)]
        public string Name { get; set; }

        // ForeignKey's and Navigation Properties
        [InverseProperty("Award")]
        public virtual ICollection<Credit> Credit { get; set; }
    }
}
