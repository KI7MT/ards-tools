package com.ards.jpa.model;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the cq_zone database table.
 * 
 */
@Entity
@Table(name="cq_zone")
@NamedQuery(name="CqZone.findAll", query="SELECT c FROM CqZone c")
public class CqZone implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(unique=true, nullable=false)
	private Integer id;

	@Column(name="long_description", nullable=false, length=2147483647)
	private String longDescription;

	@Column(name="short_description", nullable=false, length=60)
	private String shortDescription;

	@Column(name="weblink_id")
	private Integer weblinkId;

	public CqZone() {
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