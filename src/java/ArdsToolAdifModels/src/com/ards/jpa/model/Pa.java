package com.ards.jpa.model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the pas database table.
 * 
 */
@Entity
@Table(name="pas")
@NamedQuery(name="Pa.findAll", query="SELECT p FROM Pa p")
public class Pa implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(unique=true, nullable=false)
	private Integer id;

	@Column(nullable=false, length=10)
	private String code;

	@Column(nullable=false, length=80)
	private String subdivision;

	//bi-directional many-to-one association to DxccEntity
	@ManyToOne
	@JoinColumn(name="dxcc_entity_id", nullable=false)
	private DxccEntity dxccEntity;

	//bi-directional many-to-one association to Sa
	@OneToMany(mappedBy="pa")
	private List<Sa> sas;

	public Pa() {
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

	public String getSubdivision() {
		return this.subdivision;
	}

	public void setSubdivision(String subdivision) {
		this.subdivision = subdivision;
	}

	public DxccEntity getDxccEntity() {
		return this.dxccEntity;
	}

	public void setDxccEntity(DxccEntity dxccEntity) {
		this.dxccEntity = dxccEntity;
	}

	public List<Sa> getSas() {
		return this.sas;
	}

	public void setSas(List<Sa> sas) {
		this.sas = sas;
	}

	public Sa addSa(Sa sa) {
		getSas().add(sa);
		sa.setPa(this);

		return sa;
	}

	public Sa removeSa(Sa sa) {
		getSas().remove(sa);
		sa.setPa(null);

		return sa;
	}

}