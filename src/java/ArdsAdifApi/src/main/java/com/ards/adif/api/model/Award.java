package com.ards.adif.api.model;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the award database table.
 * 
 */
@Entity
@Table(name="award")
@NamedQuery(name="Award.findAll", query="SELECT a FROM Award a")
public class Award implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(unique=true, nullable=false)
	private Integer id;

	@Column(name="import_only")
	private Boolean importOnly;

	@Column(nullable=false, length=15)
	private String name;

	public Award() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Boolean getImportOnly() {
		return this.importOnly;
	}

	public void setImportOnly(Boolean importOnly) {
		this.importOnly = importOnly;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

}