using Microsoft.EntityFrameworkCore;

namespace Ards.Tools.Domain.Adif.ViewModels
{
    public partial class AdifDomain : DbContext
    {
        public AdifDomain()
        {
        }

        public AdifDomain(DbContextOptions<AdifDomain> options)
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
        public virtual DbSet<Cqzone> Cqzone { get; set; }
        public virtual DbSet<Credit> Credit { get; set; }
        public virtual DbSet<CreditAward> CreditAward { get; set; }
        public virtual DbSet<CreditFacet> CreditFacet { get; set; }
        public virtual DbSet<CreditSponsor> CreditSponsor { get; set; }
        public virtual DbSet<Dxcc> Dxcc { get; set; }
        public virtual DbSet<IaruRegion> IaruRegion { get; set; }
        public virtual DbSet<IaruRegionMember> IaruRegionMember { get; set; }
        public virtual DbSet<Ituzone> Ituzone { get; set; }
        public virtual DbSet<Jcc> Jcc { get; set; }
        public virtual DbSet<JccFullStats> JccFullStats { get; set; }
        public virtual DbSet<JccPrefectureStats> JccPrefectureStats { get; set; }
        public virtual DbSet<Mode> Mode { get; set; }
        public virtual DbSet<Pas1> Pas1 { get; set; }
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
        public virtual DbSet<Pas15> Pas15 { get; set; }
        public virtual DbSet<Pas150> Pas150 { get; set; }
        public virtual DbSet<Pas151> Pas151 { get; set; }
        public virtual DbSet<Pas153> Pas153 { get; set; }
        public virtual DbSet<Pas15Before> Pas15Before { get; set; }
        public virtual DbSet<Pas15Current> Pas15Current { get; set; }
        public virtual DbSet<Pas15Stats> Pas15Stats { get; set; }
        public virtual DbSet<Pas163> Pas163 { get; set; }
        public virtual DbSet<Pas170> Pas170 { get; set; }
        public virtual DbSet<Pas177> Pas177 { get; set; }
        public virtual DbSet<Pas179> Pas179 { get; set; }
        public virtual DbSet<Pas192> Pas192 { get; set; }
        public virtual DbSet<Pas206> Pas206 { get; set; }
        public virtual DbSet<Pas206Region> Pas206Region { get; set; }
        public virtual DbSet<Pas206Stats> Pas206Stats { get; set; }
        public virtual DbSet<Pas209> Pas209 { get; set; }
        public virtual DbSet<Pas21> Pas21 { get; set; }
        public virtual DbSet<Pas212> Pas212 { get; set; }
        public virtual DbSet<Pas212Region> Pas212Region { get; set; }
        public virtual DbSet<Pas212Stats> Pas212Stats { get; set; }
        public virtual DbSet<Pas214> Pas214 { get; set; }
        public virtual DbSet<Pas221> Pas221 { get; set; }
        public virtual DbSet<Pas224> Pas224 { get; set; }
        public virtual DbSet<Pas224Region> Pas224Region { get; set; }
        public virtual DbSet<Pas224Stats> Pas224Stats { get; set; }
        public virtual DbSet<Pas225> Pas225 { get; set; }
        public virtual DbSet<Pas225Region> Pas225Region { get; set; }
        public virtual DbSet<Pas225Stats> Pas225Stats { get; set; }
        public virtual DbSet<Pas227> Pas227 { get; set; }
        public virtual DbSet<Pas230> Pas230 { get; set; }
        public virtual DbSet<Pas239> Pas239 { get; set; }
        public virtual DbSet<Pas245> Pas245 { get; set; }
        public virtual DbSet<Pas248> Pas248 { get; set; }
        public virtual DbSet<Pas248Region> Pas248Region { get; set; }
        public virtual DbSet<Pas248Stats> Pas248Stats { get; set; }
        public virtual DbSet<Pas256> Pas256 { get; set; }
        public virtual DbSet<Pas263> Pas263 { get; set; }
        public virtual DbSet<Pas269> Pas269 { get; set; }
        public virtual DbSet<Pas27> Pas27 { get; set; }
        public virtual DbSet<Pas272> Pas272 { get; set; }
        public virtual DbSet<Pas275> Pas275 { get; set; }
        public virtual DbSet<Pas281> Pas281 { get; set; }
        public virtual DbSet<Pas284> Pas284 { get; set; }
        public virtual DbSet<Pas287> Pas287 { get; set; }
        public virtual DbSet<Pas288> Pas288 { get; set; }
        public virtual DbSet<Pas29> Pas29 { get; set; }
        public virtual DbSet<Pas291> Pas291 { get; set; }
        public virtual DbSet<Pas318> Pas318 { get; set; }
        public virtual DbSet<Pas32> Pas32 { get; set; }
        public virtual DbSet<Pas327> Pas327 { get; set; }
        public virtual DbSet<Pas339> Pas339 { get; set; }
        public virtual DbSet<Pas339Region> Pas339Region { get; set; }
        public virtual DbSet<Pas339Stats> Pas339Stats { get; set; }
        public virtual DbSet<Pas375> Pas375 { get; set; }
        public virtual DbSet<Pas375Region> Pas375Region { get; set; }
        public virtual DbSet<Pas375Stats> Pas375Stats { get; set; }
        public virtual DbSet<Pas386> Pas386 { get; set; }
        public virtual DbSet<Pas387> Pas387 { get; set; }
        public virtual DbSet<Pas497> Pas497 { get; set; }
        public virtual DbSet<Pas5> Pas5 { get; set; }
        public virtual DbSet<Pas50> Pas50 { get; set; }
        public virtual DbSet<Pas503> Pas503 { get; set; }
        public virtual DbSet<Pas503Region> Pas503Region { get; set; }
        public virtual DbSet<Pas503Stats> Pas503Stats { get; set; }
        public virtual DbSet<Pas504> Pas504 { get; set; }
        public virtual DbSet<Pas504Region> Pas504Region { get; set; }
        public virtual DbSet<Pas504Stats> Pas504Stats { get; set; }
        public virtual DbSet<Pas52> Pas52 { get; set; }
        public virtual DbSet<Pas54> Pas54 { get; set; }
        public virtual DbSet<Pas6> Pas6 { get; set; }
        public virtual DbSet<Pas61> Pas61 { get; set; }
        public virtual DbSet<Pas70> Pas70 { get; set; }
        public virtual DbSet<Pas74> Pas74 { get; set; }
        public virtual DbSet<Pas86> Pas86 { get; set; }
        public virtual DbSet<PasSummary> PasSummary { get; set; }
        public virtual DbSet<PasType> PasType { get; set; }
        public virtual DbSet<PropogationMode> PropogationMode { get; set; }
        public virtual DbSet<QslMedium> QslMedium { get; set; }
        public virtual DbSet<QslRcvd> QslRcvd { get; set; }
        public virtual DbSet<QslSent> QslSent { get; set; }
        public virtual DbSet<QslVia> QslVia { get; set; }
        public virtual DbSet<QsoComplete> QsoComplete { get; set; }
        public virtual DbSet<QsoUploadStatus> QsoUploadStatus { get; set; }
        public virtual DbSet<RdxcDistrictList> RdxcDistrictList { get; set; }
        public virtual DbSet<RdxcOblastCount> RdxcOblastCount { get; set; }
        public virtual DbSet<RdxcOblastStats> RdxcOblastStats { get; set; }
        public virtual DbSet<Region> Region { get; set; }
        public virtual DbSet<RegionApplicability> RegionApplicability { get; set; }
        public virtual DbSet<Sas110> Sas110 { get; set; }
        public virtual DbSet<Sas126> Sas126 { get; set; }
        public virtual DbSet<Sas137> Sas137 { get; set; }
        public virtual DbSet<Sas15> Sas15 { get; set; }
        public virtual DbSet<Sas151> Sas151 { get; set; }
        public virtual DbSet<Sas170> Sas170 { get; set; }
        public virtual DbSet<Sas177> Sas177 { get; set; }
        public virtual DbSet<Sas192> Sas192 { get; set; }
        public virtual DbSet<Sas288> Sas288 { get; set; }
        public virtual DbSet<Sas291> Sas291 { get; set; }
        public virtual DbSet<Sas339> Sas339 { get; set; }
        public virtual DbSet<Sas54> Sas54 { get; set; }
        public virtual DbSet<Sas6> Sas6 { get; set; }
        public virtual DbSet<Sas61> Sas61 { get; set; }
        public virtual DbSet<SasType> SasType { get; set; }
        public virtual DbSet<SponsoredAward> SponsoredAward { get; set; }
        public virtual DbSet<State> State { get; set; }
        public virtual DbSet<StateCounty> StateCounty { get; set; }
        public virtual DbSet<Submode> Submode { get; set; }
        public virtual DbSet<Weblink> Weblink { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.HasAnnotation("ProductVersion", "2.2.3-servicing-35854");

            modelBuilder.Entity<AntennaPath>(entity =>
            {
                entity.Property(e => e.AntennaPathId).ValueGeneratedNever();
            });

            modelBuilder.Entity<ArrlSection>(entity =>
            {
                entity.Property(e => e.ArrlSectionId).ValueGeneratedNever();
            });

            modelBuilder.Entity<Award>(entity =>
            {
                entity.Property(e => e.AwardId).ValueGeneratedNever();
            });

            modelBuilder.Entity<Band>(entity =>
            {
                entity.Property(e => e.BandId).ValueGeneratedNever();
            });

            modelBuilder.Entity<Contest>(entity =>
            {
                entity.Property(e => e.ContestId).ValueGeneratedNever();
            });

            modelBuilder.Entity<Continent>(entity =>
            {
                entity.Property(e => e.ContinentId).ValueGeneratedNever();
            });

            modelBuilder.Entity<CountyName>(entity =>
            {
                entity.Property(e => e.CountyNameId).ValueGeneratedNever();
            });

            modelBuilder.Entity<Cqzone>(entity =>
            {
                entity.Property(e => e.CqzoneId).ValueGeneratedNever();
            });

            modelBuilder.Entity<Credit>(entity =>
            {
                entity.Property(e => e.CreditId).ValueGeneratedNever();
            });

            modelBuilder.Entity<CreditAward>(entity =>
            {
                entity.Property(e => e.CreditAwardId).ValueGeneratedNever();
            });

            modelBuilder.Entity<CreditFacet>(entity =>
            {
                entity.Property(e => e.CreditFacetId).ValueGeneratedNever();
            });

            modelBuilder.Entity<CreditSponsor>(entity =>
            {
                entity.Property(e => e.CreditSponsorId).ValueGeneratedNever();
            });

            modelBuilder.Entity<Dxcc>(entity =>
            {
                entity.Property(e => e.DxccId).ValueGeneratedNever();
            });

            modelBuilder.Entity<IaruRegion>(entity =>
            {
                entity.Property(e => e.IaruRegionId).ValueGeneratedNever();
            });

            modelBuilder.Entity<IaruRegionMember>(entity =>
            {
                entity.Property(e => e.IaruRegionMemberId).ValueGeneratedNever();
            });

            modelBuilder.Entity<Ituzone>(entity =>
            {
                entity.Property(e => e.ItuzoneId).ValueGeneratedNever();
            });

            modelBuilder.Entity<Jcc>(entity =>
            {
                entity.Property(e => e.JccId).HasDefaultValueSql("nextval('adif_view.jcc_jcc_id_seq'::regclass)");
            });

            modelBuilder.Entity<JccFullStats>(entity =>
            {
                entity.Property(e => e.JccFullStatsId).HasDefaultValueSql("nextval('adif_view.jcc_full_stats_jcc_full_stats_id_seq'::regclass)");
            });

            modelBuilder.Entity<JccPrefectureStats>(entity =>
            {
                entity.Property(e => e.JccPrefectureStatsId).HasDefaultValueSql("nextval('adif_view.jcc_prefecture_stats_jcc_prefecture_stats_id_seq'::regclass)");
            });

            modelBuilder.Entity<Mode>(entity =>
            {
                entity.Property(e => e.ModeId).ValueGeneratedNever();
            });

            modelBuilder.Entity<Pas1>(entity =>
            {
                entity.Property(e => e.Pas1Id).HasDefaultValueSql("nextval('adif_view.pas1_pas1_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas100>(entity =>
            {
                entity.Property(e => e.Pas100Id).HasDefaultValueSql("nextval('adif_view.pas100_pas100_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas104>(entity =>
            {
                entity.Property(e => e.Pas104Id).HasDefaultValueSql("nextval('adif_view.pas104_pas104_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas108>(entity =>
            {
                entity.Property(e => e.Pas108Id).HasDefaultValueSql("nextval('adif_view.pas108_pas108_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas110>(entity =>
            {
                entity.Property(e => e.Pas110Id).HasDefaultValueSql("nextval('adif_view.pas110_pas110_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas112>(entity =>
            {
                entity.Property(e => e.Pas112Id).HasDefaultValueSql("nextval('adif_view.pas112_pas112_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas126>(entity =>
            {
                entity.Property(e => e.Pas126Id).HasDefaultValueSql("nextval('adif_view.pas126_pas126_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas130>(entity =>
            {
                entity.Property(e => e.Pas130Id).HasDefaultValueSql("nextval('adif_view.pas130_pas130_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas132>(entity =>
            {
                entity.Property(e => e.Pas132Id).HasDefaultValueSql("nextval('adif_view.pas132_pas132_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas137>(entity =>
            {
                entity.Property(e => e.Pas137Id).HasDefaultValueSql("nextval('adif_view.pas137_pas137_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas138>(entity =>
            {
                entity.Property(e => e.Pas138Id).HasDefaultValueSql("nextval('adif_view.pas138_pas138_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas144>(entity =>
            {
                entity.Property(e => e.Pas144Id).HasDefaultValueSql("nextval('adif_view.pas144_pas144_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas147>(entity =>
            {
                entity.Property(e => e.Pas147Id).HasDefaultValueSql("nextval('adif_view.pas147_pas147_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas148>(entity =>
            {
                entity.Property(e => e.Pas148Id).HasDefaultValueSql("nextval('adif_view.pas148_pas148_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas149>(entity =>
            {
                entity.Property(e => e.Pas149Id).HasDefaultValueSql("nextval('adif_view.pas149_pas149_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas15>(entity =>
            {
                entity.Property(e => e.Pas15Id).HasDefaultValueSql("nextval('adif_view.pas15_pas15_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas150>(entity =>
            {
                entity.Property(e => e.Pas150Id).HasDefaultValueSql("nextval('adif_view.pas150_pas150_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas151>(entity =>
            {
                entity.Property(e => e.Pas151Id).HasDefaultValueSql("nextval('adif_view.pas151_pas151_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas153>(entity =>
            {
                entity.Property(e => e.Pas153Id).HasDefaultValueSql("nextval('adif_view.pas153_pas153_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas15Before>(entity =>
            {
                entity.Property(e => e.Pas15BeforeId).HasDefaultValueSql("nextval('adif_view.pas15_before_pas15_before_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas15Current>(entity =>
            {
                entity.Property(e => e.Pas15CurrentId).HasDefaultValueSql("nextval('adif_view.pas15_current_pas15_current_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas15Stats>(entity =>
            {
                entity.Property(e => e.Pas15StatsId).HasDefaultValueSql("nextval('adif_view.pas15_stats_pas15_stats_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas163>(entity =>
            {
                entity.Property(e => e.Pas163Id).HasDefaultValueSql("nextval('adif_view.pas163_pas163_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas170>(entity =>
            {
                entity.Property(e => e.Pas170Id).HasDefaultValueSql("nextval('adif_view.pas170_pas170_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas177>(entity =>
            {
                entity.Property(e => e.Pas177Id).HasDefaultValueSql("nextval('adif_view.pas177_pas177_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas179>(entity =>
            {
                entity.Property(e => e.Pas179Id).HasDefaultValueSql("nextval('adif_view.pas179_pas179_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas192>(entity =>
            {
                entity.Property(e => e.Pas192Id).HasDefaultValueSql("nextval('adif_view.pas192_pas192_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas206>(entity =>
            {
                entity.Property(e => e.Pas206Id).HasDefaultValueSql("nextval('adif_view.pas206_pas206_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas206Region>(entity =>
            {
                entity.Property(e => e.Pas206RegionId).HasDefaultValueSql("nextval('adif_view.pas206_region_pas206_region_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas206Stats>(entity =>
            {
                entity.Property(e => e.Pas206StatsId).HasDefaultValueSql("nextval('adif_view.pas206_stats_pas206_stats_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas209>(entity =>
            {
                entity.Property(e => e.Pas209Id).HasDefaultValueSql("nextval('adif_view.pas209_pas209_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas21>(entity =>
            {
                entity.Property(e => e.Pas21Id).HasDefaultValueSql("nextval('adif_view.pas21_pas21_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas212>(entity =>
            {
                entity.Property(e => e.Pas212Id).HasDefaultValueSql("nextval('adif_view.pas212_pas212_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas212Region>(entity =>
            {
                entity.Property(e => e.Pas212RegionId).HasDefaultValueSql("nextval('adif_view.pas212_region_pas212_region_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas212Stats>(entity =>
            {
                entity.Property(e => e.Pas212StatsId).HasDefaultValueSql("nextval('adif_view.pas212_stats_pas212_stats_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas214>(entity =>
            {
                entity.Property(e => e.Pas214Id).HasDefaultValueSql("nextval('adif_view.pas214_pas214_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas221>(entity =>
            {
                entity.Property(e => e.Pas221Id).HasDefaultValueSql("nextval('adif_view.pas221_pas221_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas224>(entity =>
            {
                entity.Property(e => e.Pas224Id).HasDefaultValueSql("nextval('adif_view.pas224_pas224_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas224Region>(entity =>
            {
                entity.Property(e => e.Pas224RegionId).HasDefaultValueSql("nextval('adif_view.pas224_region_pas224_region_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas224Stats>(entity =>
            {
                entity.Property(e => e.Pas224StatsId).HasDefaultValueSql("nextval('adif_view.pas224_stats_pas224_stats_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas225>(entity =>
            {
                entity.Property(e => e.Pas225Id).HasDefaultValueSql("nextval('adif_view.pas225_pas225_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas225Region>(entity =>
            {
                entity.Property(e => e.Pas225RegionId).HasDefaultValueSql("nextval('adif_view.pas225_region_pas225_region_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas225Stats>(entity =>
            {
                entity.Property(e => e.Pas225StatsId).HasDefaultValueSql("nextval('adif_view.pas225_stats_pas225_stats_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas227>(entity =>
            {
                entity.Property(e => e.Pas227Id).HasDefaultValueSql("nextval('adif_view.pas227_pas227_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas230>(entity =>
            {
                entity.Property(e => e.Pas230Id).HasDefaultValueSql("nextval('adif_view.pas230_pas230_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas239>(entity =>
            {
                entity.Property(e => e.Pas239Id).HasDefaultValueSql("nextval('adif_view.pas239_pas239_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas245>(entity =>
            {
                entity.Property(e => e.Pas245Id).HasDefaultValueSql("nextval('adif_view.pas245_pas245_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas248>(entity =>
            {
                entity.Property(e => e.Pas248Id).HasDefaultValueSql("nextval('adif_view.pas248_pas248_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas248Region>(entity =>
            {
                entity.Property(e => e.Pas248RegionId).HasDefaultValueSql("nextval('adif_view.pas248_region_pas248_region_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas248Stats>(entity =>
            {
                entity.Property(e => e.Pas248StatsId).HasDefaultValueSql("nextval('adif_view.pas248_stats_pas248_stats_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas256>(entity =>
            {
                entity.Property(e => e.Pas256Id).HasDefaultValueSql("nextval('adif_view.pas256_pas256_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas263>(entity =>
            {
                entity.Property(e => e.Pas263Id).HasDefaultValueSql("nextval('adif_view.pas263_pas263_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas269>(entity =>
            {
                entity.Property(e => e.Pas269Id).HasDefaultValueSql("nextval('adif_view.pas269_pas269_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas27>(entity =>
            {
                entity.Property(e => e.Pas27Id).HasDefaultValueSql("nextval('adif_view.pas27_pas27_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas272>(entity =>
            {
                entity.Property(e => e.Pas272Id).HasDefaultValueSql("nextval('adif_view.pas272_pas272_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas275>(entity =>
            {
                entity.Property(e => e.Pas275Id).HasDefaultValueSql("nextval('adif_view.pas275_pas275_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas281>(entity =>
            {
                entity.Property(e => e.Pas281Id).HasDefaultValueSql("nextval('adif_view.pas281_pas281_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas284>(entity =>
            {
                entity.Property(e => e.Pas284Id).HasDefaultValueSql("nextval('adif_view.pas284_pas284_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas287>(entity =>
            {
                entity.Property(e => e.Pas287Id).HasDefaultValueSql("nextval('adif_view.pas287_pas287_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas288>(entity =>
            {
                entity.Property(e => e.Pas288Id).HasDefaultValueSql("nextval('adif_view.pas288_pas288_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas29>(entity =>
            {
                entity.Property(e => e.Pas29Id).HasDefaultValueSql("nextval('adif_view.pas29_pas29_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas291>(entity =>
            {
                entity.Property(e => e.Pas291Id).HasDefaultValueSql("nextval('adif_view.pas291_pas291_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas318>(entity =>
            {
                entity.Property(e => e.Pas318Id).HasDefaultValueSql("nextval('adif_view.pas318_pas318_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas32>(entity =>
            {
                entity.Property(e => e.Pas32Id).HasDefaultValueSql("nextval('adif_view.pas32_pas32_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas327>(entity =>
            {
                entity.Property(e => e.Pas327Id).HasDefaultValueSql("nextval('adif_view.pas327_pas327_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas339>(entity =>
            {
                entity.Property(e => e.Pas339Id).HasDefaultValueSql("nextval('adif_view.pas339_pas339_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas339Region>(entity =>
            {
                entity.Property(e => e.Pas339RegionId).HasDefaultValueSql("nextval('adif_view.pas339_region_pas339_region_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas339Stats>(entity =>
            {
                entity.Property(e => e.Pas339StatsId).HasDefaultValueSql("nextval('adif_view.pas339_stats_pas339_stats_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas375>(entity =>
            {
                entity.Property(e => e.Pas375Id).HasDefaultValueSql("nextval('adif_view.pas375_pas375_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas375Region>(entity =>
            {
                entity.Property(e => e.Pas375RegionId).HasDefaultValueSql("nextval('adif_view.pas375_region_pas375_region_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas375Stats>(entity =>
            {
                entity.Property(e => e.Pas375StatsId).HasDefaultValueSql("nextval('adif_view.pas375_stats_pas375_stats_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas386>(entity =>
            {
                entity.Property(e => e.Pas386Id).HasDefaultValueSql("nextval('adif_view.pas386_pas386_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas387>(entity =>
            {
                entity.Property(e => e.Pas387Id).HasDefaultValueSql("nextval('adif_view.pas387_pas387_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas497>(entity =>
            {
                entity.Property(e => e.Pas497Id).HasDefaultValueSql("nextval('adif_view.pas497_pas497_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas5>(entity =>
            {
                entity.Property(e => e.Pas5Id).HasDefaultValueSql("nextval('adif_view.pas5_pas5_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas50>(entity =>
            {
                entity.Property(e => e.Pas50Id).HasDefaultValueSql("nextval('adif_view.pas50_pas50_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas503>(entity =>
            {
                entity.Property(e => e.Pas503Id).HasDefaultValueSql("nextval('adif_view.pas503_pas503_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas503Region>(entity =>
            {
                entity.Property(e => e.Pas503RegionId).HasDefaultValueSql("nextval('adif_view.pas503_region_pas503_region_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas503Stats>(entity =>
            {
                entity.Property(e => e.Pas503StatsId).HasDefaultValueSql("nextval('adif_view.pas503_stats_pas503_stats_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas504>(entity =>
            {
                entity.Property(e => e.Pas504Id).HasDefaultValueSql("nextval('adif_view.pas504_pas504_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas504Region>(entity =>
            {
                entity.Property(e => e.Pas504RegionId).HasDefaultValueSql("nextval('adif_view.pas504_region_pas504_region_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas504Stats>(entity =>
            {
                entity.Property(e => e.Pas504StatsId).HasDefaultValueSql("nextval('adif_view.pas504_stats_pas504_stats_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas52>(entity =>
            {
                entity.Property(e => e.Pas52Id).HasDefaultValueSql("nextval('adif_view.pas52_pas52_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas54>(entity =>
            {
                entity.Property(e => e.Pas54Id).HasDefaultValueSql("nextval('adif_view.pas54_pas54_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas6>(entity =>
            {
                entity.Property(e => e.Pas6Id).HasDefaultValueSql("nextval('adif_view.pas6_pas6_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas61>(entity =>
            {
                entity.Property(e => e.Pas61Id).HasDefaultValueSql("nextval('adif_view.pas61_pas61_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas70>(entity =>
            {
                entity.Property(e => e.Pas70Id).HasDefaultValueSql("nextval('adif_view.pas70_pas70_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas74>(entity =>
            {
                entity.Property(e => e.Pas74Id).HasDefaultValueSql("nextval('adif_view.pas74_pas74_id_seq'::regclass)");
            });

            modelBuilder.Entity<Pas86>(entity =>
            {
                entity.Property(e => e.Pas86Id).HasDefaultValueSql("nextval('adif_view.pas86_pas86_id_seq'::regclass)");
            });

            modelBuilder.Entity<PasSummary>(entity =>
            {
                entity.Property(e => e.PasSummaryId).ValueGeneratedNever();
            });

            modelBuilder.Entity<PasType>(entity =>
            {
                entity.Property(e => e.PasTypeId).ValueGeneratedNever();
            });

            modelBuilder.Entity<PropogationMode>(entity =>
            {
                entity.Property(e => e.PropogationModeId).ValueGeneratedNever();
            });

            modelBuilder.Entity<QslMedium>(entity =>
            {
                entity.Property(e => e.QslMediumId).ValueGeneratedNever();
            });

            modelBuilder.Entity<QslRcvd>(entity =>
            {
                entity.Property(e => e.QslRcvdId).ValueGeneratedNever();
            });

            modelBuilder.Entity<QslSent>(entity =>
            {
                entity.Property(e => e.QslSentId).ValueGeneratedNever();
            });

            modelBuilder.Entity<QslVia>(entity =>
            {
                entity.Property(e => e.QslViaId).ValueGeneratedNever();
            });

            modelBuilder.Entity<QsoComplete>(entity =>
            {
                entity.Property(e => e.QsoCompleteId).ValueGeneratedNever();
            });

            modelBuilder.Entity<QsoUploadStatus>(entity =>
            {
                entity.Property(e => e.QsoUploadStatusId).ValueGeneratedNever();
            });

            modelBuilder.Entity<RdxcDistrictList>(entity =>
            {
                entity.Property(e => e.RdxcDistrictListId).HasDefaultValueSql("nextval('adif_view.rdxc_district_list_rdxc_district_list_id_seq'::regclass)");
            });

            modelBuilder.Entity<RdxcOblastCount>(entity =>
            {
                entity.Property(e => e.RdxcOblastCountId).HasDefaultValueSql("nextval('adif_view.rdxc_oblast_count_rdxc_oblast_count_id_seq'::regclass)");
            });

            modelBuilder.Entity<RdxcOblastStats>(entity =>
            {
                entity.Property(e => e.RdxcOblastStatsId).HasDefaultValueSql("nextval('adif_view.rdxc_oblast_stats_rdxc_oblast_stats_id_seq'::regclass)");
            });

            modelBuilder.Entity<Region>(entity =>
            {
                entity.Property(e => e.RegionId).ValueGeneratedNever();
            });

            modelBuilder.Entity<RegionApplicability>(entity =>
            {
                entity.Property(e => e.RegionApplicabilityId).ValueGeneratedNever();
            });

            modelBuilder.Entity<Sas110>(entity =>
            {
                entity.Property(e => e.Sas110Id).HasDefaultValueSql("nextval('adif_view.sas110_sas110_id_seq'::regclass)");
            });

            modelBuilder.Entity<Sas126>(entity =>
            {
                entity.Property(e => e.Sas126Id).HasDefaultValueSql("nextval('adif_view.sas126_sas126_id_seq'::regclass)");
            });

            modelBuilder.Entity<Sas137>(entity =>
            {
                entity.Property(e => e.Sas137Id).HasDefaultValueSql("nextval('adif_view.sas137_sas137_id_seq'::regclass)");
            });

            modelBuilder.Entity<Sas15>(entity =>
            {
                entity.Property(e => e.Sas15Id).HasDefaultValueSql("nextval('adif_view.sas15_sas15_id_seq'::regclass)");
            });

            modelBuilder.Entity<Sas151>(entity =>
            {
                entity.Property(e => e.Sas151Id).HasDefaultValueSql("nextval('adif_view.sas151_sas151_id_seq'::regclass)");
            });

            modelBuilder.Entity<Sas170>(entity =>
            {
                entity.Property(e => e.Sas170Id).HasDefaultValueSql("nextval('adif_view.sas170_sas170_id_seq'::regclass)");
            });

            modelBuilder.Entity<Sas177>(entity =>
            {
                entity.Property(e => e.Sas177Id).HasDefaultValueSql("nextval('adif_view.sas177_sas177_id_seq'::regclass)");
            });

            modelBuilder.Entity<Sas192>(entity =>
            {
                entity.Property(e => e.Sas192Id).HasDefaultValueSql("nextval('adif_view.sas192_sas192_id_seq'::regclass)");
            });

            modelBuilder.Entity<Sas288>(entity =>
            {
                entity.Property(e => e.Sas288Id).HasDefaultValueSql("nextval('adif_view.sas288_sas288_id_seq'::regclass)");
            });

            modelBuilder.Entity<Sas291>(entity =>
            {
                entity.Property(e => e.Sas291Id).HasDefaultValueSql("nextval('adif_view.sas291_sas291_id_seq'::regclass)");
            });

            modelBuilder.Entity<Sas339>(entity =>
            {
                entity.Property(e => e.Sas339Id).HasDefaultValueSql("nextval('adif_view.sas339_sas339_id_seq'::regclass)");
            });

            modelBuilder.Entity<Sas54>(entity =>
            {
                entity.Property(e => e.Sas54Id).HasDefaultValueSql("nextval('adif_view.sas54_sas54_id_seq'::regclass)");
            });

            modelBuilder.Entity<Sas6>(entity =>
            {
                entity.Property(e => e.Sas6Id).HasDefaultValueSql("nextval('adif_view.sas6_sas6_id_seq'::regclass)");
            });

            modelBuilder.Entity<Sas61>(entity =>
            {
                entity.Property(e => e.Sas61Id).HasDefaultValueSql("nextval('adif_view.sas61_sas61_id_seq'::regclass)");
            });

            modelBuilder.Entity<SasType>(entity =>
            {
                entity.Property(e => e.SasTypeId).ValueGeneratedNever();
            });

            modelBuilder.Entity<SponsoredAward>(entity =>
            {
                entity.Property(e => e.SponsoredAwardId).ValueGeneratedNever();
            });

            modelBuilder.Entity<State>(entity =>
            {
                entity.Property(e => e.StateId).ValueGeneratedNever();
            });

            modelBuilder.Entity<StateCounty>(entity =>
            {
                entity.Property(e => e.StateCountyId).ValueGeneratedNever();
            });

            modelBuilder.Entity<Submode>(entity =>
            {
                entity.Property(e => e.SubmodeId).ValueGeneratedNever();
            });

            modelBuilder.Entity<Weblink>(entity =>
            {
                entity.Property(e => e.WeblinkId).ValueGeneratedNever();
            });

            modelBuilder.HasSequence<int>("jcc_full_stats_jcc_full_stats_id_seq");

            modelBuilder.HasSequence<int>("jcc_jcc_id_seq");

            modelBuilder.HasSequence<int>("jcc_prefecture_stats_jcc_prefecture_stats_id_seq");

            modelBuilder.HasSequence<int>("pas1_pas1_id_seq");

            modelBuilder.HasSequence<int>("pas100_pas100_id_seq");

            modelBuilder.HasSequence<int>("pas104_pas104_id_seq");

            modelBuilder.HasSequence<int>("pas108_pas108_id_seq");

            modelBuilder.HasSequence<int>("pas110_pas110_id_seq");

            modelBuilder.HasSequence<int>("pas112_pas112_id_seq");

            modelBuilder.HasSequence<int>("pas126_pas126_id_seq");

            modelBuilder.HasSequence<int>("pas130_pas130_id_seq");

            modelBuilder.HasSequence<int>("pas132_pas132_id_seq");

            modelBuilder.HasSequence<int>("pas137_pas137_id_seq");

            modelBuilder.HasSequence<int>("pas138_pas138_id_seq");

            modelBuilder.HasSequence<int>("pas144_pas144_id_seq");

            modelBuilder.HasSequence<int>("pas147_pas147_id_seq");

            modelBuilder.HasSequence<int>("pas148_pas148_id_seq");

            modelBuilder.HasSequence<int>("pas149_pas149_id_seq");

            modelBuilder.HasSequence<int>("pas15_before_pas15_before_id_seq");

            modelBuilder.HasSequence<int>("pas15_current_pas15_current_id_seq");

            modelBuilder.HasSequence<int>("pas15_pas15_id_seq");

            modelBuilder.HasSequence<int>("pas15_stats_pas15_stats_id_seq");

            modelBuilder.HasSequence<int>("pas150_pas150_id_seq");

            modelBuilder.HasSequence<int>("pas151_pas151_id_seq");

            modelBuilder.HasSequence<int>("pas153_pas153_id_seq");

            modelBuilder.HasSequence<int>("pas163_pas163_id_seq");

            modelBuilder.HasSequence<int>("pas170_pas170_id_seq");

            modelBuilder.HasSequence<int>("pas177_pas177_id_seq");

            modelBuilder.HasSequence<int>("pas179_pas179_id_seq");

            modelBuilder.HasSequence<int>("pas192_pas192_id_seq");

            modelBuilder.HasSequence<int>("pas206_pas206_id_seq");

            modelBuilder.HasSequence<int>("pas206_region_pas206_region_id_seq");

            modelBuilder.HasSequence<int>("pas206_stats_pas206_stats_id_seq");

            modelBuilder.HasSequence<int>("pas209_pas209_id_seq");

            modelBuilder.HasSequence<int>("pas21_pas21_id_seq");

            modelBuilder.HasSequence<int>("pas212_pas212_id_seq");

            modelBuilder.HasSequence<int>("pas212_region_pas212_region_id_seq");

            modelBuilder.HasSequence<int>("pas212_stats_pas212_stats_id_seq");

            modelBuilder.HasSequence<int>("pas214_pas214_id_seq");

            modelBuilder.HasSequence<int>("pas221_pas221_id_seq");

            modelBuilder.HasSequence<int>("pas224_pas224_id_seq");

            modelBuilder.HasSequence<int>("pas224_region_pas224_region_id_seq");

            modelBuilder.HasSequence<int>("pas224_stats_pas224_stats_id_seq");

            modelBuilder.HasSequence<int>("pas225_pas225_id_seq");

            modelBuilder.HasSequence<int>("pas225_region_pas225_region_id_seq");

            modelBuilder.HasSequence<int>("pas225_stats_pas225_stats_id_seq");

            modelBuilder.HasSequence<int>("pas227_pas227_id_seq");

            modelBuilder.HasSequence<int>("pas230_pas230_id_seq");

            modelBuilder.HasSequence<int>("pas239_pas239_id_seq");

            modelBuilder.HasSequence<int>("pas245_pas245_id_seq");

            modelBuilder.HasSequence<int>("pas248_pas248_id_seq");

            modelBuilder.HasSequence<int>("pas248_region_pas248_region_id_seq");

            modelBuilder.HasSequence<int>("pas248_stats_pas248_stats_id_seq");

            modelBuilder.HasSequence<int>("pas256_pas256_id_seq");

            modelBuilder.HasSequence<int>("pas263_pas263_id_seq");

            modelBuilder.HasSequence<int>("pas269_pas269_id_seq");

            modelBuilder.HasSequence<int>("pas27_pas27_id_seq");

            modelBuilder.HasSequence<int>("pas272_pas272_id_seq");

            modelBuilder.HasSequence<int>("pas275_pas275_id_seq");

            modelBuilder.HasSequence<int>("pas281_pas281_id_seq");

            modelBuilder.HasSequence<int>("pas284_pas284_id_seq");

            modelBuilder.HasSequence<int>("pas287_pas287_id_seq");

            modelBuilder.HasSequence<int>("pas288_pas288_id_seq");

            modelBuilder.HasSequence<int>("pas29_pas29_id_seq");

            modelBuilder.HasSequence<int>("pas291_pas291_id_seq");

            modelBuilder.HasSequence<int>("pas318_pas318_id_seq");

            modelBuilder.HasSequence<int>("pas32_pas32_id_seq");

            modelBuilder.HasSequence<int>("pas327_pas327_id_seq");

            modelBuilder.HasSequence<int>("pas339_pas339_id_seq");

            modelBuilder.HasSequence<int>("pas339_region_pas339_region_id_seq");

            modelBuilder.HasSequence<int>("pas339_stats_pas339_stats_id_seq");

            modelBuilder.HasSequence<int>("pas375_pas375_id_seq");

            modelBuilder.HasSequence<int>("pas375_region_pas375_region_id_seq");

            modelBuilder.HasSequence<int>("pas375_stats_pas375_stats_id_seq");

            modelBuilder.HasSequence<int>("pas386_pas386_id_seq");

            modelBuilder.HasSequence<int>("pas387_pas387_id_seq");

            modelBuilder.HasSequence<int>("pas497_pas497_id_seq");

            modelBuilder.HasSequence<int>("pas5_pas5_id_seq");

            modelBuilder.HasSequence<int>("pas50_pas50_id_seq");

            modelBuilder.HasSequence<int>("pas503_pas503_id_seq");

            modelBuilder.HasSequence<int>("pas503_region_pas503_region_id_seq");

            modelBuilder.HasSequence<int>("pas503_stats_pas503_stats_id_seq");

            modelBuilder.HasSequence<int>("pas504_pas504_id_seq");

            modelBuilder.HasSequence<int>("pas504_region_pas504_region_id_seq");

            modelBuilder.HasSequence<int>("pas504_stats_pas504_stats_id_seq");

            modelBuilder.HasSequence<int>("pas52_pas52_id_seq");

            modelBuilder.HasSequence<int>("pas54_pas54_id_seq");

            modelBuilder.HasSequence<int>("pas6_pas6_id_seq");

            modelBuilder.HasSequence<int>("pas61_pas61_id_seq");

            modelBuilder.HasSequence<int>("pas70_pas70_id_seq");

            modelBuilder.HasSequence<int>("pas74_pas74_id_seq");

            modelBuilder.HasSequence<int>("pas86_pas86_id_seq");

            modelBuilder.HasSequence<int>("rdxc_district_list_rdxc_district_list_id_seq");

            modelBuilder.HasSequence<int>("rdxc_oblast_count_rdxc_oblast_count_id_seq");

            modelBuilder.HasSequence<int>("rdxc_oblast_stats_rdxc_oblast_stats_id_seq");

            modelBuilder.HasSequence<int>("sas110_sas110_id_seq");

            modelBuilder.HasSequence<int>("sas126_sas126_id_seq");

            modelBuilder.HasSequence<int>("sas137_sas137_id_seq");

            modelBuilder.HasSequence<int>("sas15_sas15_id_seq");

            modelBuilder.HasSequence<int>("sas151_sas151_id_seq");

            modelBuilder.HasSequence<int>("sas170_sas170_id_seq");

            modelBuilder.HasSequence<int>("sas177_sas177_id_seq");

            modelBuilder.HasSequence<int>("sas192_sas192_id_seq");

            modelBuilder.HasSequence<int>("sas288_sas288_id_seq");

            modelBuilder.HasSequence<int>("sas291_sas291_id_seq");

            modelBuilder.HasSequence<int>("sas339_sas339_id_seq");

            modelBuilder.HasSequence<int>("sas54_sas54_id_seq");

            modelBuilder.HasSequence<int>("sas6_sas6_id_seq");

            modelBuilder.HasSequence<int>("sas61_sas61_id_seq");
        }
    }
}
