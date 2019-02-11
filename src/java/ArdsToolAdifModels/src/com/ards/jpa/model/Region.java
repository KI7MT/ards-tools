package com.ards.jpa.model;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the region database table.
 * 
 */
@Entity
@Table(name="region")
@NamedQuery(name="Region.findAll", query="SELECT r FROM Region r")
public class Region implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(unique=true, nullable=false)
	private Integer id;

	@Column(length=4)
	private String code;

	@Column(length=10)
	private String prefix;

	@Column(length=120)
	private String region;

	//bi-directional many-to-one association to DxccEntity
	@ManyToOne
	@JoinColumn(name="dxcc_entity_id")
	private DxccEntity dxccEntity;

	public Region() {
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

	public String getPrefix() {
		return this.prefix;
	}

	public void setPrefix(String prefix) {
		this.prefix = prefix;
	}

	public String getRegion() {
		return this.region;
	}

	public void setRegion(String region) {
		this.region = region;
	}

	public DxccEntity getDxccEntity() {
		return this.dxccEntity;
	}

	public void setDxccEntity(DxccEntity dxccEntity) {
		this.dxccEntity = dxccEntity;
	}

}