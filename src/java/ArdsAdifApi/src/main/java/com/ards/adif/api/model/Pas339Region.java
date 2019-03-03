package com.ards.adif.api.model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the pas_339_region database table.
 * 
 */
@Entity
@Table(name="pas_339_region")
@NamedQuery(name="Pas339Region.findAll", query="SELECT p FROM Pas339Region p")
public class Pas339Region implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(unique=true, nullable=false)
	private Integer id;

	@Column(nullable=false, length=20)
	private String region;

	//bi-directional many-to-one association to Dxcc
	@ManyToOne
	@JoinColumn(name="dxcc_id", nullable=false)
	private Dxcc dxcc;

	//bi-directional many-to-one association to Pas339Subdivision
	@OneToMany(mappedBy="pas339Region")
	private List<Pas339Subdivision> pas339Subdivisions;

	public Pas339Region() {
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

	public List<Pas339Subdivision> getPas339Subdivisions() {
		return this.pas339Subdivisions;
	}

	public void setPas339Subdivisions(List<Pas339Subdivision> pas339Subdivisions) {
		this.pas339Subdivisions = pas339Subdivisions;
	}

	public Pas339Subdivision addPas339Subdivision(Pas339Subdivision pas339Subdivision) {
		getPas339Subdivisions().add(pas339Subdivision);
		pas339Subdivision.setPas339Region(this);

		return pas339Subdivision;
	}

	public Pas339Subdivision removePas339Subdivision(Pas339Subdivision pas339Subdivision) {
		getPas339Subdivisions().remove(pas339Subdivision);
		pas339Subdivision.setPas339Region(null);

		return pas339Subdivision;
	}

}