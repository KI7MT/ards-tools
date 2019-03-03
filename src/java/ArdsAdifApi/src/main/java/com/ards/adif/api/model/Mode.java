package com.ards.adif.api.model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the mode database table.
 * 
 */
@Entity
@Table(name="mode")
@NamedQuery(name="Mode.findAll", query="SELECT m FROM Mode m")
public class Mode implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(unique=true, nullable=false)
	private Integer id;

	@Column(name="import_only", nullable=false)
	private Boolean importOnly;

	@Column(nullable=false, length=20)
	private String name;

	//bi-directional many-to-one association to ModeDescription
	@ManyToOne
	@JoinColumn(name="mode_description_id")
	private ModeDescription modeDescription;

	//bi-directional many-to-one association to Submode
	@OneToMany(mappedBy="mode")
	private List<Submode> submodes;

	public Mode() {
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

	public ModeDescription getModeDescription() {
		return this.modeDescription;
	}

	public void setModeDescription(ModeDescription modeDescription) {
		this.modeDescription = modeDescription;
	}

	public List<Submode> getSubmodes() {
		return this.submodes;
	}

	public void setSubmodes(List<Submode> submodes) {
		this.submodes = submodes;
	}

	public Submode addSubmode(Submode submode) {
		getSubmodes().add(submode);
		submode.setMode(this);

		return submode;
	}

	public Submode removeSubmode(Submode submode) {
		getSubmodes().remove(submode);
		submode.setMode(null);

		return submode;
	}

}