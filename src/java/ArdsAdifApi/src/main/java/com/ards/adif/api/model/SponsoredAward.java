package com.ards.adif.api.model;

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
	@Column(unique=true, nullable=false)
	private Integer id;

	@Column(nullable=false, length=20)
	private String sponsor;

	//bi-directional many-to-one association to Weblink
	@ManyToOne
	@JoinColumn(name="weblink_id", nullable=false)
	private Weblink weblink;

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

	public Weblink getWeblink() {
		return this.weblink;
	}

	public void setWeblink(Weblink weblink) {
		this.weblink = weblink;
	}

}