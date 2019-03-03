package com.ards.adif.api.model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the pas_375_region database table.
 * 
 */
@Entity
@Table(name="pas_375_region")
@NamedQuery(name="Pas375Region.findAll", query="SELECT p FROM Pas375Region p")
public class Pas375Region implements Serializable {
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

	//bi-directional many-to-one association to Pas375Subdivision
	@OneToMany(mappedBy="pas375Region")
	private List<Pas375Subdivision> pas375Subdivisions;

	public Pas375Region() {
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

	public List<Pas375Subdivision> getPas375Subdivisions() {
		return this.pas375Subdivisions;
	}

	public void setPas375Subdivisions(List<Pas375Subdivision> pas375Subdivisions) {
		this.pas375Subdivisions = pas375Subdivisions;
	}

	public Pas375Subdivision addPas375Subdivision(Pas375Subdivision pas375Subdivision) {
		getPas375Subdivisions().add(pas375Subdivision);
		pas375Subdivision.setPas375Region(this);

		return pas375Subdivision;
	}

	public Pas375Subdivision removePas375Subdivision(Pas375Subdivision pas375Subdivision) {
		getPas375Subdivisions().remove(pas375Subdivision);
		pas375Subdivision.setPas375Region(null);

		return pas375Subdivision;
	}

}