package com.ards.jpa.model;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the region_applicability database table.
 * 
 */
@Entity
@Table(name="region_applicability")
@NamedQuery(name="RegionApplicability.findAll", query="SELECT r FROM RegionApplicability r")
public class RegionApplicability implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(unique=true, nullable=false)
	private Integer id;

	@Column(name="region_id", nullable=false)
	private Integer regionId;

	@Column(name="weblink_id", nullable=false)
	private Integer weblinkId;

	public RegionApplicability() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getRegionId() {
		return this.regionId;
	}

	public void setRegionId(Integer regionId) {
		this.regionId = regionId;
	}

	public Integer getWeblinkId() {
		return this.weblinkId;
	}

	public void setWeblinkId(Integer weblinkId) {
		this.weblinkId = weblinkId;
	}

}