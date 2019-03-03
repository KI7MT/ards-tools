package com.ards.adif.api.model;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the qsl_medium database table.
 * 
 */
@Entity
@Table(name="qsl_medium")
@NamedQuery(name="QslMedium.findAll", query="SELECT q FROM QslMedium q")
public class QslMedium implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(unique=true, nullable=false)
	private Integer id;

	@Column(nullable=false, length=120)
	private String description;

	@Column(nullable=false, length=10)
	private String medium;

	public QslMedium() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getMedium() {
		return this.medium;
	}

	public void setMedium(String medium) {
		this.medium = medium;
	}

}