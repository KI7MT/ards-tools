package com.ards.adif.api.model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the pas_206_region database table.
 * 
 */
@Entity
@Table(name="pas_206_region")
@NamedQuery(name="Pas206Region.findAll", query="SELECT p FROM Pas206Region p")
public class Pas206Region implements Serializable {
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

	//bi-directional many-to-one association to Pas206Subdivision
	@OneToMany(mappedBy="pas206Region")
	private List<Pas206Subdivision> pas206Subdivisions;

	public Pas206Region() {
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

	public List<Pas206Subdivision> getPas206Subdivisions() {
		return this.pas206Subdivisions;
	}

	public void setPas206Subdivisions(List<Pas206Subdivision> pas206Subdivisions) {
		this.pas206Subdivisions = pas206Subdivisions;
	}

	public Pas206Subdivision addPas206Subdivision(Pas206Subdivision pas206Subdivision) {
		getPas206Subdivisions().add(pas206Subdivision);
		pas206Subdivision.setPas206Region(this);

		return pas206Subdivision;
	}

	public Pas206Subdivision removePas206Subdivision(Pas206Subdivision pas206Subdivision) {
		getPas206Subdivisions().remove(pas206Subdivision);
		pas206Subdivision.setPas206Region(null);

		return pas206Subdivision;
	}

}