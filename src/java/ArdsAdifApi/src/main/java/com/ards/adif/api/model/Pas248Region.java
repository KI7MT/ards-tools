package com.ards.adif.api.model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the pas_248_region database table.
 * 
 */
@Entity
@Table(name="pas_248_region")
@NamedQuery(name="Pas248Region.findAll", query="SELECT p FROM Pas248Region p")
public class Pas248Region implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(unique=true, nullable=false)
	private Integer id;

	@Column(nullable=false, length=60)
	private String region;

	//bi-directional many-to-one association to Dxcc
	@ManyToOne
	@JoinColumn(name="dxcc_id", nullable=false)
	private Dxcc dxcc;

	//bi-directional many-to-one association to Pas248Subdivision
	@OneToMany(mappedBy="pas248Region")
	private List<Pas248Subdivision> pas248Subdivisions;

	public Pas248Region() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getRegion() {
		return this.region;
	}

	public void setRegion(String region) {
		this.region = region;
	}

	public Dxcc getDxcc() {
		return this.dxcc;
	}

	public void setDxcc(Dxcc dxcc) {
		this.dxcc = dxcc;
	}

	public List<Pas248Subdivision> getPas248Subdivisions() {
		return this.pas248Subdivisions;
	}

	public void setPas248Subdivisions(List<Pas248Subdivision> pas248Subdivisions) {
		this.pas248Subdivisions = pas248Subdivisions;
	}

	public Pas248Subdivision addPas248Subdivision(Pas248Subdivision pas248Subdivision) {
		getPas248Subdivisions().add(pas248Subdivision);
		pas248Subdivision.setPas248Region(this);

		return pas248Subdivision;
	}

	public Pas248Subdivision removePas248Subdivision(Pas248Subdivision pas248Subdivision) {
		getPas248Subdivisions().remove(pas248Subdivision);
		pas248Subdivision.setPas248Region(null);

		return pas248Subdivision;
	}

}