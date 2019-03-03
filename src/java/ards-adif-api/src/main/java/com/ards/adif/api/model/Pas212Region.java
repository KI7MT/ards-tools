package com.ards.adif.api.model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the pas_212_region database table.
 * 
 */
@Entity
@Table(name="pas_212_region")
@NamedQuery(name="Pas212Region.findAll", query="SELECT p FROM Pas212Region p")
public class Pas212Region implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(unique=true, nullable=false)
	private Integer id;

	@Column(nullable=false, length=70)
	private String region;

	//bi-directional many-to-one association to Dxcc
	@ManyToOne
	@JoinColumn(name="dxcc_id", nullable=false)
	private Dxcc dxcc;

	//bi-directional many-to-one association to Pas212Subdivision
	@OneToMany(mappedBy="pas212Region")
	private List<Pas212Subdivision> pas212Subdivisions;

	public Pas212Region() {
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

	public List<Pas212Subdivision> getPas212Subdivisions() {
		return this.pas212Subdivisions;
	}

	public void setPas212Subdivisions(List<Pas212Subdivision> pas212Subdivisions) {
		this.pas212Subdivisions = pas212Subdivisions;
	}

	public Pas212Subdivision addPas212Subdivision(Pas212Subdivision pas212Subdivision) {
		getPas212Subdivisions().add(pas212Subdivision);
		pas212Subdivision.setPas212Region(this);

		return pas212Subdivision;
	}

	public Pas212Subdivision removePas212Subdivision(Pas212Subdivision pas212Subdivision) {
		getPas212Subdivisions().remove(pas212Subdivision);
		pas212Subdivision.setPas212Region(null);

		return pas212Subdivision;
	}

}