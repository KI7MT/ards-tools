package com.ards.adif.api.model;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the pas_126 database table.
 * 
 */
@Entity
@Table(name="pas_126")
@NamedQuery(name="Pas126.findAll", query="SELECT p FROM Pas126 p")
public class Pas126 implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(unique=true, nullable=false)
	private Integer id;

	@Column(nullable=false, length=2)
	private String code;

	@Column(nullable=false, length=3)
	private String oblast;

	@Column(nullable=false, length=60)
	private String subdivision;

	//bi-directional many-to-one association to CqZone
	@ManyToOne
	@JoinColumn(name="cq_zone_id", nullable=false)
	private CqZone cqZone;

	//bi-directional many-to-one association to Dxcc
	@ManyToOne
	@JoinColumn(name="dxcc_id", nullable=false)
	private Dxcc dxcc;

	//bi-directional many-to-one association to ItuZone
	@ManyToOne
	@JoinColumn(name="itu_xone_id", nullable=false)
	private ItuZone ituZone;

	public Pas126() {
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

	public String getOblast() {
		return this.oblast;
	}

	public void setOblast(String oblast) {
		this.oblast = oblast;
	}

	public String getSubdivision() {
		return this.subdivision;
	}

	public void setSubdivision(String subdivision) {
		this.subdivision = subdivision;
	}

	public CqZone getCqZone() {
		return this.cqZone;
	}

	public void setCqZone(CqZone cqZone) {
		this.cqZone = cqZone;
	}

	public Dxcc getDxcc() {
		return this.dxcc;
	}

	public void setDxcc(Dxcc dxcc) {
		this.dxcc = dxcc;
	}

	public ItuZone getItuZone() {
		return this.ituZone;
	}

	public void setItuZone(ItuZone ituZone) {
		this.ituZone = ituZone;
	}

}