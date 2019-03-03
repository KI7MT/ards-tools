package com.ards.adif.api.model;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the qso_complete database table.
 * 
 */
@Entity
@Table(name="qso_complete")
@NamedQuery(name="QsoComplete.findAll", query="SELECT q FROM QsoComplete q")
public class QsoComplete implements Serializable {
	
	private static final long serialVersionUID = 1L;

	@Id
	@Column(unique=true, nullable=false)
	private Integer id;

	@Column(nullable=false, length=5)
	private String abbreviation;

	@Column(nullable=false, length=20)
	private String meaning;

	public QsoComplete() {
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

	public String getMeaning() {
		return this.meaning;
	}

	public void setMeaning(String meaning) {
		this.meaning = meaning;
	}

}