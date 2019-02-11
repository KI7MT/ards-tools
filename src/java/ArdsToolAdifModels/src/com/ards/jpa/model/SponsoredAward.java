package com.ards.jpa.model;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the sponsored_award database table.
 * 
 */
@Entity
@Table(name="sponsored_award")
@NamedQuery(name="SponsoredAward.findAll", query="SELECT s FROM SponsoredAward s")
public class SponsoredAward implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(unique=true, nullable=false)
	private Integer id;

	@Column(nullable=false, length=20)
	private String sponsor;

	@Column(name="weblink_id", nullable=false)
	private Integer weblinkId;

	public SponsoredAward() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getSponsor() {
		return this.sponsor;
	}

	public void setSponsor(String sponsor) {
		this.sponsor = sponsor;
	}

	public Integer getWeblinkId() {
		return this.weblinkId;
	}

	public void setWeblinkId(Integer weblinkId) {
		this.weblinkId = weblinkId;
	}

}