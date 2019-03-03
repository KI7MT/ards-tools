package com.ards.adif.api.model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the sas_subdivision_type database table.
 * 
 */
@Entity
@Table(name="sas_subdivision_type")
@NamedQuery(name="SasSubdivisionType.findAll", query="SELECT s FROM SasSubdivisionType s")
public class SasSubdivisionType implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(unique=true, nullable=false)
	private Integer id;

	@Column(name="sas_subdivision_type", nullable=false, length=20)
	private String sasSubdivisionType;

	//bi-directional many-to-one association to PasSummary
	@OneToMany(mappedBy="sasSubdivisionType")
	private List<PasSummary> pasSummaries;

	public SasSubdivisionType() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getSasSubdivisionType() {
		return this.sasSubdivisionType;
	}

	public void setSasSubdivisionType(String sasSubdivisionType) {
		this.sasSubdivisionType = sasSubdivisionType;
	}

	public List<PasSummary> getPasSummaries() {
		return this.pasSummaries;
	}

	public void setPasSummaries(List<PasSummary> pasSummaries) {
		this.pasSummaries = pasSummaries;
	}

	public PasSummary addPasSummary(PasSummary pasSummary) {
		getPasSummaries().add(pasSummary);
		pasSummary.setSasSubdivisionType(this);

		return pasSummary;
	}

	public PasSummary removePasSummary(PasSummary pasSummary) {
		getPasSummaries().remove(pasSummary);
		pasSummary.setSasSubdivisionType(null);

		return pasSummary;
	}

}