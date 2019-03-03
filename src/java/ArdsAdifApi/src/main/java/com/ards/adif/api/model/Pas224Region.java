package com.ards.adif.api.model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the pas_224_region database table.
 * 
 */
@Entity
@Table(name="pas_224_region")
@NamedQuery(name="Pas224Region.findAll", query="SELECT p FROM Pas224Region p")
public class Pas224Region implements Serializable {
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

	//bi-directional many-to-one association to Pas224Subdivision
	@OneToMany(mappedBy="pas224Region")
	private List<Pas224Subdivision> pas224Subdivisions;

	public Pas224Region() {
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

	public List<Pas224Subdivision> getPas224Subdivisions() {
		return this.pas224Subdivisions;
	}

	public void setPas224Subdivisions(List<Pas224Subdivision> pas224Subdivisions) {
		this.pas224Subdivisions = pas224Subdivisions;
	}

	public Pas224Subdivision addPas224Subdivision(Pas224Subdivision pas224Subdivision) {
		getPas224Subdivisions().add(pas224Subdivision);
		pas224Subdivision.setPas224Region(this);

		return pas224Subdivision;
	}

	public Pas224Subdivision removePas224Subdivision(Pas224Subdivision pas224Subdivision) {
		getPas224Subdivisions().remove(pas224Subdivision);
		pas224Subdivision.setPas224Region(null);

		return pas224Subdivision;
	}

}