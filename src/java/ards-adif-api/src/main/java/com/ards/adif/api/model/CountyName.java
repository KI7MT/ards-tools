package com.ards.adif.api.model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the county_name database table.
 * 
 */
@Entity
@Table(name="county_name")
@NamedQuery(name="CountyName.findAll", query="SELECT c FROM CountyName c")
public class CountyName implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(unique=true, nullable=false)
	private Integer id;

	@Column(nullable=false, length=60)
	private String name;

	//bi-directional many-to-one association to StateCounty
	@OneToMany(mappedBy="countyName")
	private List<StateCounty> stateCounties;

	public CountyName() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public List<StateCounty> getStateCounties() {
		return this.stateCounties;
	}

	public void setStateCounties(List<StateCounty> stateCounties) {
		this.stateCounties = stateCounties;
	}

	public StateCounty addStateCounty(StateCounty stateCounty) {
		getStateCounties().add(stateCounty);
		stateCounty.setCountyName(this);

		return stateCounty;
	}

	public StateCounty removeStateCounty(StateCounty stateCounty) {
		getStateCounties().remove(stateCounty);
		stateCounty.setCountyName(null);

		return stateCounty;
	}

}