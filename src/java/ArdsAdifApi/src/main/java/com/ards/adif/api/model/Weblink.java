package com.ards.adif.api.model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the weblink database table.
 * 
 */
@Entity
@Table(name="weblink")
@NamedQuery(name="Weblink.findAll", query="SELECT w FROM Weblink w")
public class Weblink implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(unique=true, nullable=false)
	private Integer id;

	@Column(name="display_text", nullable=false, length=120)
	private String displayText;

	@Column(nullable=false, length=255)
	private String url;

	//bi-directional many-to-one association to Contest
	@OneToMany(mappedBy="weblink")
	private List<Contest> contests;

	//bi-directional many-to-one association to CqZone
	@OneToMany(mappedBy="weblink")
	private List<CqZone> cqZones;

	//bi-directional many-to-one association to IaruRegion
	@OneToMany(mappedBy="weblink")
	private List<IaruRegion> iaruRegions;

	//bi-directional many-to-one association to ItuZone
	@OneToMany(mappedBy="weblink")
	private List<ItuZone> ituZones;

	//bi-directional many-to-one association to ModeDescription
	@OneToMany(mappedBy="weblink")
	private List<ModeDescription> modeDescriptions;

	//bi-directional many-to-one association to RegionApplicability
	@OneToMany(mappedBy="weblink")
	private List<RegionApplicability> regionApplicabilities;

	//bi-directional many-to-one association to SourceList
	@OneToMany(mappedBy="weblink")
	private List<SourceList> sourceLists;

	//bi-directional many-to-one association to SponsoredAward
	@OneToMany(mappedBy="weblink")
	private List<SponsoredAward> sponsoredAwards;

	public Weblink() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getDisplayText() {
		return this.displayText;
	}

	public void setDisplayText(String displayText) {
		this.displayText = displayText;
	}

	public String getUrl() {
		return this.url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public List<Contest> getContests() {
		return this.contests;
	}

	public void setContests(List<Contest> contests) {
		this.contests = contests;
	}

	public Contest addContest(Contest contest) {
		getContests().add(contest);
		contest.setWeblink(this);

		return contest;
	}

	public Contest removeContest(Contest contest) {
		getContests().remove(contest);
		contest.setWeblink(null);

		return contest;
	}

	public List<CqZone> getCqZones() {
		return this.cqZones;
	}

	public void setCqZones(List<CqZone> cqZones) {
		this.cqZones = cqZones;
	}

	public CqZone addCqZone(CqZone cqZone) {
		getCqZones().add(cqZone);
		cqZone.setWeblink(this);

		return cqZone;
	}

	public CqZone removeCqZone(CqZone cqZone) {
		getCqZones().remove(cqZone);
		cqZone.setWeblink(null);

		return cqZone;
	}

	public List<IaruRegion> getIaruRegions() {
		return this.iaruRegions;
	}

	public void setIaruRegions(List<IaruRegion> iaruRegions) {
		this.iaruRegions = iaruRegions;
	}

	public IaruRegion addIaruRegion(IaruRegion iaruRegion) {
		getIaruRegions().add(iaruRegion);
		iaruRegion.setWeblink(this);

		return iaruRegion;
	}

	public IaruRegion removeIaruRegion(IaruRegion iaruRegion) {
		getIaruRegions().remove(iaruRegion);
		iaruRegion.setWeblink(null);

		return iaruRegion;
	}

	public List<ItuZone> getItuZones() {
		return this.ituZones;
	}

	public void setItuZones(List<ItuZone> ituZones) {
		this.ituZones = ituZones;
	}

	public ItuZone addItuZone(ItuZone ituZone) {
		getItuZones().add(ituZone);
		ituZone.setWeblink(this);

		return ituZone;
	}

	public ItuZone removeItuZone(ItuZone ituZone) {
		getItuZones().remove(ituZone);
		ituZone.setWeblink(null);

		return ituZone;
	}

	public List<ModeDescription> getModeDescriptions() {
		return this.modeDescriptions;
	}

	public void setModeDescriptions(List<ModeDescription> modeDescriptions) {
		this.modeDescriptions = modeDescriptions;
	}

	public ModeDescription addModeDescription(ModeDescription modeDescription) {
		getModeDescriptions().add(modeDescription);
		modeDescription.setWeblink(this);

		return modeDescription;
	}

	public ModeDescription removeModeDescription(ModeDescription modeDescription) {
		getModeDescriptions().remove(modeDescription);
		modeDescription.setWeblink(null);

		return modeDescription;
	}

	public List<RegionApplicability> getRegionApplicabilities() {
		return this.regionApplicabilities;
	}

	public void setRegionApplicabilities(List<RegionApplicability> regionApplicabilities) {
		this.regionApplicabilities = regionApplicabilities;
	}

	public RegionApplicability addRegionApplicability(RegionApplicability regionApplicability) {
		getRegionApplicabilities().add(regionApplicability);
		regionApplicability.setWeblink(this);

		return regionApplicability;
	}

	public RegionApplicability removeRegionApplicability(RegionApplicability regionApplicability) {
		getRegionApplicabilities().remove(regionApplicability);
		regionApplicability.setWeblink(null);

		return regionApplicability;
	}

	public List<SourceList> getSourceLists() {
		return this.sourceLists;
	}

	public void setSourceLists(List<SourceList> sourceLists) {
		this.sourceLists = sourceLists;
	}

	public SourceList addSourceList(SourceList sourceList) {
		getSourceLists().add(sourceList);
		sourceList.setWeblink(this);

		return sourceList;
	}

	public SourceList removeSourceList(SourceList sourceList) {
		getSourceLists().remove(sourceList);
		sourceList.setWeblink(null);

		return sourceList;
	}

	public List<SponsoredAward> getSponsoredAwards() {
		return this.sponsoredAwards;
	}

	public void setSponsoredAwards(List<SponsoredAward> sponsoredAwards) {
		this.sponsoredAwards = sponsoredAwards;
	}

	public SponsoredAward addSponsoredAward(SponsoredAward sponsoredAward) {
		getSponsoredAwards().add(sponsoredAward);
		sponsoredAward.setWeblink(this);

		return sponsoredAward;
	}

	public SponsoredAward removeSponsoredAward(SponsoredAward sponsoredAward) {
		getSponsoredAwards().remove(sponsoredAward);
		sponsoredAward.setWeblink(null);

		return sponsoredAward;
	}

}