package com.ards.adif.api.model;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the state_county database table.
 * 
 */
@Entity
@Table(name="state_county")
@NamedQuery(name="StateCounty.findAll", query="SELECT s FROM StateCounty s")
public class StateCounty implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(unique=true, nullable=false)
	private Integer id;

	//bi-directional many-to-one association to CountyName
	@ManyToOne
	@JoinColumn(name="county_name_id", nullable=false)
	private CountyName countyName;

	//bi-directional many-to-one association to State
	@ManyToOne
	@JoinColumn(name="state_id", nullable=false)
	private State state;

	public StateCounty() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public CountyName getCountyName() {
		return this.countyName;
	}

	public void setCountyName(CountyName countyName) {
		this.countyName = countyName;
	}

	public State getState() {
		return this.state;
	}

	public void setState(State state) {
		this.state = state;
	}

}