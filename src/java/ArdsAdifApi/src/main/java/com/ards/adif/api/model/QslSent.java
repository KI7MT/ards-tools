package com.ards.adif.api.model;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the qsl_sent database table.
 * 
 */
@Entity
@Table(name="qsl_sent")
@NamedQuery(name="QslSent.findAll", query="SELECT q FROM QslSent q")
public class QslSent implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(unique=true, nullable=false)
	private Integer id;

	@Column(length=255)
	private String description;

	@Column(nullable=false, length=20)
	private String meaning;

	@Column(nullable=false, length=1)
	private String status;

	public QslSent() {
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