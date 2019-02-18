using Microsoft.EntityFrameworkCore;

namespace Ards.NetCore.Adif.Api.Models
{
    public partial class AdifContext : DbContext
    {
        public AdifContext()
        {
        }

        public AdifContext(DbContextOptions<AdifContext> options)
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
        public virtual DbSet<DxccEntity> DxccEntity { get; set; }
        public virtual DbSet<EqslAgList> EqslAgList { get; set; }
        public virtual DbSet<ItuZone> ItuZone { get; set; }
        public virtual DbSet<JtalertData> JtalertData { get; set; }
        public virtual DbSet<LotwActivity> LotwActivity { get; set; }
        public virtual DbSet<Mode> Mode { get; set; }
        public virtual DbSet<ModeDescription> ModeDescription { get; set; }
        public virtual DbSet<Oblast> Oblast { get; set; }
        public virtual DbSet<Pas> Pas { get; set; }
        public virtual DbSet<PropogationMode> PropogationMode { get; set; }
        public virtual DbSet<QslMedium> QslMedium { get; set; }
        public virtual DbSet<QslRcvd> QslRcvd { get; set; }
        public virtual DbSet<QslSent> QslSent { get; set; }
        public virtual DbSet<QslVia> QslVia { get; set; }
        public virtual DbSet<QsoComplete> QsoComplete { get; set; }
        public virtual DbSet<QsoUploadStatus> QsoUploadStatus { get; set; }
        public virtual DbSet<Region> Region { get; set; }
        public virtual DbSet<RegionApplicability> RegionApplicability { get; set; }
        public virtual DbSet<Sas> Sas { get; set; }
        public virtual DbSet<SponsoredAward> SponsoredAward { get; set; }
        public virtual DbSet<State> State { get; set; }
        public virtual DbSet<StateCounty> StateCounty { get; set; }
        public virtual DbSet<Submode> Submode { get; set; }
        public virtual DbSet<Weblink> Weblink { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.HasAnnotation("ProductVersion", "2.2.1-servicing-10028");

            modelBuilder.Entity<AntennaPath>(entity =>
            {
                entity.HasIndex(e => new { e.Abbreviation, e.Meaning })
                    .HasName("antenna_path_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.antenna_path_id_seq'::regclass)");
            });

            modelBuilder.Entity<ArrlSection>(entity =>
            {
                entity.HasIndex(e => e.DxccEntityId)
                    .HasName("arrl_section_dxcc_entity_id_idx");

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.arrl_section_id_seq'::regclass)");

                entity.HasOne(d => d.DxccEntity)
                    .WithMany(p => p.ArrlSection)
                    .HasForeignKey(d => d.DxccEntityId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("arrl_section_dxcc_entity_fkey");
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

                entity.HasIndex(e => e.WeblinkId)
                    .HasName("contest_weblink_id_idx");

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
                entity.Property(e => e.Id).ValueGeneratedNever();
            });

            modelBuilder.Entity<Credit>(entity =>
            {
                entity.HasIndex(e => e.AwardId)
                    .HasName("credit_award_id_idx");

                entity.HasIndex(e => e.CreditFor)
                    .HasName("credit_for_uq")
                    .IsUnique();

                entity.HasIndex(e => e.FacetId)
                    .HasName("credit_facet_id_idx");

                entity.HasIndex(e => e.SponsorId)
                    .HasName("credit_sponsor_id_idx");

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

            modelBuilder.Entity<DxccEntity>(entity =>
            {
                entity.HasIndex(e => new { e.Code, e.Name })
                    .HasName("dxcc_entity_name_uq")
                    .IsUnique();

                entity.Property(e => e.Id).ValueGeneratedNever();

                entity.Property(e => e.IsDeleted).HasDefaultValueSql("false");
            });

            modelBuilder.Entity<EqslAgList>(entity =>
            {
                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.eqsl_ag_list_id_seq'::regclass)");
            });

            modelBuilder.Entity<ItuZone>(entity =>
            {
                entity.HasIndex(e => e.Number)
                    .HasName("itu_zone_number_uq")
                    .IsUnique();

                entity.Property(e => e.Id).ValueGeneratedNever();
            });

            modelBuilder.Entity<JtalertData>(entity =>
            {
                entity.HasKey(e => e.Call)
                    .HasName("jtalert_data_pkey");

                entity.Property(e => e.Call).ValueGeneratedNever();
            });

            modelBuilder.Entity<LotwActivity>(entity =>
            {
                entity.HasKey(e => e.Callsign)
                    .HasName("lotw_activity_callsign_pkey");

                entity.Property(e => e.Callsign).ValueGeneratedNever();
            });

            modelBuilder.Entity<Mode>(entity =>
            {
                entity.HasIndex(e => e.ModeDescriptionId)
                    .HasName("mode_mode_description_id_idx");

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
            });

            modelBuilder.Entity<Oblast>(entity =>
            {
                entity.HasIndex(e => e.Code)
                    .HasName("oblast_code_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.oblast_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas>(entity =>
            {
                entity.HasIndex(e => e.Code)
                    .HasName("pas_code_uq")
                    .IsUnique();

                entity.HasIndex(e => e.DxccEntityId)
                    .HasName("pas_dxcc_entity_id_idx");

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.pas_id_seq'::regclass)");

                entity.HasOne(d => d.DxccEntity)
                    .WithMany(p => p.Pas)
                    .HasForeignKey(d => d.DxccEntityId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("pas_dxcc_entity_fkey");
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

            modelBuilder.Entity<Region>(entity =>
            {
                entity.HasIndex(e => e.Code)
                    .HasName("region_code_uq")
                    .IsUnique();

                entity.HasIndex(e => e.DxccEntityId)
                    .HasName("region_dxcc_entity_id_idx");

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.region_id_seq'::regclass)");

                entity.HasOne(d => d.DxccEntity)
                    .WithMany(p => p.Region)
                    .HasForeignKey(d => d.DxccEntityId)
                    .HasConstraintName("region_dxcc_entity_fkey");
            });

            modelBuilder.Entity<RegionApplicability>(entity =>
            {
                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.region_applicability_id_seq'::regclass)");
            });

            modelBuilder.Entity<Sas>(entity =>
            {
                entity.HasIndex(e => e.Name)
                    .HasName("sas_name_uq")
                    .IsUnique();

                entity.HasIndex(e => e.PasId)
                    .HasName("sas_pas_id_idx");

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.sas_id_seq'::regclass)");

                entity.HasOne(d => d.Pas)
                    .WithMany(p => p.Sas)
                    .HasForeignKey(d => d.PasId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("sas_pas_fkey");
            });

            modelBuilder.Entity<SponsoredAward>(entity =>
            {
                entity.HasIndex(e => e.Sponsor)
                    .HasName("qso_sponsored_award_sponsor_uq")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("nextval('adif.sponsored_award_id_seq'::regclass)");
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
                entity.HasIndex(e => e.CountyNameId)
                    .HasName("state_county_county_name_id_idx");

                entity.HasIndex(e => e.StateId)
                    .HasName("state_county_state_id_idx");

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
                entity.HasIndex(e => e.ModeDescriptionId)
                    .HasName("submode_mode_description_id_idx");

                entity.HasIndex(e => e.ModeId)
                    .HasName("submode_mode_id_idx");

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

            modelBuilder.HasSequence<int>("eqsl_ag_list_id_seq");

            modelBuilder.HasSequence<int>("mode_description_id_seq");

            modelBuilder.HasSequence<int>("mode_id_seq");

            modelBuilder.HasSequence<int>("oblast_id_seq");

            modelBuilder.HasSequence<int>("pas_id_seq");

            modelBuilder.HasSequence<int>("propogation_mode_id_seq");

            modelBuilder.HasSequence<int>("qsl_medium_id_seq");

            modelBuilder.HasSequence<int>("qsl_rcvd_id_seq");

            modelBuilder.HasSequence<int>("qsl_sent_id_seq");

            modelBuilder.HasSequence<int>("qsl_via_id_seq");

            modelBuilder.HasSequence<int>("qso_complete_id_seq");

            modelBuilder.HasSequence<int>("qso_upload_status_id_seq");

            modelBuilder.HasSequence<int>("region_applicability_id_seq");

            modelBuilder.HasSequence<int>("region_id_seq");

            modelBuilder.HasSequence<int>("sas_id_seq");

            modelBuilder.HasSequence<int>("sponsored_award_id_seq");

            modelBuilder.HasSequence<int>("state_county_id_seq");

            modelBuilder.HasSequence<int>("state_id_seq");

            modelBuilder.HasSequence<int>("submode_id_seq");

            modelBuilder.HasSequence<int>("weblink_id_seq");
        }
    }
}
