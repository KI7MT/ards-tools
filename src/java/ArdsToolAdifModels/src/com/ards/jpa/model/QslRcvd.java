package com.ards.jpa.model;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the qsl_rcvd database table.
 * 
 */
@Entity
@Table(name="qsl_rcvd")
@NamedQuery(name="QslRcvd.findAll", query="SELECT q FROM QslRcvd q")
public class QslRcvd implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(unique=true, nullable=false)
	private Integer id;

	@Column(length=255)
	private String description;

	@Column(name="import_only", nullable=false)
	private Boolean importOnly;

	@Column(nullable=false, length=20)
	private String meaning;

	@Column(nullable=false, length=1)
	private String status;

	public QslRcvd() {
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

	public String getMeaning() {
		return this.meaning;
	}

	public void setMeaning(String meaning) {
		this.meaning = meaning;
	}

	public String getStatus() {
		return this.status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

}