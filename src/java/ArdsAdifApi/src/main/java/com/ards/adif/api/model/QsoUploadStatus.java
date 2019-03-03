package com.ards.adif.api.model;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the qso_upload_status database table.
 * 
 */
@Entity
@Table(name="qso_upload_status")
@NamedQuery(name="QsoUploadStatus.findAll", query="SELECT q FROM QsoUploadStatus q")
public class QsoUploadStatus implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(unique=true, nullable=false)
	private Integer id;

	@Column(nullable=false, length=1)
	private String abbreviation;

	@Column(nullable=false, length=120)
	private String description;

	public QsoUploadStatus() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getAbbreviaiton() {
		return this.abbreviation;
	}

	public void setAbbreviaiton(String abbreviaiton) {
		this.abbreviation = abbreviaiton;
	}

	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

}