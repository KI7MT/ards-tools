package com.ards.adif.api.model;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the iaru_region_member database table.
 * 
 */
@Entity
@Table(name="iaru_region_member")
@NamedQuery(name="IaruRegionMember.findAll", query="SELECT i FROM IaruRegionMember i")
public class IaruRegionMember implements Serializable {
	
	private static final long serialVersionUID = 1L;

	@Id
	@Column(unique=true, nullable=false)
	private Integer id;

	@Column(name="country_territory", length=60)
	private String countryTerritory;

	@Column(length=120)
	private String name;

	//bi-directional many-to-one association to IaruRegion
	@ManyToOne
	@JoinColumn(name="iaru_region_id", nullable=false)
	private IaruRegion iaruRegion;

	public IaruRegionMember() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getCountryTerritory() {
		return this.countryTerritory;
	}

	public void setCountryTerritory(String countryTerritory) {
		this.countryTerritory = countryTerritory;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public IaruRegion getIaruRegion() {
		return this.iaruRegion;
	}

	public void setIaruRegion(IaruRegion iaruRegion) {
		this.iaruRegion = iaruRegion;
	}

}