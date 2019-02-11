package com.ards.jpa.model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the dxcc_entity database table.
 * 
 */
@Entity
@Table(name="dxcc_entity")
@NamedQuery(name="DxccEntity.findAll", query="SELECT d FROM DxccEntity d")
public class DxccEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(unique=true, nullable=false)
	private Integer id;

	@Column(nullable=false, length=4)
	private String code;

	@Column(name="is_deleted")
	private Boolean isDeleted;

	@Column(nullable=false, length=90)
	private String name;

	//bi-directional many-to-one association to ArrlSection
	@OneToMany(mappedBy="dxccEntity")
	private List<ArrlSection> arrlSections;

	//bi-directional many-to-one association to Pa
	@OneToMany(mappedBy="dxccEntity")
	private List<Pa> pas;

	//bi-directional many-to-one association to Region
	@OneToMany(mappedBy="dxccEntity")
	private List<Region> regions;

	public DxccEntity() {
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

	public Boolean getIsDeleted() {
		return this.isDeleted;
	}

	public void setIsDeleted(Boolean isDeleted) {
		this.isDeleted = isDeleted;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public List<ArrlSection> getArrlSections() {
		return this.arrlSections;
	}

	public void setArrlSections(List<ArrlSection> arrlSections) {
		this.arrlSections = arrlSections;
	}

	public ArrlSection addArrlSection(ArrlSection arrlSection) {
		getArrlSections().add(arrlSection);
		arrlSection.setDxccEntity(this);

		return arrlSection;
	}

	public ArrlSection removeArrlSection(ArrlSection arrlSection) {
		getArrlSections().remove(arrlSection);
		arrlSection.setDxccEntity(null);

		return arrlSection;
	}

	public List<Pa> getPas() {
		return this.pas;
	}

	public void setPas(List<Pa> pas) {
		this.pas = pas;
	}

	public Pa addPa(Pa pa) {
		getPas().add(pa);
		pa.setDxccEntity(this);

		return pa;
	}

	public Pa removePa(Pa pa) {
		getPas().remove(pa);
		pa.setDxccEntity(null);

		return pa;
	}

	public List<Region> getRegions() {
		return this.regions;
	}

	public void setRegions(List<Region> regions) {
		this.regions = regions;
	}

	public Region addRegion(Region region) {
		getRegions().add(region);
		region.setDxccEntity(this);

		return region;
	}

	public Region removeRegion(Region region) {
		getRegions().remove(region);
		region.setDxccEntity(null);

		return region;
	}

}