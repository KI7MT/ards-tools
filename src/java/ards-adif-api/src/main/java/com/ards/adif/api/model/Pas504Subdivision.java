package com.ards.adif.api.model;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the pas_504_subdivision database table.
 * 
 */
@Entity
@Table(name="pas_504_subdivision")
@NamedQuery(name="Pas504Subdivision.findAll", query="SELECT p FROM Pas504Subdivision p")
public class Pas504Subdivision implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(unique=true, nullable=false)
	private Integer id;

	@Column(nullable=false, length=3)
	private String code;

	@Column(nullable=false, length=20)
	private String subdivision;

	//bi-directional many-to-one association to Pas504Region
	@ManyToOne
	@JoinColumn(name="pas_504_region_id", nullable=false)
	private Pas504Region pas504Region;

	public Pas504Subdivision() {
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

	public Pas504Region getPas504Region() {
		return this.pas504Region;
	}

	public void setPas504Region(Pas504Region pas504Region) {
		this.pas504Region = pas504Region;
	}

}