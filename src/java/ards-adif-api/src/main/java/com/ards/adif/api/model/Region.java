package com.ards.adif.api.model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the region database table.
 * 
 */
@Entity
@Table(name="region")
@NamedQuery(name="Region.findAll", query="SELECT r FROM Region r")
public class Region implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(unique=true, nullable=false)
	private Integer id;

	@Column(length=4)
	private String code;

	@Column(length=10)
	private String prefix;

	@Column(length=120)
	private String region;

	//bi-directional many-to-one association to Dxcc
	@ManyToOne
	@JoinColumn(name="dxcc_id")
	private Dxcc dxcc;

	//bi-directional many-to-one association to RegionApplicability
	@OneToMany(mappedBy="region")
	private List<RegionApplicability> regionApplicabilities;

	public Region() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getCode() {
		return this.code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getPrefix() {
		return this.prefix;
	}

	public void setPrefix(String prefix) {
		this.prefix = prefix;
	}

	public String getRegion() {
		return this.region;
	}

	public void setRegion(String region) {
		this.region = region;
	}

	public Dxcc getDxcc() {
		return this.dxcc;
	}

	public void setDxcc(Dxcc dxcc) {
		this.dxcc = dxcc;
	}

	public List<RegionApplicability> getRegionApplicabilities() {
		return this.regionApplicabilities;
	}

	public void setRegionApplicabilities(List<RegionApplicability> regionApplicabilities) {
		this.regionApplicabilities = regionApplicabilities;
	}

	public RegionApplicability addRegionApplicability(RegionApplicability regionApplicability) {
		getRegionApplicabilities().add(regionApplicability);
		regionApplicability.setRegion(this);

		return regionApplicability;
	}

	public RegionApplicability removeRegionApplicability(RegionApplicability regionApplicability) {
		getRegionApplicabilities().remove(regionApplicability);
		regionApplicability.setRegion(null);

		return regionApplicability;
	}

}