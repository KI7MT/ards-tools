using Microsoft.EntityFrameworkCore;

namespace Ards.NetCore.Ards.Api.Models
{
    /// <summary>
    /// ArdsContext Database Access and Methods
    /// </summary>
    public partial class ArdsContext : DbContext
    {
        /// <summary>
        /// ArdsContext Class Null Constructor
        /// </summary>
        public ArdsContext()
        {
        }

        /// <summary>
        /// ArdsContext Constructor Extending base(options)
        /// </summary>
        /// <param name="options"></param>
        public ArdsContext(DbContextOptions<ArdsContext> options)
            : base(options)
        {
        }

        /// <summary>
        /// DBset for SchemaInfo
        /// </summary>
        public virtual DbSet<SchemaInfo> SchemaInfo { get; set; }

        /// <summary>
        /// Create Model Class with modelBuilder
        /// </summary>
        /// <param name="modelBuilder"></param>
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.HasAnnotation("ProductVersion", "2.2.1-servicing-10028");

            modelBuilder.Entity<SchemaInfo>(entity =>
            {
                entity.HasKey(e => e.SchemaName)
                    .HasName("schema_info_schema_name_pkey");

                entity.Property(e => e.SchemaName).ValueGeneratedNever();

                entity.Property(e => e.LastUpdate).HasDefaultValueSql("now()");
            });
        }
    }
}
