﻿using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ards.Tools.Domain.Adif.Adif.Models
{
    [Table("state", Schema = "adif")]
    public partial class State
    {
        public State()
        {
            StateCounty = new HashSet<StateCounty>();
        }

        [Column("id")]
        public int Id { get; set; }
        [Required]
        [Column("abbreviation")]
        [StringLength(2)]
        public string Abbreviation { get; set; }
        [Required]
        [Column("name")]
        [StringLength(20)]
        public string Name { get; set; }

        [InverseProperty("State")]
        public virtual ICollection<StateCounty> StateCounty { get; set; }
    }
}