package com.ards.adif.api.model;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the propogation_mode database table.
 * 
 */
@Entity
@Table(name="propogation_mode")
@NamedQuery(name="PropogationMode.findAll", query="SELECT p FROM PropogationMode p")
public class PropogationMode implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(unique=true, nullable=false)
	private Integer id;

	@Column(nullable=false, length=120)
	private String description;

	@Column(nullable=false, length=20)
	private String enumeration;

	public PropogationMode() {
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

	public String getEnumeration() {
		return this.enumeration;
	}

	public void setEnumeration(String enumeration) {
		this.enumeration = enumeration;
	}

}