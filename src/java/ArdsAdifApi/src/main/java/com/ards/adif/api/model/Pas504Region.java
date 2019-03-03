package com.ards.adif.api.model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the pas_504_region database table.
 * 
 */
@Entity
@Table(name="pas_504_region")
@NamedQuery(name="Pas504Region.findAll", query="SELECT p FROM Pas504Region p")
public class Pas504Region implements Serializable {
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

	//bi-directional many-to-one association to Pas504Subdivision
	@OneToMany(mappedBy="pas504Region")
	private List<Pas504Subdivision> pas504Subdivisions;

	public Pas504Region() {
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

	public List<Pas504Subdivision> getPas504Subdivisions() {
		return this.pas504Subdivisions;
	}

	public void setPas504Subdivisions(List<Pas504Subdivision> pas504Subdivisions) {
		this.pas504Subdivisions = pas504Subdivisions;
	}

	public Pas504Subdivision addPas504Subdivision(Pas504Subdivision pas504Subdivision) {
		getPas504Subdivisions().add(pas504Subdivision);
		pas504Subdivision.setPas504Region(this);

		return pas504Subdivision;
	}

	public Pas504Subdivision removePas504Subdivision(Pas504Subdivision pas504Subdivision) {
		getPas504Subdivisions().remove(pas504Subdivision);
		pas504Subdivision.setPas504Region(null);

		return pas504Subdivision;
	}

}