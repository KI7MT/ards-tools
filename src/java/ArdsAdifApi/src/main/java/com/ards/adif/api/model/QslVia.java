package com.ards.adif.api.model;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the qsl_via database table.
 * 
 */
@Entity
@Table(name="qsl_via")
@NamedQuery(name="QslVia.findAll", query="SELECT q FROM QslVia q")
public class QslVia implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(unique=true, nullable=false)
	private Integer id;

	@Column(nullable=false, length=20)
	private String description;

	@Column(name="import_only", nullable=false)
	private Boolean importOnly;

	@Column(nullable=false, length=1)
	private String via;

	public QslVia() {
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

	public Boolean getImportOnly() {
		return this.importOnly;
	}

	public void setImportOnly(Boolean importOnly) {
		this.importOnly = importOnly;
	}

	public String getVia() {
		return this.via;
	}

	public void setVia(String via) {
		this.via = via;
	}

}