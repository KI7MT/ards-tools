package com.ards.adif.api.model;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the pas_225_subdivision database table.
 * 
 */
@Entity
@Table(name="pas_225_subdivision")
@NamedQuery(name="Pas225Subdivision.findAll", query="SELECT p FROM Pas225Subdivision p")
public class Pas225Subdivision implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(unique=true, nullable=false)
	private Integer id;

	@Column(nullable=false, length=2)
	private String code;

	@Column(name="import_only", nullable=false)
	private Boolean importOnly;

	@Column(nullable=false, length=60)
	private String subdivision;

	//bi-directional many-to-one association to Pas225Region
	@ManyToOne
	@JoinColumn(name="pas_225_region_id", nullable=false)
	private Pas225Region pas225Region;

	public Pas225Subdivision() {
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

	public Boolean getImportOnly() {
		return this.importOnly;
	}

	public void setImportOnly(Boolean importOnly) {
		this.importOnly = importOnly;
	}

	public String getSubdivision() {
		return this.subdivision;
	}

	public void setSubdivision(String subdivision) {
		this.subdivision = subdivision;
	}

	public Pas225Region getPas225Region() {
		return this.pas225Region;
	}

	public void setPas225Region(Pas225Region pas225Region) {
		this.pas225Region = pas225Region;
	}

}