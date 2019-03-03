package com.ards.adif.api.model;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the antenna_path database table.
 * 
 */
@Entity
@Table(name="ANTENNA_PATH")
@NamedQuery(name="AntennaPath.findAll", query="SELECT a FROM AntennaPath a")
public class AntennaPath implements Serializable {
	
	private static final long serialVersionUID = 1L;

	@Id
	@Column(unique=true, nullable=false)
	private Integer id;

	@Column(nullable=false, length=1)
	private String abbreviation;

	@Column(nullable=false, length=15)
	private String meaning;

	public AntennaPath() {
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