package com.ards.jpa.model;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the eqsl_ag_list database table.
 * 
 */
@Entity
@Table(name="eqsl_ag_list")
@NamedQuery(name="EqslAgList.findAll", query="SELECT e FROM EqslAgList e")
public class EqslAgList implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(unique=true, nullable=false)
	private Integer id;

	@Column(nullable=false, length=2147483647)
	private String callsign;

	public EqslAgList() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getCallsign() {
		return this.callsign;
	}

	public void setCallsign(String callsign) {
		this.callsign = callsign;
	}

}