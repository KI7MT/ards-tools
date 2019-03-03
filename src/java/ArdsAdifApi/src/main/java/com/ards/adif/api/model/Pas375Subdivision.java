package com.ards.adif.api.model;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the pas_375_subdivision database table.
 * 
 */
@Entity
@Table(name="pas_375_subdivision")
@NamedQuery(name="Pas375Subdivision.findAll", query="SELECT p FROM Pas375Subdivision p")
public class Pas375Subdivision implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(unique=true, nullable=false)
	private Integer id;

	@Column(nullable=false, length=3)
	private String code;

	@Column(nullable=false, length=60)
	private String subdivision;

	//bi-directional many-to-one association to Pas375Region
	@ManyToOne
	@JoinColumn(name="pas_375_region_id", nullable=false)
	private Pas375Region pas375Region;

	public Pas375Subdivision() {
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

	public Pas375Region getPas375Region() {
		return this.pas375Region;
	}

	public void setPas375Region(Pas375Region pas375Region) {
		this.pas375Region = pas375Region;
	}

}