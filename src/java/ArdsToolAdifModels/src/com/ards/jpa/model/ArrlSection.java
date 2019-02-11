package com.ards.jpa.model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.Date;


/**
 * The persistent class for the arrl_section database table.
 * 
 */
@Entity
@Table(name="arrl_section")
@NamedQuery(name="ArrlSection.findAll", query="SELECT a FROM ArrlSection a")
public class ArrlSection implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(unique=true, nullable=false)
	private Integer id;

	@Column(nullable=false, length=4)
	private String abbreviation;

	@Temporal(TemporalType.DATE)
	@Column(name="deleted_date")
	private Date deletedDate;

	@Temporal(TemporalType.DATE)
	@Column(name="from_date")
	private Date fromDate;

	@Column(nullable=false, length=70)
	private String name;

	//bi-directional many-to-one association to DxccEntity
	@ManyToOne
	@JoinColumn(name="dxcc_entity_id", nullable=false)
	private DxccEntity dxccEntity;

	public ArrlSection() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getAbbreviation() {
		return this.abbreviation;
	}

	public void setAbbreviation(String abbreviation) {
		this.abbreviation = abbreviation;
	}

	public Date getDeletedDate() {
		return this.deletedDate;
	}

	public void setDeletedDate(Date deletedDate) {
		this.deletedDate = deletedDate;
	}

	public Date getFromDate() {
		return this.fromDate;
	}

	public void setFromDate(Date fromDate) {
		this.fromDate = fromDate;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public DxccEntity getDxccEntity() {
		return this.dxccEntity;
	}

	public void setDxccEntity(DxccEntity dxccEntity) {
		this.dxccEntity = dxccEntity;
	}

}