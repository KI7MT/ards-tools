package com.ards.adif.api.model;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the pas_224_subdivision database table.
 * 
 */
@Entity
@Table(name="pas_224_subdivision")
@NamedQuery(name="Pas224Subdivision.findAll", query="SELECT p FROM Pas224Subdivision p")
public class Pas224Subdivision implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(unique=true, nullable=false)
	private Integer id;

	@Column(nullable=false, length=3)
	private String code;

	@Column(nullable=false, length=70)
	private String subdivision;

	//bi-directional many-to-one association to Pas224Region
	@ManyToOne
	@JoinColumn(name="pas_224_region_id", nullable=false)
	private Pas224Region pas224Region;

	public Pas224Subdivision() {
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

	public Pas224Region getPas224Region() {
		return this.pas224Region;
	}

	public void setPas224Region(Pas224Region pas224Region) {
		this.pas224Region = pas224Region;
	}

}