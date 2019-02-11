package com.ards.jpa.model;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the itu_zone database table.
 * 
 */
@Entity
@Table(name="itu_zone")
@NamedQuery(name="ItuZone.findAll", query="SELECT i FROM ItuZone i")
public class ItuZone implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(unique=true, nullable=false)
	private Integer id;

	@Column(name="long_description", length=255)
	private String longDescription;

	@Column(nullable=false)
	private Integer number;

	@Column(name="short_description", length=120)
	private String shortDescription;

	@Column(name="weblink_id")
	private Integer weblinkId;

	public ItuZone() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getLongDescription() {
		return this.longDescription;
	}

	public void setLongDescription(String longDescription) {
		this.longDescription = longDescription;
	}

	public Integer getNumber() {
		return this.number;
	}

	public void setNumber(Integer number) {
		this.number = number;
	}

	public String getShortDescription() {
		return this.shortDescription;
	}

	public void setShortDescription(String shortDescription) {
		this.shortDescription = shortDescription;
	}

	public Integer getWeblinkId() {
		return this.weblinkId;
	}

	public void setWeblinkId(Integer weblinkId) {
		this.weblinkId = weblinkId;
	}

}