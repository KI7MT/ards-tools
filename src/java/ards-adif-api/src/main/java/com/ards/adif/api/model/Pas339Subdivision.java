package com.ards.adif.api.model;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the pas_339_subdivision database table.
 * 
 */
@Entity
@Table(name="pas_339_subdivision")
@NamedQuery(name="Pas339Subdivision.findAll", query="SELECT p FROM Pas339Subdivision p")
public class Pas339Subdivision implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(unique=true, nullable=false)
	private Integer id;

	@Column(nullable=false, length=2)
	private String code;

	@Column(nullable=false, length=20)
	private String subdivision;

	//bi-directional many-to-one association to Pas339Region
	@ManyToOne
	@JoinColumn(name="pas_339_region_id", nullable=false)
	private Pas339Region pas339Region;

	public Pas339Subdivision() {
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

	public Pas339Region getPas339Region() {
		return this.pas339Region;
	}

	public void setPas339Region(Pas339Region pas339Region) {
		this.pas339Region = pas339Region;
	}

}