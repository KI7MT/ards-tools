package com.ards.adif.api.model;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the pas_summary database table.
 * 
 */
@Entity
@Table(name="pas_summary")
@NamedQuery(name="PasSummary.findAll", query="SELECT p FROM PasSummary p")
public class PasSummary implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(unique=true, nullable=false)
	private Integer id;

	@Column(name="has_oblast", nullable=false)
	private Boolean hasOblast;

	@Column(name="has_sas", nullable=false)
	private Boolean hasSas;

	//bi-directional many-to-one association to Dxcc
	@ManyToOne
	@JoinColumn(name="dxcc_id", nullable=false)
	private Dxcc dxcc;

	//bi-directional many-to-one association to PasSubdivisionType
	@ManyToOne
	@JoinColumn(name="pas_subdivision_type_id", nullable=false)
	private PasSubdivisionType pasSubdivisionType;

	//bi-directional many-to-one association to SasSubdivisionType
	@ManyToOne
	@JoinColumn(name="sas_subdivision_type_id")
	private SasSubdivisionType sasSubdivisionType;

	public PasSummary() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Boolean getHasOblast() {
		return this.hasOblast;
	}

	public void setHasOblast(Boolean hasOblast) {
		this.hasOblast = hasOblast;
	}

	public Boolean getHasSas() {
		return this.hasSas;
	}

	public void setHasSas(Boolean hasSas) {
		this.hasSas = hasSas;
	}

	public Dxcc getDxcc() {
		return this.dxcc;
	}

	public void setDxcc(Dxcc dxcc) {
		this.dxcc = dxcc;
	}

	public PasSubdivisionType getPasSubdivisionType() {
		return this.pasSubdivisionType;
	}

	public void setPasSubdivisionType(PasSubdivisionType pasSubdivisionType) {
		this.pasSubdivisionType = pasSubdivisionType;
	}

	public SasSubdivisionType getSasSubdivisionType() {
		return this.sasSubdivisionType;
	}

	public void setSasSubdivisionType(SasSubdivisionType sasSubdivisionType) {
		this.sasSubdivisionType = sasSubdivisionType;
	}

}