package com.ards.adif.api.model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the iaru_region database table.
 * 
 */
@Entity
@Table(name="iaru_region")
@NamedQuery(name="IaruRegion.findAll", query="SELECT i FROM IaruRegion i")
public class IaruRegion implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(unique=true, nullable=false)
	private Integer id;

	@Column(length=20, nullable=false)
	private String region;
	
	@Column(length=120)
	private String description;

	//bi-directional many-to-one association to Weblink
	@ManyToOne
	@JoinColumn(name="weblink_id")
	private Weblink weblink;

	//bi-directional many-to-one association to IaruRegionMember
	@OneToMany(mappedBy="iaruRegion")
	private List<IaruRegionMember> iaruRegionMembers;

	public IaruRegion() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getRegion() {
		return this.region;
	}

	public void setRegion(String region) {
		this.region = region;
	}

	public Weblink getWeblink() {
		return this.weblink;
	}

	public void setWeblink(Weblink weblink) {
		this.weblink = weblink;
	}

	public List<IaruRegionMember> getIaruRegionMembers() {
		return this.iaruRegionMembers;
	}

	public void setIaruRegionMembers(List<IaruRegionMember> iaruRegionMembers) {
		this.iaruRegionMembers = iaruRegionMembers;
	}

	public IaruRegionMember addIaruRegionMember(IaruRegionMember iaruRegionMember) {
		getIaruRegionMembers().add(iaruRegionMember);
		iaruRegionMember.setIaruRegion(this);

		return iaruRegionMember;
	}

	public IaruRegionMember removeIaruRegionMember(IaruRegionMember iaruRegionMember) {
		getIaruRegionMembers().remove(iaruRegionMember);
		iaruRegionMember.setIaruRegion(null);

		return iaruRegionMember;
	}

}