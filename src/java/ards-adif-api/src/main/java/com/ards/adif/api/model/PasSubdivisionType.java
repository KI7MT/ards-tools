package com.ards.adif.api.model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the pas_subdivision_type database table.
 * 
 */
@Entity
@Table(name="pas_subdivision_type")
@NamedQuery(name="PasSubdivisionType.findAll", query="SELECT p FROM PasSubdivisionType p")
public class PasSubdivisionType implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(unique=true, nullable=false)
	private Integer id;

	@Column(name="pas_subdivision_type", nullable=false, length=20)
	private String pasSubdivisionType;

	//bi-directional many-to-one association to PasSummary
	@OneToMany(mappedBy="pasSubdivisionType")
	private List<PasSummary> pasSummaries;

	public PasSubdivisionType() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getPasSubdivisionType() {
		return this.pasSubdivisionType;
	}

	public void setPasSubdivisionType(String pasSubdivisionType) {
		this.pasSubdivisionType = pasSubdivisionType;
	}

	public List<PasSummary> getPasSummaries() {
		return this.pasSummaries;
	}

	public void setPasSummaries(List<PasSummary> pasSummaries) {
		this.pasSummaries = pasSummaries;
	}

	public PasSummary addPasSummary(PasSummary pasSummary) {
		getPasSummaries().add(pasSummary);
		pasSummary.setPasSubdivisionType(this);

		return pasSummary;
	}

	public PasSummary removePasSummary(PasSummary pasSummary) {
		getPasSummaries().remove(pasSummary);
		pasSummary.setPasSubdivisionType(null);

		return pasSummary;
	}

}