package com.ards.adif.api.model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the pas_503_region database table.
 * 
 */
@Entity
@Table(name="pas_503_region")
@NamedQuery(name="Pas503Region.findAll", query="SELECT p FROM Pas503Region p")
public class Pas503Region implements Serializable {
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

	//bi-directional many-to-one association to Pas503Subdivision
	@OneToMany(mappedBy="pas503Region")
	private List<Pas503Subdivision> pas503Subdivisions;

	public Pas503Region() {
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

	public List<Pas503Subdivision> getPas503Subdivisions() {
		return this.pas503Subdivisions;
	}

	public void setPas503Subdivisions(List<Pas503Subdivision> pas503Subdivisions) {
		this.pas503Subdivisions = pas503Subdivisions;
	}

	public Pas503Subdivision addPas503Subdivision(Pas503Subdivision pas503Subdivision) {
		getPas503Subdivisions().add(pas503Subdivision);
		pas503Subdivision.setPas503Region(this);

		return pas503Subdivision;
	}

	public Pas503Subdivision removePas503Subdivision(Pas503Subdivision pas503Subdivision) {
		getPas503Subdivisions().remove(pas503Subdivision);
		pas503Subdivision.setPas503Region(null);

		return pas503Subdivision;
	}

}