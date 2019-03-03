package com.ards.adif.api.model;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the pas_248_subdivision database table.
 * 
 */
@Entity
@Table(name="pas_248_subdivision")
@NamedQuery(name="Pas248Subdivision.findAll", query="SELECT p FROM Pas248Subdivision p")
public class Pas248Subdivision implements Serializable {
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

	//bi-directional many-to-one association to Pas248Region
	@ManyToOne
	@JoinColumn(name="pas_248_region_id", nullable=false)
	private Pas248Region pas248Region;

	public Pas248Subdivision() {
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

	public Pas248Region getPas248Region() {
		return this.pas248Region;
	}

	public void setPas248Region(Pas248Region pas248Region) {
		this.pas248Region = pas248Region;
	}

}