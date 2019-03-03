package com.ards.adif.api.model;

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
	@Column(unique=true, nullable=false)
	private Integer id;

	//bi-directional many-to-one association to Region
	@ManyToOne
	@JoinColumn(name="region_id", nullable=false)
	private Region region;

	//bi-directional many-to-one association to Weblink
	@ManyToOne
	@JoinColumn(name="weblink_id", nullable=false)
	private Weblink weblink;

	public RegionApplicability() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Region getRegion() {
		return this.region;
	}

	public void setRegion(Region region) {
		this.region = region;
	}

	public Weblink getWeblink() {
		return this.weblink;
	}

	public void setWeblink(Weblink weblink) {
		this.weblink = weblink;
	}

}