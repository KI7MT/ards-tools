package com.ards.adif.api.model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the pas_225_region database table.
 * 
 */
@Entity
@Table(name="pas_225_region")
@NamedQuery(name="Pas225Region.findAll", query="SELECT p FROM Pas225Region p")
public class Pas225Region implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(unique=true, nullable=false)
	private Integer id;

	@Column(nullable=false, length=40)
	private String region;

	//bi-directional many-to-one association to Dxcc
	@ManyToOne
	@JoinColumn(name="dxcc_id", nullable=false)
	private Dxcc dxcc;

	//bi-directional many-to-one association to Pas225Subdivision
	@OneToMany(mappedBy="pas225Region")
	private List<Pas225Subdivision> pas225Subdivisions;

	public Pas225Region() {
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

	public List<Pas225Subdivision> getPas225Subdivisions() {
		return this.pas225Subdivisions;
	}

	public void setPas225Subdivisions(List<Pas225Subdivision> pas225Subdivisions) {
		this.pas225Subdivisions = pas225Subdivisions;
	}

	public Pas225Subdivision addPas225Subdivision(Pas225Subdivision pas225Subdivision) {
		getPas225Subdivisions().add(pas225Subdivision);
		pas225Subdivision.setPas225Region(this);

		return pas225Subdivision;
	}

	public Pas225Subdivision removePas225Subdivision(Pas225Subdivision pas225Subdivision) {
		getPas225Subdivisions().remove(pas225Subdivision);
		pas225Subdivision.setPas225Region(null);

		return pas225Subdivision;
	}

}