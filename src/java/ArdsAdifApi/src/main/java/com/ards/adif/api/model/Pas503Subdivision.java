package com.ards.adif.api.model;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the pas_503_subdivision database table.
 * 
 */
@Entity
@Table(name="pas_503_subdivision")
@NamedQuery(name="Pas503Subdivision.findAll", query="SELECT p FROM Pas503Subdivision p")
public class Pas503Subdivision implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(unique=true, nullable=false)
	private Integer id;

	@Column(nullable=false, length=3)
	private String code;

	@Column(nullable=false, length=60)
	private String subdivision;

	//bi-directional many-to-one association to Pas503Region
	@ManyToOne
	@JoinColumn(name="pas_503_region_id", nullable=false)
	private Pas503Region pas503Region;

	public Pas503Subdivision() {
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

	public String getSubdivision() {
		return this.subdivision;
	}

	public void setSubdivision(String subdivision) {
		this.subdivision = subdivision;
	}

	public Pas503Region getPas503Region() {
		return this.pas503Region;
	}

	public void setPas503Region(Pas503Region pas503Region) {
		this.pas503Region = pas503Region;
	}

}