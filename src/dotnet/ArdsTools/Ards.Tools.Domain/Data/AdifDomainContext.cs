using Microsoft.EntityFrameworkCore;

namespace Ards.Tools.Domain.Adif.Adif.Models
{
    public partial class AdifDomainContext : DbContext
    {
        public AdifDomainContext()
        {
        }

        public AdifDomainContext(DbContextOptions<AdifDomainContext> options)
            : base(options)
        {
        }

        public virtual DbSet<AntennaPath> AntennaPath { get; set; }
        public virtual DbSet<ArrlSection> ArrlSection { get; set; }
        public virtual DbSet<Award> Award { get; set; }
        public virtual DbSet<Band> Band { get; set; }
        public virtual DbSet<Contest> Contest { get; set; }
        public virtual DbSet<Continent> Continent { get; set; }
        public virtual DbSet<CountyName> CountyName { get; set; }
        public virtual DbSet<CqZone> CqZone { get; set; }
        public virtual DbSet<Credit> Credit { get; set; }
        public virtual DbSet<CreditAward> CreditAward { get; set; }
        public virtual DbSet<CreditFacet> CreditFacet { get; set; }
        public virtual DbSet<CreditSponsor> CreditSponsor { get; set; }
        public virtual DbSet<Dxcc> Dxcc { get; set; }
        public virtual DbSet<IaruRegion> IaruRegion { get; set; }
        public virtual DbSet<IaruRegionMember> IaruRegionMember { get; set; }
        public virtual DbSet<ItuZone> ItuZone { get; set; }
        public virtual DbSet<JarlJcc> JarlJcc { get; set; }
        public virtual DbSet<JarlJccCity> JarlJccCity { get; set; }
        public virtual DbSet<Mode> Mode { get; set; }
        public virtual DbSet<ModeDescription> ModeDescription { get; set; }
        public virtual DbSet<Pas001> Pas001 { get; set; }
        public virtual DbSet<Pas001Cqzone> Pas001Cqzone { get; set; }
        public virtual DbSet<Pas001Ituzone> Pas001Ituzone { get; set; }
        public virtual DbSet<Pas005> Pas005 { get; set; }
        public virtual DbSet<Pas006> Pas006 { get; set; }
        public virtual DbSet<Pas015> Pas015 { get; set; }
        public virtual DbSet<Pas015Cqzone> Pas015Cqzone { get; set; }
        public virtual DbSet<Pas015Ituzone> Pas015Ituzone { get; set; }
        public virtual DbSet<Pas021> Pas021 { get; set; }
        public virtual DbSet<Pas027> Pas027 { get; set; }
        public virtual DbSet<Pas029> Pas029 { get; set; }
        public virtual DbSet<Pas032> Pas032 { get; set; }
        public virtual DbSet<Pas050> Pas050 { get; set; }
        public virtual DbSet<Pas052> Pas052 { get; set; }
        public virtual DbSet<Pas054> Pas054 { get; set; }
        public virtual DbSet<Pas061> Pas061 { get; set; }
        public virtual DbSet<Pas070> Pas070 { get; set; }
        public virtual DbSet<Pas074> Pas074 { get; set; }
        public virtual DbSet<Pas086> Pas086 { get; set; }
        public virtual DbSet<Pas100> Pas100 { get; set; }
        public virtual DbSet<Pas104> Pas104 { get; set; }
        public virtual DbSet<Pas108> Pas108 { get; set; }
        public virtual DbSet<Pas110> Pas110 { get; set; }
        public virtual DbSet<Pas112> Pas112 { get; set; }
        public virtual DbSet<Pas126> Pas126 { get; set; }
        public virtual DbSet<Pas130> Pas130 { get; set; }
        public virtual DbSet<Pas132> Pas132 { get; set; }
        public virtual DbSet<Pas137> Pas137 { get; set; }
        public virtual DbSet<Pas138> Pas138 { get; set; }
        public virtual DbSet<Pas144> Pas144 { get; set; }
        public virtual DbSet<Pas147> Pas147 { get; set; }
        public virtual DbSet<Pas148> Pas148 { get; set; }
        public virtual DbSet<Pas149> Pas149 { get; set; }
        public virtual DbSet<Pas150> Pas150 { get; set; }
        public virtual DbSet<Pas151> Pas151 { get; set; }
        public virtual DbSet<Pas153> Pas153 { get; set; }
        public virtual DbSet<Pas163> Pas163 { get; set; }
        public virtual DbSet<Pas170> Pas170 { get; set; }
        public virtual DbSet<Pas177> Pas177 { get; set; }
        public virtual DbSet<Pas179> Pas179 { get; set; }
        public virtual DbSet<Pas192> Pas192 { get; set; }
        public virtual DbSet<Pas206Region> Pas206Region { get; set; }
        public virtual DbSet<Pas206Subdivision> Pas206Subdivision { get; set; }
        public virtual DbSet<Pas209> Pas209 { get; set; }
        public virtual DbSet<Pas212Region> Pas212Region { get; set; }
        public virtual DbSet<Pas212Subdivision> Pas212Subdivision { get; set; }
        public virtual DbSet<Pas214> Pas214 { get; set; }
        public virtual DbSet<Pas221> Pas221 { get; set; }
        public virtual DbSet<Pas224Region> Pas224Region { get; set; }
        public virtual DbSet<Pas224Subdivision> Pas224Subdivision { get; set; }
        public virtual DbSet<Pas225Region> Pas225Region { get; set; }
        public virtual DbSet<Pas225Subdivision> Pas225Subdivision { get; set; }
        public virtual DbSet<Pas227> Pas227 { get; set; }
        public virtual DbSet<Pas230> Pas230 { get; set; }
        public virtual DbSet<Pas239> Pas239 { get; set; }
        public virtual DbSet<Pas245> Pas245 { get; set; }
        public virtual DbSet<Pas248Region> Pas248Region { get; set; }
        public virtual DbSet<Pas248Subdivision> Pas248Subdivision { get; set; }
        public virtual DbSet<Pas256> Pas256 { get; set; }
        public virtual DbSet<Pas263> Pas263 { get; set; }
        public virtual DbSet<Pas269> Pas269 { get; set; }
        public virtual DbSet<Pas272> Pas272 { get; set; }
        public virtual DbSet<Pas275> Pas275 { get; set; }
        public virtual DbSet<Pas281> Pas281 { get; set; }
        public virtual DbSet<Pas284> Pas284 { get; set; }
        public virtual DbSet<Pas287> Pas287 { get; set; }
        public virtual DbSet<Pas288> Pas288 { get; set; }
        public virtual DbSet<Pas291> Pas291 { get; set; }
        public virtual DbSet<Pas291Cqzone> Pas291Cqzone { get; set; }
        public virtual DbSet<Pas291Ituzone> Pas291Ituzone { get; set; }
        public virtual DbSet<Pas318> Pas318 { get; set; }
        public virtual DbSet<Pas327> Pas327 { get; set; }
        public virtual DbSet<Pas339Region> Pas339Region { get; set; }
        public virtual DbSet<Pas339Subdivision> Pas339Subdivision { get; set; }
        public virtual DbSet<Pas375Region> Pas375Region { get; set; }
        public virtual DbSet<Pas375Subdivision> Pas375Subdivision { get; set; }
        public virtual DbSet<Pas386> Pas386 { get; set; }
        public virtual DbSet<Pas387> Pas387 { get; set; }
        public virtual DbSet<Pas497> Pas497 { get; set; }
        public virtual DbSet<Pas503Region> Pas503Region { get; set; }
        public virtual DbSet<Pas503Subdivision> Pas503Subdivision { get; set; }
        public virtual DbSet<Pas504Region> Pas504Region { get; set; }
        public virtual DbSet<Pas504Subdivision> Pas504Subdivision { get; set; }
        public virtual DbSet<PasSubdivisionType> PasSubdivisionType { get; set; }
        public virtual DbSet<PasSummary> PasSummary { get; set; }
        public virtual DbSet<PropogationMode> PropogationMode { get; set; }
        public virtual DbSet<QslMedium> QslMedium { get; set; }
        public virtual DbSet<QslRcvd> QslRcvd { get; set; }
        public virtual DbSet<QslSent> QslSent { get; set; }
        public virtual DbSet<QslVia> QslVia { get; set; }
        public virtual DbSet<QsoComplete> QsoComplete { get; set; }
        public virtual DbSet<QsoUploadStatus> QsoUploadStatus { get; set; }
        public virtual DbSet<Rdxc> Rdxc { get; set; }
        public virtual DbSet<RdxcDistrict> RdxcDistrict { get; set; }
        public virtual DbSet<Region> Region { get; set; }
        public virtual DbSet<RegionApplicability> RegionApplicability { get; set; }
        public virtual DbSet<SasSubdivisionType> SasSubdivisionType { get; set; }
        public virtual DbSet<SchemaInfo> SchemaInfo { get; set; }
        public virtual DbSet<SourceList> SourceList { get; set; }
        public virtual DbSet<SponsoredAward> SponsoredAward { get; set; }
        public virtual DbSet<State> State { get; set; }
        public virtual DbSet<StateCounty> StateCounty { get; set; }
        public virtual DbSet<Submode> Submode { get; set; }
        public virtual DbSet<Weblink> Weblink { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.HasAnnotation("ProductVersion", "2.2.2-servicing-10034");

            modelBuilder.Entity<AntennaPath>(entity =>
            {
                entity.HasIndex(e => new { e.Abbreviation, e.Meaning })
                    .HasName("antenna_path_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.antenna_path_id_seq'::regclass)");
            });

            modelBuilder.Entity<ArrlSection>(entity =>
            {
                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.arrl_section_id_seq'::regclass)");

                entity.HasOne(d => d.Dxcc)
                    .WithMany(p => p.ArrlSection)
                    .HasForeignKey(d => d.DxccId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("arrl_section_dxcc_fkey");
            });

            modelBuilder.Entity<Award>(entity =>
            {
                entity.HasIndex(e => e.Name)
                    .HasName("award_name_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.award_id_seq'::regclass)");

                entity.Property(e => e.ImportOnly).HasDefaultValueSql("true");
            });

            modelBuilder.Entity<Band>(entity =>
            {
                entity.HasIndex(e => e.Name)
                    .HasName("band_name_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.band_id_seq'::regclass)");
            });

            modelBuilder.Entity<Contest>(entity =>
            {
                entity.HasIndex(e => e.Name)
                    .HasName("contest_name_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.contest_id_seq'::regclass)");

                entity.HasOne(d => d.Weblink)
                    .WithMany(p => p.Contest)
                    .HasForeignKey(d => d.WeblinkId)
                    .HasConstraintName("contest_weblink_fkey");
            });

            modelBuilder.Entity<Continent>(entity =>
            {
                entity.HasIndex(e => new { e.Abbreviation, e.Name })
                    .HasName("continent_name_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.continent_id_seq'::regclass)");
            });

            modelBuilder.Entity<CountyName>(entity =>
            {
                entity.HasIndex(e => e.Name)
                    .HasName("county_name_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.county_name_id_seq'::regclass)");
            });

            modelBuilder.Entity<CqZone>(entity =>
            {
                entity.HasIndex(e => e.Cqzone1)
                    .HasName("cq_zone_cqzone_uq")
                    .IsUnique();

                entity.Property(e => e.Id).ValueGeneratedNever();

                entity.HasOne(d => d.Weblink)
                    .WithMany(p => p.CqZone)
                    .HasForeignKey(d => d.WeblinkId)
                    .HasConstraintName("cq_zone_weblink_fkey");
            });

            modelBuilder.Entity<Credit>(entity =>
            {
                entity.HasIndex(e => e.CreditFor)
                    .HasName("credit_for_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.credit_id_seq'::regclass)");

                entity.HasOne(d => d.Award)
                    .WithMany(p => p.Credit)
                    .HasForeignKey(d => d.AwardId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("credit_credit_award_fkey");

                entity.HasOne(d => d.Facet)
                    .WithMany(p => p.Credit)
                    .HasForeignKey(d => d.FacetId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("credit_credit_facet_fkey");

                entity.HasOne(d => d.Sponsor)
                    .WithMany(p => p.Credit)
                    .HasForeignKey(d => d.SponsorId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("credit_credit_sponsor_fkey");
            });

            modelBuilder.Entity<CreditAward>(entity =>
            {
                entity.HasIndex(e => e.Name)
                    .HasName("credit_award_name_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.credit_award_id_seq'::regclass)");
            });

            modelBuilder.Entity<CreditFacet>(entity =>
            {
                entity.HasIndex(e => e.Name)
                    .HasName("credit_facet_name_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.credit_facet_id_seq'::regclass)");
            });

            modelBuilder.Entity<CreditSponsor>(entity =>
            {
                entity.HasIndex(e => e.Name)
                    .HasName("credit_sponsor_name_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.credit_sponsor_id_seq'::regclass)");
            });

            modelBuilder.Entity<Dxcc>(entity =>
            {
                entity.HasIndex(e => new { e.Code, e.Name })
                    .HasName("dxcc_code_name_uq")
                    .IsUnique();

                entity.Property(e => e.Id).ValueGeneratedNever();

                entity.Property(e => e.IsDeleted).HasDefaultValueSql("false");
            });

            modelBuilder.Entity<IaruRegion>(entity =>
            {
                entity.HasIndex(e => e.Region)
                    .HasName("iaru_region_region_uq")
                    .IsUnique();

                entity.Property(e => e.Id).ValueGeneratedNever();

                entity.HasOne(d => d.Weblink)
                    .WithMany(p => p.IaruRegion)
                    .HasForeignKey(d => d.WeblinkId)
                    .HasConstraintName("iaru_region_weblink_fkey");
            });

            modelBuilder.Entity<IaruRegionMember>(entity =>
            {
                entity.HasIndex(e => e.Name)
                    .HasName("iaru_region_name_uq")
                    .IsUnique();

                entity.Property(e => e.Id).ValueGeneratedNever();

                entity.HasOne(d => d.IaruRegion)
                    .WithMany(p => p.IaruRegionMember)
                    .HasForeignKey(d => d.IaruRegionId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("iaru_region_member_iaru_region_fkey");
            });

            modelBuilder.Entity<ItuZone>(entity =>
            {
                entity.HasIndex(e => e.Ituzone1)
                    .HasName("itu_zone_ituzone_uq")
                    .IsUnique();

                entity.Property(e => e.Id).ValueGeneratedNever();

                entity.HasOne(d => d.Weblink)
                    .WithMany(p => p.ItuZone)
                    .HasForeignKey(d => d.WeblinkId)
                    .HasConstraintName("itu_zone_weblink_fkey");
            });

            modelBuilder.Entity<JarlJcc>(entity =>
            {
                entity.HasIndex(e => e.Prefecture)
                    .HasName("jarl_jcc_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.jarl_jcc_id_seq'::regclass)");
            });

            modelBuilder.Entity<JarlJccCity>(entity =>
            {
                entity.HasIndex(e => new { e.Number, e.City })
                    .HasName("jarl_jcc_city_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.jarl_jcc_city_id_seq'::regclass)");

                entity.HasOne(d => d.Jcc)
                    .WithMany(p => p.JarlJccCity)
                    .HasForeignKey(d => d.JccId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("jarl_jcc_city_jarl_jcc_fkey");
            });

            modelBuilder.Entity<Mode>(entity =>
            {
                entity.HasIndex(e => e.Name)
                    .HasName("mode_name_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.mode_id_seq'::regclass)");

                entity.HasOne(d => d.ModeDescription)
                    .WithMany(p => p.Mode)
                    .HasForeignKey(d => d.ModeDescriptionId)
                    .HasConstraintName("mode_mode_description_fkey");
            });

            modelBuilder.Entity<ModeDescription>(entity =>
            {
                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.mode_description_id_seq'::regclass)");

                entity.HasOne(d => d.Weblink)
                    .WithMany(p => p.ModeDescription)
                    .HasForeignKey(d => d.WeblinkId)
                    .HasConstraintName("mode_description_weblink_fkey");
            });

            modelBuilder.Entity<Pas001>(entity =>
            {
                entity.HasIndex(e => new { e.Code, e.Subdivision })
                    .HasName("pas_001_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_001_id_seq'::regclass)");

                entity.HasOne(d => d.Dxcc)
                    .WithMany(p => p.Pas001)
                    .HasForeignKey(d => d.DxccId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_001_dxcc_fkey");
            });

            modelBuilder.Entity<Pas001Cqzone>(entity =>
            {
                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_001_cqzone_id_seq'::regclass)");

                entity.HasOne(d => d.CqZone)
                    .WithMany(p => p.Pas001Cqzone)
                    .HasForeignKey(d => d.CqZoneId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_001_cqzone_cq_zone_fkey");

                entity.HasOne(d => d.Pas001)
                    .WithMany(p => p.Pas001Cqzone)
                    .HasForeignKey(d => d.Pas001Id)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_001_cqzone_pas_001_fkey");
            });

            modelBuilder.Entity<Pas001Ituzone>(entity =>
            {
                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_001_ituzone_id_seq'::regclass)");

                entity.HasOne(d => d.ItuZone)
                    .WithMany(p => p.Pas001Ituzone)
                    .HasForeignKey(d => d.ItuZoneId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_001_ituzone_itu_zone_fkey");

                entity.HasOne(d => d.Pas001)
                    .WithMany(p => p.Pas001Ituzone)
                    .HasForeignKey(d => d.Pas001Id)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_001_ituzone_pas_001_fkey");
            });

            modelBuilder.Entity<Pas005>(entity =>
            {
                entity.HasIndex(e => new { e.Code, e.Subdivision })
                    .HasName("pas_005_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_005_id_seq'::regclass)");

                entity.HasOne(d => d.Dxcc)
                    .WithMany(p => p.Pas005)
                    .HasForeignKey(d => d.DxccId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_005_dxcc_fkey");
            });

            modelBuilder.Entity<Pas006>(entity =>
            {
                entity.HasIndex(e => new { e.Code, e.Subdivision })
                    .HasName("pas_006_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_006_id_seq'::regclass)");

                entity.HasOne(d => d.Dxcc)
                    .WithMany(p => p.Pas006)
                    .HasForeignKey(d => d.DxccId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_006_dxcc_fkey");
            });

            modelBuilder.Entity<Pas015>(entity =>
            {
                entity.HasIndex(e => new { e.Code, e.Subdivision })
                    .HasName("pas_015_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_015_id_seq'::regclass)");

                entity.HasOne(d => d.Dxcc)
                    .WithMany(p => p.Pas015)
                    .HasForeignKey(d => d.DxccId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_015_dxcc_fkey");
            });

            modelBuilder.Entity<Pas015Cqzone>(entity =>
            {
                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_015_cqzone_id_seq'::regclass)");

                entity.HasOne(d => d.CqZone)
                    .WithMany(p => p.Pas015Cqzone)
                    .HasForeignKey(d => d.CqZoneId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_015_cqzone_cq_zone_fkey");

                entity.HasOne(d => d.Pas015)
                    .WithMany(p => p.Pas015Cqzone)
                    .HasForeignKey(d => d.Pas015Id)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_015_cqzone_pas_015_fkey");
            });

            modelBuilder.Entity<Pas015Ituzone>(entity =>
            {
                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_015_ituzone_id_seq'::regclass)");

                entity.HasOne(d => d.ItuZone)
                    .WithMany(p => p.Pas015Ituzone)
                    .HasForeignKey(d => d.ItuZoneId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_015_ituzone_itu_zone_fkey");

                entity.HasOne(d => d.Pas015)
                    .WithMany(p => p.Pas015Ituzone)
                    .HasForeignKey(d => d.Pas015Id)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_015_ituzone_pas_015_fkey");
            });

            modelBuilder.Entity<Pas021>(entity =>
            {
                entity.HasIndex(e => new { e.Code, e.Subdivision })
                    .HasName("pas_021_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_021_id_seq'::regclass)");

                entity.HasOne(d => d.Dxcc)
                    .WithMany(p => p.Pas021)
                    .HasForeignKey(d => d.DxccId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_021_dxcc_fkey");
            });

            modelBuilder.Entity<Pas027>(entity =>
            {
                entity.HasIndex(e => new { e.Code, e.Subdivision })
                    .HasName("pas_027_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_027_id_seq'::regclass)");

                entity.HasOne(d => d.Dxcc)
                    .WithMany(p => p.Pas027)
                    .HasForeignKey(d => d.DxccId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_027_dxcc_fkey");
            });

            modelBuilder.Entity<Pas029>(entity =>
            {
                entity.HasIndex(e => new { e.Code, e.Subdivision })
                    .HasName("pas_029_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_029_id_seq'::regclass)");

                entity.HasOne(d => d.Dxcc)
                    .WithMany(p => p.Pas029)
                    .HasForeignKey(d => d.DxccId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_029_dxcc_fkey");
            });

            modelBuilder.Entity<Pas032>(entity =>
            {
                entity.HasIndex(e => new { e.Code, e.Subdivision })
                    .HasName("pas_032_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_032_id_seq'::regclass)");

                entity.HasOne(d => d.Dxcc)
                    .WithMany(p => p.Pas032)
                    .HasForeignKey(d => d.DxccId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_032_dxcc_fkey");
            });

            modelBuilder.Entity<Pas050>(entity =>
            {
                entity.HasIndex(e => new { e.Code, e.Subdivision })
                    .HasName("pas_050_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_050_id_seq'::regclass)");

                entity.HasOne(d => d.Dxcc)
                    .WithMany(p => p.Pas050)
                    .HasForeignKey(d => d.DxccId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_050_dxcc_fkey");
            });

            modelBuilder.Entity<Pas052>(entity =>
            {
                entity.HasIndex(e => new { e.Code, e.Subdivision })
                    .HasName("pas_052_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_052_id_seq'::regclass)");

                entity.HasOne(d => d.Dxcc)
                    .WithMany(p => p.Pas052)
                    .HasForeignKey(d => d.DxccId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_052_dxcc_fkey");
            });

            modelBuilder.Entity<Pas054>(entity =>
            {
                entity.HasIndex(e => new { e.Code, e.Subdivision })
                    .HasName("pas_054_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_054_id_seq'::regclass)");

                entity.HasOne(d => d.CqZone)
                    .WithMany(p => p.Pas054)
                    .HasForeignKey(d => d.CqZoneId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_054_cq_zone_fkey");

                entity.HasOne(d => d.Dxcc)
                    .WithMany(p => p.Pas054)
                    .HasForeignKey(d => d.DxccId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_054_dxcc_fkey");

                entity.HasOne(d => d.ItuXone)
                    .WithMany(p => p.Pas054)
                    .HasForeignKey(d => d.ItuXoneId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_054_itu_zone_fkey");
            });

            modelBuilder.Entity<Pas061>(entity =>
            {
                entity.HasIndex(e => new { e.Code, e.Subdivision })
                    .HasName("pas_061_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_061_id_seq'::regclass)");

                entity.HasOne(d => d.Dxcc)
                    .WithMany(p => p.Pas061)
                    .HasForeignKey(d => d.DxccId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_061_dxcc_fkey");
            });

            modelBuilder.Entity<Pas070>(entity =>
            {
                entity.HasIndex(e => new { e.Code, e.Subdivision })
                    .HasName("pas_070_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_070_id_seq'::regclass)");

                entity.HasOne(d => d.Dxcc)
                    .WithMany(p => p.Pas070)
                    .HasForeignKey(d => d.DxccId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_070_dxcc_fkey");
            });

            modelBuilder.Entity<Pas074>(entity =>
            {
                entity.HasIndex(e => new { e.Code, e.Subdivision })
                    .HasName("pas_074_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_074_id_seq'::regclass)");

                entity.HasOne(d => d.Dxcc)
                    .WithMany(p => p.Pas074)
                    .HasForeignKey(d => d.DxccId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_074_dxcc_fkey");
            });

            modelBuilder.Entity<Pas086>(entity =>
            {
                entity.HasIndex(e => new { e.Code, e.Subdivision })
                    .HasName("pas_086_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_086_id_seq'::regclass)");

                entity.HasOne(d => d.Dxcc)
                    .WithMany(p => p.Pas086)
                    .HasForeignKey(d => d.DxccId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_086_dxcc_fkey");
            });

            modelBuilder.Entity<Pas100>(entity =>
            {
                entity.HasIndex(e => new { e.Code, e.Subdivision })
                    .HasName("pas_100_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_100_id_seq'::regclass)");

                entity.HasOne(d => d.Dxcc)
                    .WithMany(p => p.Pas100)
                    .HasForeignKey(d => d.DxccId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_100_dxcc_fkey");
            });

            modelBuilder.Entity<Pas104>(entity =>
            {
                entity.HasIndex(e => new { e.Code, e.Subdivision })
                    .HasName("pas_104_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_104_id_seq'::regclass)");

                entity.HasOne(d => d.Dxcc)
                    .WithMany(p => p.Pas104)
                    .HasForeignKey(d => d.DxccId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_104_dxcc_fkey");
            });

            modelBuilder.Entity<Pas108>(entity =>
            {
                entity.HasIndex(e => new { e.Code, e.Subdivision })
                    .HasName("pas_108_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_108_id_seq'::regclass)");

                entity.HasOne(d => d.Dxcc)
                    .WithMany(p => p.Pas108)
                    .HasForeignKey(d => d.DxccId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_108_dxcc_fkey");
            });

            modelBuilder.Entity<Pas110>(entity =>
            {
                entity.HasIndex(e => new { e.Code, e.Subdivision })
                    .HasName("pas_110_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_110_id_seq'::regclass)");

                entity.HasOne(d => d.Dxcc)
                    .WithMany(p => p.Pas110)
                    .HasForeignKey(d => d.DxccId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_110_dxcc_fkey");
            });

            modelBuilder.Entity<Pas112>(entity =>
            {
                entity.HasIndex(e => new { e.Code, e.Subdivision })
                    .HasName("pas_112_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_112_id_seq'::regclass)");

                entity.HasOne(d => d.Dxcc)
                    .WithMany(p => p.Pas112)
                    .HasForeignKey(d => d.DxccId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_112_dxcc_fkey");
            });

            modelBuilder.Entity<Pas126>(entity =>
            {
                entity.HasIndex(e => new { e.Code, e.Subdivision })
                    .HasName("pas_126_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_126_id_seq'::regclass)");

                entity.HasOne(d => d.CqZone)
                    .WithMany(p => p.Pas126)
                    .HasForeignKey(d => d.CqZoneId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_126_cq_zone_fkey");

                entity.HasOne(d => d.Dxcc)
                    .WithMany(p => p.Pas126)
                    .HasForeignKey(d => d.DxccId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_126_dxcc_fkey");

                entity.HasOne(d => d.ItuXone)
                    .WithMany(p => p.Pas126)
                    .HasForeignKey(d => d.ItuXoneId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_126_itu_zone_fkey");
            });

            modelBuilder.Entity<Pas130>(entity =>
            {
                entity.HasIndex(e => new { e.Code, e.Subdivision, e.Oblast })
                    .HasName("pas_130_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_130_id_seq'::regclass)");

                entity.HasOne(d => d.Dxcc)
                    .WithMany(p => p.Pas130)
                    .HasForeignKey(d => d.DxccId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_130_dxcc_fkey");
            });

            modelBuilder.Entity<Pas132>(entity =>
            {
                entity.HasIndex(e => new { e.Code, e.Subdivision })
                    .HasName("pas_132_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_132_id_seq'::regclass)");

                entity.HasOne(d => d.Dxcc)
                    .WithMany(p => p.Pas132)
                    .HasForeignKey(d => d.DxccId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_132_dxcc_fkey");
            });

            modelBuilder.Entity<Pas137>(entity =>
            {
                entity.HasIndex(e => new { e.Code, e.Subdivision })
                    .HasName("pas_137_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_137_id_seq'::regclass)");

                entity.HasOne(d => d.Dxcc)
                    .WithMany(p => p.Pas137)
                    .HasForeignKey(d => d.DxccId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_137_dxcc_fkey");
            });

            modelBuilder.Entity<Pas138>(entity =>
            {
                entity.HasIndex(e => new { e.Code, e.Subdivision })
                    .HasName("pas_138_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_138_id_seq'::regclass)");

                entity.HasOne(d => d.Dxcc)
                    .WithMany(p => p.Pas138)
                    .HasForeignKey(d => d.DxccId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_138_dxcc_fkey");
            });

            modelBuilder.Entity<Pas144>(entity =>
            {
                entity.HasIndex(e => new { e.Code, e.Subdivision })
                    .HasName("pas_144_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_144_id_seq'::regclass)");

                entity.HasOne(d => d.Dxcc)
                    .WithMany(p => p.Pas144)
                    .HasForeignKey(d => d.DxccId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_144_dxcc_fkey");
            });

            modelBuilder.Entity<Pas147>(entity =>
            {
                entity.HasIndex(e => new { e.Code, e.Subdivision })
                    .HasName("pas_147_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_147_id_seq'::regclass)");

                entity.HasOne(d => d.Dxcc)
                    .WithMany(p => p.Pas147)
                    .HasForeignKey(d => d.DxccId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_147_dxcc_fkey");
            });

            modelBuilder.Entity<Pas148>(entity =>
            {
                entity.HasIndex(e => new { e.Code, e.Subdivision })
                    .HasName("pas_148_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_148_id_seq'::regclass)");

                entity.HasOne(d => d.Dxcc)
                    .WithMany(p => p.Pas148)
                    .HasForeignKey(d => d.DxccId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_148_dxcc_fkey");
            });

            modelBuilder.Entity<Pas149>(entity =>
            {
                entity.HasIndex(e => new { e.Code, e.Subdivision })
                    .HasName("pas_149_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_149_id_seq'::regclass)");

                entity.HasOne(d => d.Dxcc)
                    .WithMany(p => p.Pas149)
                    .HasForeignKey(d => d.DxccId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_149_dxcc_fkey");
            });

            modelBuilder.Entity<Pas150>(entity =>
            {
                entity.HasIndex(e => new { e.Code, e.Subdivision })
                    .HasName("pas_150_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_150_id_seq'::regclass)");

                entity.HasOne(d => d.Dxcc)
                    .WithMany(p => p.Pas150)
                    .HasForeignKey(d => d.DxccId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_150_dxcc_fkey");
            });

            modelBuilder.Entity<Pas151>(entity =>
            {
                entity.HasIndex(e => new { e.Code, e.Subdivision })
                    .HasName("pas_151_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_151_id_seq'::regclass)");

                entity.HasOne(d => d.Dxcc)
                    .WithMany(p => p.Pas151)
                    .HasForeignKey(d => d.DxccId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_151_dxcc_fkey");
            });

            modelBuilder.Entity<Pas153>(entity =>
            {
                entity.HasIndex(e => new { e.Code, e.Subdivision })
                    .HasName("pas_153_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_153_id_seq'::regclass)");

                entity.HasOne(d => d.Dxcc)
                    .WithMany(p => p.Pas153)
                    .HasForeignKey(d => d.DxccId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_153_dxcc_fkey");
            });

            modelBuilder.Entity<Pas163>(entity =>
            {
                entity.HasIndex(e => new { e.Code, e.Subdivision })
                    .HasName("pas_163_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_163_id_seq'::regclass)");

                entity.HasOne(d => d.Dxcc)
                    .WithMany(p => p.Pas163)
                    .HasForeignKey(d => d.DxccId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_163_dxcc_fkey");
            });

            modelBuilder.Entity<Pas170>(entity =>
            {
                entity.HasIndex(e => new { e.Code, e.Subdivision })
                    .HasName("pas_170_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_170_id_seq'::regclass)");

                entity.HasOne(d => d.Dxcc)
                    .WithMany(p => p.Pas170)
                    .HasForeignKey(d => d.DxccId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_170_dxcc_fkey");
            });

            modelBuilder.Entity<Pas177>(entity =>
            {
                entity.HasIndex(e => new { e.Code, e.Subdivision })
                    .HasName("pas_177_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_177_id_seq'::regclass)");

                entity.HasOne(d => d.Dxcc)
                    .WithMany(p => p.Pas177)
                    .HasForeignKey(d => d.DxccId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_177_dxcc_fkey");
            });

            modelBuilder.Entity<Pas179>(entity =>
            {
                entity.HasIndex(e => new { e.Code, e.Subdivision })
                    .HasName("pas_179_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_179_id_seq'::regclass)");

                entity.HasOne(d => d.Dxcc)
                    .WithMany(p => p.Pas179)
                    .HasForeignKey(d => d.DxccId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_179_dxcc_fkey");
            });

            modelBuilder.Entity<Pas192>(entity =>
            {
                entity.HasIndex(e => new { e.Code, e.Subdivision })
                    .HasName("pas_192_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_192_id_seq'::regclass)");

                entity.HasOne(d => d.Dxcc)
                    .WithMany(p => p.Pas192)
                    .HasForeignKey(d => d.DxccId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_192_dxcc_fkey");
            });

            modelBuilder.Entity<Pas206Region>(entity =>
            {
                entity.HasIndex(e => e.Region)
                    .HasName("pas_206_region_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_206_region_id_seq'::regclass)");

                entity.HasOne(d => d.Dxcc)
                    .WithMany(p => p.Pas206Region)
                    .HasForeignKey(d => d.DxccId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_206_region_dxcc_fkey");
            });

            modelBuilder.Entity<Pas206Subdivision>(entity =>
            {
                entity.HasIndex(e => new { e.Code, e.Subdivision })
                    .HasName("pas_206_subdivision_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_206_subdivision_id_seq'::regclass)");

                entity.HasOne(d => d.Pas206Region)
                    .WithMany(p => p.Pas206Subdivision)
                    .HasForeignKey(d => d.Pas206RegionId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_206_subdivision_pas_206_region_fkey");
            });

            modelBuilder.Entity<Pas209>(entity =>
            {
                entity.HasIndex(e => new { e.Code, e.Subdivision })
                    .HasName("pas_209_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_209_id_seq'::regclass)");

                entity.HasOne(d => d.Dxcc)
                    .WithMany(p => p.Pas209)
                    .HasForeignKey(d => d.DxccId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_209_dxcc_fkey");
            });

            modelBuilder.Entity<Pas212Region>(entity =>
            {
                entity.HasIndex(e => e.Region)
                    .HasName("pas_212_region_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_212_region_id_seq'::regclass)");

                entity.HasOne(d => d.Dxcc)
                    .WithMany(p => p.Pas212Region)
                    .HasForeignKey(d => d.DxccId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_212_region_dxcc_fkey");
            });

            modelBuilder.Entity<Pas212Subdivision>(entity =>
            {
                entity.HasIndex(e => new { e.Code, e.Subdivision })
                    .HasName("pas_212_subdivision_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_212_subdivision_id_seq'::regclass)");

                entity.HasOne(d => d.Pas212Region)
                    .WithMany(p => p.Pas212Subdivision)
                    .HasForeignKey(d => d.Pas212RegionId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_212_subdivision_pas_212_region_fkey");
            });

            modelBuilder.Entity<Pas214>(entity =>
            {
                entity.HasIndex(e => new { e.Code, e.Subdivision })
                    .HasName("pas_214_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_214_id_seq'::regclass)");

                entity.HasOne(d => d.Dxcc)
                    .WithMany(p => p.Pas214)
                    .HasForeignKey(d => d.DxccId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_214_dxcc_fkey");
            });

            modelBuilder.Entity<Pas221>(entity =>
            {
                entity.HasIndex(e => new { e.Code, e.Subdivision })
                    .HasName("pas_221_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_221_id_seq'::regclass)");

                entity.HasOne(d => d.Dxcc)
                    .WithMany(p => p.Pas221)
                    .HasForeignKey(d => d.DxccId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_221_dxcc_fkey");
            });

            modelBuilder.Entity<Pas224Region>(entity =>
            {
                entity.HasIndex(e => e.Region)
                    .HasName("pas_224_region_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_224_region_id_seq'::regclass)");

                entity.HasOne(d => d.Dxcc)
                    .WithMany(p => p.Pas224Region)
                    .HasForeignKey(d => d.DxccId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_224_region_dxcc_fkey");
            });

            modelBuilder.Entity<Pas224Subdivision>(entity =>
            {
                entity.HasIndex(e => new { e.Code, e.Subdivision })
                    .HasName("pas_224_subdivision_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_224_subdivision_id_seq'::regclass)");

                entity.HasOne(d => d.Pas224Region)
                    .WithMany(p => p.Pas224Subdivision)
                    .HasForeignKey(d => d.Pas224RegionId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_224_subdivision_pas_224_region_fkey");
            });

            modelBuilder.Entity<Pas225Region>(entity =>
            {
                entity.HasIndex(e => e.Region)
                    .HasName("pas_225_region_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_225_region_id_seq'::regclass)");

                entity.HasOne(d => d.Dxcc)
                    .WithMany(p => p.Pas225Region)
                    .HasForeignKey(d => d.DxccId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_225_region_dxcc_fkey");
            });

            modelBuilder.Entity<Pas225Subdivision>(entity =>
            {
                entity.HasIndex(e => new { e.Code, e.Subdivision })
                    .HasName("pas_225_subdivision_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_225_subdivision_id_seq'::regclass)");

                entity.HasOne(d => d.Pas225Region)
                    .WithMany(p => p.Pas225Subdivision)
                    .HasForeignKey(d => d.Pas225RegionId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_225_subdivision_pas_225_region_fkey");
            });

            modelBuilder.Entity<Pas227>(entity =>
            {
                entity.HasIndex(e => new { e.Code, e.Subdivision })
                    .HasName("pas_227_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_227_id_seq'::regclass)");

                entity.HasOne(d => d.Dxcc)
                    .WithMany(p => p.Pas227)
                    .HasForeignKey(d => d.DxccId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_227_dxcc_fkey");
            });

            modelBuilder.Entity<Pas230>(entity =>
            {
                entity.HasIndex(e => new { e.Code, e.Subdivision })
                    .HasName("pas_230_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_230_id_seq'::regclass)");

                entity.HasOne(d => d.Dxcc)
                    .WithMany(p => p.Pas230)
                    .HasForeignKey(d => d.DxccId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_230_dxcc_fkey");
            });

            modelBuilder.Entity<Pas239>(entity =>
            {
                entity.HasIndex(e => new { e.Code, e.Subdivision })
                    .HasName("pas_239_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_239_id_seq'::regclass)");

                entity.HasOne(d => d.Dxcc)
                    .WithMany(p => p.Pas239)
                    .HasForeignKey(d => d.DxccId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_239_dxcc_fkey");
            });

            modelBuilder.Entity<Pas245>(entity =>
            {
                entity.HasIndex(e => new { e.Code, e.Subdivision })
                    .HasName("pas_245_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_245_id_seq'::regclass)");

                entity.HasOne(d => d.Dxcc)
                    .WithMany(p => p.Pas245)
                    .HasForeignKey(d => d.DxccId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_245_dxcc_fkey");
            });

            modelBuilder.Entity<Pas248Region>(entity =>
            {
                entity.HasIndex(e => e.Region)
                    .HasName("pas_248_region_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_248_region_id_seq'::regclass)");

                entity.HasOne(d => d.Dxcc)
                    .WithMany(p => p.Pas248Region)
                    .HasForeignKey(d => d.DxccId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_248_region_dxcc_fkey");
            });

            modelBuilder.Entity<Pas248Subdivision>(entity =>
            {
                entity.HasIndex(e => new { e.Pas248RegionId, e.Code, e.Subdivision })
                    .HasName("pas_248_subdivision_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_248_subdivision_id_seq'::regclass)");

                entity.HasOne(d => d.Pas248Region)
                    .WithMany(p => p.Pas248Subdivision)
                    .HasForeignKey(d => d.Pas248RegionId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_248_subdivision_pas_248_region_fkey");
            });

            modelBuilder.Entity<Pas256>(entity =>
            {
                entity.HasIndex(e => new { e.Code, e.Subdivision })
                    .HasName("pas_256_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_256_id_seq'::regclass)");

                entity.HasOne(d => d.Dxcc)
                    .WithMany(p => p.Pas256)
                    .HasForeignKey(d => d.DxccId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_256_dxcc_fkey");
            });

            modelBuilder.Entity<Pas263>(entity =>
            {
                entity.HasIndex(e => new { e.Code, e.Subdivision })
                    .HasName("pas_263_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_263_id_seq'::regclass)");

                entity.HasOne(d => d.Dxcc)
                    .WithMany(p => p.Pas263)
                    .HasForeignKey(d => d.DxccId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_263_dxcc_fkey");
            });

            modelBuilder.Entity<Pas269>(entity =>
            {
                entity.HasIndex(e => new { e.Code, e.Subdivision })
                    .HasName("pas_269_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_269_id_seq'::regclass)");

                entity.HasOne(d => d.Dxcc)
                    .WithMany(p => p.Pas269)
                    .HasForeignKey(d => d.DxccId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_269_dxcc_fkey");
            });

            modelBuilder.Entity<Pas272>(entity =>
            {
                entity.HasIndex(e => new { e.Code, e.Subdivision })
                    .HasName("pas_272_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_272_id_seq'::regclass)");

                entity.HasOne(d => d.Dxcc)
                    .WithMany(p => p.Pas272)
                    .HasForeignKey(d => d.DxccId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_272_dxcc_fkey");
            });

            modelBuilder.Entity<Pas275>(entity =>
            {
                entity.HasIndex(e => new { e.Code, e.Subdivision })
                    .HasName("pas_275_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_275_id_seq'::regclass)");

                entity.HasOne(d => d.Dxcc)
                    .WithMany(p => p.Pas275)
                    .HasForeignKey(d => d.DxccId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_275_dxcc_fkey");
            });

            modelBuilder.Entity<Pas281>(entity =>
            {
                entity.HasIndex(e => new { e.Code, e.Subdivision })
                    .HasName("pas_281_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_281_id_seq'::regclass)");

                entity.HasOne(d => d.Dxcc)
                    .WithMany(p => p.Pas281)
                    .HasForeignKey(d => d.DxccId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_281_dxcc_fkey");
            });

            modelBuilder.Entity<Pas284>(entity =>
            {
                entity.HasIndex(e => new { e.Code, e.Subdivision })
                    .HasName("pas_284_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_284_id_seq'::regclass)");

                entity.HasOne(d => d.Dxcc)
                    .WithMany(p => p.Pas284)
                    .HasForeignKey(d => d.DxccId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_284_dxcc_fkey");
            });

            modelBuilder.Entity<Pas287>(entity =>
            {
                entity.HasIndex(e => new { e.Code, e.Subdivision })
                    .HasName("pas_287_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_287_id_seq'::regclass)");

                entity.HasOne(d => d.Dxcc)
                    .WithMany(p => p.Pas287)
                    .HasForeignKey(d => d.DxccId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_287_dxcc_fkey");
            });

            modelBuilder.Entity<Pas288>(entity =>
            {
                entity.HasIndex(e => new { e.Code, e.Subdivision })
                    .HasName("pas_288_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_288_id_seq'::regclass)");

                entity.HasOne(d => d.Dxcc)
                    .WithMany(p => p.Pas288)
                    .HasForeignKey(d => d.DxccId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_288_dxcc_fkey");
            });

            modelBuilder.Entity<Pas291>(entity =>
            {
                entity.HasIndex(e => new { e.Code, e.Subdivision })
                    .HasName("pas_291_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_291_id_seq'::regclass)");

                entity.HasOne(d => d.Dxcc)
                    .WithMany(p => p.Pas291)
                    .HasForeignKey(d => d.DxccId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_291_dxcc_fkey");
            });

            modelBuilder.Entity<Pas291Cqzone>(entity =>
            {
                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_291_cqzone_id_seq'::regclass)");

                entity.HasOne(d => d.CqZone)
                    .WithMany(p => p.Pas291Cqzone)
                    .HasForeignKey(d => d.CqZoneId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_291_cqzone_cq_zone_fkey");

                entity.HasOne(d => d.Pas291)
                    .WithMany(p => p.Pas291Cqzone)
                    .HasForeignKey(d => d.Pas291Id)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_291_cqzone_pas_291_fkey");
            });

            modelBuilder.Entity<Pas291Ituzone>(entity =>
            {
                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_291_ituzone_id_seq'::regclass)");

                entity.HasOne(d => d.ItuZone)
                    .WithMany(p => p.Pas291Ituzone)
                    .HasForeignKey(d => d.ItuZoneId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_291_ituzone_itu_zone_fkey");

                entity.HasOne(d => d.Pas291)
                    .WithMany(p => p.Pas291Ituzone)
                    .HasForeignKey(d => d.Pas291Id)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_291_ituzone_pas_291_fkey");
            });

            modelBuilder.Entity<Pas318>(entity =>
            {
                entity.HasIndex(e => new { e.Code, e.Subdivision })
                    .HasName("pas_318_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_318_id_seq'::regclass)");

                entity.HasOne(d => d.Dxcc)
                    .WithMany(p => p.Pas318)
                    .HasForeignKey(d => d.DxccId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_318_dxcc_fkey");
            });

            modelBuilder.Entity<Pas327>(entity =>
            {
                entity.HasIndex(e => new { e.Code, e.Subdivision })
                    .HasName("pas_327_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_327_id_seq'::regclass)");

                entity.HasOne(d => d.Dxcc)
                    .WithMany(p => p.Pas327)
                    .HasForeignKey(d => d.DxccId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_327_dxcc_fkey");
            });

            modelBuilder.Entity<Pas339Region>(entity =>
            {
                entity.HasIndex(e => e.Region)
                    .HasName("pas_339_region_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_339_region_id_seq'::regclass)");

                entity.HasOne(d => d.Dxcc)
                    .WithMany(p => p.Pas339Region)
                    .HasForeignKey(d => d.DxccId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_339_region_dxcc_fkey");
            });

            modelBuilder.Entity<Pas339Subdivision>(entity =>
            {
                entity.HasIndex(e => new { e.Code, e.Subdivision })
                    .HasName("pas_339_subdivision_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_339_subdivision_id_seq'::regclass)");

                entity.HasOne(d => d.Pas339Region)
                    .WithMany(p => p.Pas339Subdivision)
                    .HasForeignKey(d => d.Pas339RegionId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_339_subdivision_pas_339_region_fkey");
            });

            modelBuilder.Entity<Pas375Region>(entity =>
            {
                entity.HasIndex(e => e.Region)
                    .HasName("pas_375_region_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_375_region_id_seq'::regclass)");

                entity.HasOne(d => d.Dxcc)
                    .WithMany(p => p.Pas375Region)
                    .HasForeignKey(d => d.DxccId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_375_region_dxcc_fkey");
            });

            modelBuilder.Entity<Pas375Subdivision>(entity =>
            {
                entity.HasIndex(e => new { e.Code, e.Subdivision })
                    .HasName("pas_375_subdivision_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_375_subdivision_id_seq'::regclass)");

                entity.HasOne(d => d.Pas375Region)
                    .WithMany(p => p.Pas375Subdivision)
                    .HasForeignKey(d => d.Pas375RegionId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_375_subdivision_pas_375_region_fkey");
            });

            modelBuilder.Entity<Pas386>(entity =>
            {
                entity.HasIndex(e => new { e.Code, e.Subdivision })
                    .HasName("pas_386_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_386_id_seq'::regclass)");

                entity.HasOne(d => d.Dxcc)
                    .WithMany(p => p.Pas386)
                    .HasForeignKey(d => d.DxccId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_386_dxcc_fkey");
            });

            modelBuilder.Entity<Pas387>(entity =>
            {
                entity.HasIndex(e => new { e.Code, e.Subdivision })
                    .HasName("pas_387_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_387_id_seq'::regclass)");

                entity.HasOne(d => d.Dxcc)
                    .WithMany(p => p.Pas387)
                    .HasForeignKey(d => d.DxccId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_387_dxcc_fkey");
            });

            modelBuilder.Entity<Pas497>(entity =>
            {
                entity.HasIndex(e => new { e.Code, e.Subdivision })
                    .HasName("pas_497_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_497_id_seq'::regclass)");

                entity.HasOne(d => d.Dxcc)
                    .WithMany(p => p.Pas497)
                    .HasForeignKey(d => d.DxccId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_497_dxcc_fkey");
            });

            modelBuilder.Entity<Pas503Region>(entity =>
            {
                entity.HasIndex(e => e.Region)
                    .HasName("pas_503_region_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_503_region_id_seq'::regclass)");

                entity.HasOne(d => d.Dxcc)
                    .WithMany(p => p.Pas503Region)
                    .HasForeignKey(d => d.DxccId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_503_region_dxcc_fkey");
            });

            modelBuilder.Entity<Pas503Subdivision>(entity =>
            {
                entity.HasIndex(e => new { e.Code, e.Subdivision })
                    .HasName("pas_503_subdivision_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_503_subdivision_id_seq'::regclass)");

                entity.HasOne(d => d.Pas503Region)
                    .WithMany(p => p.Pas503Subdivision)
                    .HasForeignKey(d => d.Pas503RegionId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_503_subdivision_pas_503_region_fkey");
            });

            modelBuilder.Entity<Pas504Region>(entity =>
            {
                entity.HasIndex(e => e.Region)
                    .HasName("pas_504_region_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_504_region_id_seq'::regclass)");

                entity.HasOne(d => d.Dxcc)
                    .WithMany(p => p.Pas504Region)
                    .HasForeignKey(d => d.DxccId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_504_region_dxcc_fkey");
            });

            modelBuilder.Entity<Pas504Subdivision>(entity =>
            {
                entity.HasIndex(e => new { e.Code, e.Subdivision })
                    .HasName("pas_504_subdivision_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_504_subdivision_id_seq'::regclass)");

                entity.HasOne(d => d.Pas504Region)
                    .WithMany(p => p.Pas504Subdivision)
                    .HasForeignKey(d => d.Pas504RegionId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_504_subdivision_pas_504_region_fkey");
            });

            modelBuilder.Entity<PasSubdivisionType>(entity =>
            {
                entity.HasIndex(e => e.PasSubdivisionType1)
                    .HasName("pas_subdivision_type_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_subdivision_type_id_seq'::regclass)");
            });

            modelBuilder.Entity<PasSummary>(entity =>
            {
                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_summary_id_seq'::regclass)");

                entity.HasOne(d => d.Dxcc)
                    .WithMany(p => p.PasSummary)
                    .HasForeignKey(d => d.DxccId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_summary_dxcc_fkey");

                entity.HasOne(d => d.PasSubdivisionType)
                    .WithMany(p => p.PasSummary)
                    .HasForeignKey(d => d.PasSubdivisionTypeId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_summary_pas_subdivision_type_fkey");

                entity.HasOne(d => d.SasSubdivisionType)
                    .WithMany(p => p.PasSummary)
                    .HasForeignKey(d => d.SasSubdivisionTypeId)
                    .HasConstraintName("pas_summary_sas_subdivision_type_fkey");
            });

            modelBuilder.Entity<PropogationMode>(entity =>
            {
                entity.HasIndex(e => e.Enumeration)
                    .HasName("propogation_mode_abbreviation_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.propogation_mode_id_seq'::regclass)");
            });

            modelBuilder.Entity<QslMedium>(entity =>
            {
                entity.HasIndex(e => e.Medium)
                    .HasName("qsl_medium_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.qsl_medium_id_seq'::regclass)");
            });

            modelBuilder.Entity<QslRcvd>(entity =>
            {
                entity.HasIndex(e => e.Status)
                    .HasName("qsl_rcvd_status_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.qsl_rcvd_id_seq'::regclass)");
            });

            modelBuilder.Entity<QslSent>(entity =>
            {
                entity.HasIndex(e => e.Status)
                    .HasName("qsl_sent_status_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.qsl_sent_id_seq'::regclass)");
            });

            modelBuilder.Entity<QslVia>(entity =>
            {
                entity.HasIndex(e => e.Via)
                    .HasName("qsl_via_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.qsl_via_id_seq'::regclass)");
            });

            modelBuilder.Entity<QsoComplete>(entity =>
            {
                entity.HasIndex(e => e.Abbreviation)
                    .HasName("qso_complete_abbreviation_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.qso_complete_id_seq'::regclass)");
            });

            modelBuilder.Entity<QsoUploadStatus>(entity =>
            {
                entity.HasIndex(e => e.Abbreviaiton)
                    .HasName("qso_upload_status_abbreviation_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.qso_upload_status_id_seq'::regclass)");
            });

            modelBuilder.Entity<Rdxc>(entity =>
            {
                entity.HasIndex(e => new { e.Prefix, e.RdxcCode, e.Oblast })
                    .HasName("rdxc_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.rdxc_id_seq'::regclass)");
            });

            modelBuilder.Entity<RdxcDistrict>(entity =>
            {
                entity.HasIndex(e => new { e.Code, e.District })
                    .HasName("rdxc_district_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.rdxc_district_id_seq'::regclass)");

                entity.HasOne(d => d.Rdxc)
                    .WithMany(p => p.RdxcDistrict)
                    .HasForeignKey(d => d.RdxcId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("rdxc_district_rdxc_fkey");
            });

            modelBuilder.Entity<Region>(entity =>
            {
                entity.HasIndex(e => e.Code)
                    .HasName("region_code_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.region_id_seq'::regclass)");

                entity.HasOne(d => d.Dxcc)
                    .WithMany(p => p.Region)
                    .HasForeignKey(d => d.DxccId)
                    .HasConstraintName("region_dxcc_fkey");
            });

            modelBuilder.Entity<RegionApplicability>(entity =>
            {
                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.region_applicability_id_seq'::regclass)");

                entity.HasOne(d => d.Region)
                    .WithMany(p => p.RegionApplicability)
                    .HasForeignKey(d => d.RegionId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("region_applicability_region_fkey");

                entity.HasOne(d => d.Weblink)
                    .WithMany(p => p.RegionApplicability)
                    .HasForeignKey(d => d.WeblinkId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("region_applicability_weblink_fkey");
            });

            modelBuilder.Entity<SasSubdivisionType>(entity =>
            {
                entity.HasIndex(e => e.SasSubdivisionType1)
                    .HasName("sas_subdivision_type_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.sas_subdivision_type_id_seq'::regclass)");
            });

            modelBuilder.Entity<SchemaInfo>(entity =>
            {
                entity.HasKey(e => e.SchemaName)
                    .HasName("schema_info_schema_name_pkey");

                entity.Property(e => e.SchemaName).ValueGeneratedNever();

                entity.Property(e => e.LastUpdate).HasDefaultValueSql("now()");
            });

            modelBuilder.Entity<SourceList>(entity =>
            {
                entity.HasIndex(e => e.SourceName)
                    .HasName("source_name_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.source_list_id_seq'::regclass)");

                entity.HasOne(d => d.Weblink)
                    .WithMany(p => p.SourceList)
                    .HasForeignKey(d => d.WeblinkId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("source_list_weblink_fkey");
            });

            modelBuilder.Entity<SponsoredAward>(entity =>
            {
                entity.HasIndex(e => e.Sponsor)
                    .HasName("qso_sponsored_award_sponsor_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.sponsored_award_id_seq'::regclass)");

                entity.HasOne(d => d.Weblink)
                    .WithMany(p => p.SponsoredAward)
                    .HasForeignKey(d => d.WeblinkId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("sponsored_award_weblink_fkey");
            });

            modelBuilder.Entity<State>(entity =>
            {
                entity.HasIndex(e => new { e.Abbreviation, e.Name })
                    .HasName("state_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.state_id_seq'::regclass)");
            });

            modelBuilder.Entity<StateCounty>(entity =>
            {
                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.state_county_id_seq'::regclass)");

                entity.HasOne(d => d.CountyName)
                    .WithMany(p => p.StateCounty)
                    .HasForeignKey(d => d.CountyNameId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("state_county_county_name_fkey");

                entity.HasOne(d => d.State)
                    .WithMany(p => p.StateCounty)
                    .HasForeignKey(d => d.StateId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("state_county_state_fkey");
            });

            modelBuilder.Entity<Submode>(entity =>
            {
                entity.HasIndex(e => e.Name)
                    .HasName("submode_name_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.submode_id_seq'::regclass)");

                entity.HasOne(d => d.ModeDescription)
                    .WithMany(p => p.Submode)
                    .HasForeignKey(d => d.ModeDescriptionId)
                    .HasConstraintName("submode_mode_description_fkey");

                entity.HasOne(d => d.Mode)
                    .WithMany(p => p.Submode)
                    .HasForeignKey(d => d.ModeId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("submode_mode_fkey");
            });

            modelBuilder.Entity<Weblink>(entity =>
            {
                entity.HasIndex(e => e.DisplayText)
                    .HasName("weblink_display_text_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.weblink_id_seq'::regclass)");
            });

            modelBuilder.HasSequence<int>("antenna_path_id_seq");

            modelBuilder.HasSequence<int>("arrl_section_id_seq");

            modelBuilder.HasSequence<int>("award_id_seq");

            modelBuilder.HasSequence<int>("band_id_seq");

            modelBuilder.HasSequence<int>("contest_id_seq");

            modelBuilder.HasSequence<int>("continent_id_seq");

            modelBuilder.HasSequence<int>("county_name_id_seq");

            modelBuilder.HasSequence<int>("credit_award_id_seq");

            modelBuilder.HasSequence<int>("credit_facet_id_seq");

            modelBuilder.HasSequence<int>("credit_id_seq");

            modelBuilder.HasSequence<int>("credit_sponsor_id_seq");

            modelBuilder.HasSequence<int>("jarl_jcc_city_id_seq");

            modelBuilder.HasSequence<int>("jarl_jcc_id_seq");

            modelBuilder.HasSequence<int>("mode_description_id_seq");

            modelBuilder.HasSequence<int>("mode_id_seq");

            modelBuilder.HasSequence<int>("pas_001_cqzone_id_seq");

            modelBuilder.HasSequence<int>("pas_001_id_seq");

            modelBuilder.HasSequence<int>("pas_001_ituzone_id_seq");

            modelBuilder.HasSequence<int>("pas_005_id_seq");

            modelBuilder.HasSequence<int>("pas_006_id_seq");

            modelBuilder.HasSequence<int>("pas_015_cqzone_id_seq");

            modelBuilder.HasSequence<int>("pas_015_id_seq");

            modelBuilder.HasSequence<int>("pas_015_ituzone_id_seq");

            modelBuilder.HasSequence<int>("pas_021_id_seq");

            modelBuilder.HasSequence<int>("pas_027_id_seq");

            modelBuilder.HasSequence<int>("pas_029_id_seq");

            modelBuilder.HasSequence<int>("pas_032_id_seq");

            modelBuilder.HasSequence<int>("pas_050_id_seq");

            modelBuilder.HasSequence<int>("pas_052_id_seq");

            modelBuilder.HasSequence<int>("pas_054_id_seq");

            modelBuilder.HasSequence<int>("pas_061_id_seq");

            modelBuilder.HasSequence<int>("pas_070_id_seq");

            modelBuilder.HasSequence<int>("pas_074_id_seq");

            modelBuilder.HasSequence<int>("pas_086_id_seq");

            modelBuilder.HasSequence<int>("pas_100_id_seq");

            modelBuilder.HasSequence<int>("pas_104_id_seq");

            modelBuilder.HasSequence<int>("pas_108_id_seq");

            modelBuilder.HasSequence<int>("pas_110_id_seq");

            modelBuilder.HasSequence<int>("pas_112_id_seq");

            modelBuilder.HasSequence<int>("pas_126_id_seq");

            modelBuilder.HasSequence<int>("pas_130_id_seq");

            modelBuilder.HasSequence<int>("pas_132_id_seq");

            modelBuilder.HasSequence<int>("pas_137_id_seq");

            modelBuilder.HasSequence<int>("pas_138_id_seq");

            modelBuilder.HasSequence<int>("pas_144_id_seq");

            modelBuilder.HasSequence<int>("pas_147_id_seq");

            modelBuilder.HasSequence<int>("pas_148_id_seq");

            modelBuilder.HasSequence<int>("pas_149_id_seq");

            modelBuilder.HasSequence<int>("pas_150_id_seq");

            modelBuilder.HasSequence<int>("pas_151_id_seq");

            modelBuilder.HasSequence<int>("pas_153_id_seq");

            modelBuilder.HasSequence<int>("pas_163_id_seq");

            modelBuilder.HasSequence<int>("pas_170_id_seq");

            modelBuilder.HasSequence<int>("pas_177_id_seq");

            modelBuilder.HasSequence<int>("pas_179_id_seq");

            modelBuilder.HasSequence<int>("pas_192_id_seq");

            modelBuilder.HasSequence<int>("pas_206_region_id_seq");

            modelBuilder.HasSequence<int>("pas_206_subdivision_id_seq");

            modelBuilder.HasSequence<int>("pas_209_id_seq");

            modelBuilder.HasSequence<int>("pas_212_region_id_seq");

            modelBuilder.HasSequence<int>("pas_212_subdivision_id_seq");

            modelBuilder.HasSequence<int>("pas_214_id_seq");

            modelBuilder.HasSequence<int>("pas_221_id_seq");

            modelBuilder.HasSequence<int>("pas_224_region_id_seq");

            modelBuilder.HasSequence<int>("pas_224_subdivision_id_seq");

            modelBuilder.HasSequence<int>("pas_225_region_id_seq");

            modelBuilder.HasSequence<int>("pas_225_subdivision_id_seq");

            modelBuilder.HasSequence<int>("pas_227_id_seq");

            modelBuilder.HasSequence<int>("pas_230_id_seq");

            modelBuilder.HasSequence<int>("pas_239_id_seq");

            modelBuilder.HasSequence<int>("pas_245_id_seq");

            modelBuilder.HasSequence<int>("pas_248_region_id_seq");

            modelBuilder.HasSequence<int>("pas_248_subdivision_id_seq");

            modelBuilder.HasSequence<int>("pas_256_id_seq");

            modelBuilder.HasSequence<int>("pas_263_id_seq");

            modelBuilder.HasSequence<int>("pas_269_id_seq");

            modelBuilder.HasSequence<int>("pas_272_id_seq");

            modelBuilder.HasSequence<int>("pas_275_id_seq");

            modelBuilder.HasSequence<int>("pas_281_id_seq");

            modelBuilder.HasSequence<int>("pas_284_id_seq");

            modelBuilder.HasSequence<int>("pas_287_id_seq");

            modelBuilder.HasSequence<int>("pas_288_id_seq");

            modelBuilder.HasSequence<int>("pas_291_cqzone_id_seq");

            modelBuilder.HasSequence<int>("pas_291_id_seq");

            modelBuilder.HasSequence<int>("pas_291_ituzone_id_seq");

            modelBuilder.HasSequence<int>("pas_318_id_seq");

            modelBuilder.HasSequence<int>("pas_327_id_seq");

            modelBuilder.HasSequence<int>("pas_339_region_id_seq");

            modelBuilder.HasSequence<int>("pas_339_subdivision_id_seq");

            modelBuilder.HasSequence<int>("pas_375_region_id_seq");

            modelBuilder.HasSequence<int>("pas_375_subdivision_id_seq");

            modelBuilder.HasSequence<int>("pas_386_id_seq");

            modelBuilder.HasSequence<int>("pas_387_id_seq");

            modelBuilder.HasSequence<int>("pas_497_id_seq");

            modelBuilder.HasSequence<int>("pas_503_region_id_seq");

            modelBuilder.HasSequence<int>("pas_503_subdivision_id_seq");

            modelBuilder.HasSequence<int>("pas_504_region_id_seq");

            modelBuilder.HasSequence<int>("pas_504_subdivision_id_seq");

            modelBuilder.HasSequence<int>("pas_subdivision_type_id_seq");

            modelBuilder.HasSequence<int>("pas_summary_id_seq");

            modelBuilder.HasSequence<int>("propogation_mode_id_seq");

            modelBuilder.HasSequence<int>("qsl_medium_id_seq");

            modelBuilder.HasSequence<int>("qsl_rcvd_id_seq");

            modelBuilder.HasSequence<int>("qsl_sent_id_seq");

            modelBuilder.HasSequence<int>("qsl_via_id_seq");

            modelBuilder.HasSequence<int>("qso_complete_id_seq");

            modelBuilder.HasSequence<int>("qso_upload_status_id_seq");

            modelBuilder.HasSequence<int>("rdxc_district_id_seq");

            modelBuilder.HasSequence<int>("rdxc_id_seq");

            modelBuilder.HasSequence<int>("region_applicability_id_seq");

            modelBuilder.HasSequence<int>("region_id_seq");

            modelBuilder.HasSequence<int>("sas_subdivision_type_id_seq");

            modelBuilder.HasSequence<int>("source_list_id_seq");

            modelBuilder.HasSequence<int>("sponsored_award_id_seq");

            modelBuilder.HasSequence<int>("state_county_id_seq");

            modelBuilder.HasSequence<int>("state_id_seq");

            modelBuilder.HasSequence<int>("submode_id_seq");

            modelBuilder.HasSequence<int>("weblink_id_seq");
        }
    }
}
