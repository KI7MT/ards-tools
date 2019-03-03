package com.ards.adif.api.model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the state database table.
 * 
 */
@Entity
@Table(name="state")
@NamedQuery(name="State.findAll", query="SELECT s FROM State s")
public class State implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(unique=true, nullable=false)
	private Integer id;

	@Column(nullable=false, length=2)
	private String abbreviation;

	@Column(nullable=false, length=20)
	private String name;

	//bi-directional many-to-one association to StateCounty
	@OneToMany(mappedBy="state")
	private List<StateCounty> stateCounties;

	public State() {
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
		stateCounty.setState(this);

		return stateCounty;
	}

	public StateCounty removeStateCounty(StateCounty stateCounty) {
		getStateCounties().remove(stateCounty);
		stateCounty.setState(null);

		return stateCounty;
	}

}