package com.ards.adif.api.model;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the pas_212_subdivision database table.
 * 
 */
@Entity
@Table(name="pas_212_subdivision")
@NamedQuery(name="Pas212Subdivision.findAll", query="SELECT p FROM Pas212Subdivision p")
public class Pas212Subdivision implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(unique=true, nullable=false)
	private Integer id;

	@Column(nullable=false, length=2)
	private String code;

	@Column(nullable=false, length=70)
	private String subdivision;

	//bi-directional many-to-one association to Pas212Region
	@ManyToOne
	@JoinColumn(name="pas_212_region_id", nullable=false)
	private Pas212Region pas212Region;

	public Pas212Subdivision() {
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

	public Pas212Region getPas212Region() {
		return this.pas212Region;
	}

	public void setPas212Region(Pas212Region pas212Region) {
		this.pas212Region = pas212Region;
	}

}