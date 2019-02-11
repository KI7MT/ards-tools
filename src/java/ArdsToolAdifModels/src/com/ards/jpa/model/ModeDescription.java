package com.ards.jpa.model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the mode_description database table.
 * 
 */
@Entity
@Table(name="mode_description")
@NamedQuery(name="ModeDescription.findAll", query="SELECT m FROM ModeDescription m")
public class ModeDescription implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(unique=true, nullable=false)
	private Integer id;

	@Column(nullable=false, length=120)
	private String description;

	//bi-directional many-to-one association to Mode
	@OneToMany(mappedBy="modeDescription")
	private List<Mode> modes;

	//bi-directional many-to-one association to Submode
	@OneToMany(mappedBy="modeDescription")
	private List<Submode> submodes;

	public ModeDescription() {
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

	public List<Mode> getModes() {
		return this.modes;
	}

	public void setModes(List<Mode> modes) {
		this.modes = modes;
	}

	public Mode addMode(Mode mode) {
		getModes().add(mode);
		mode.setModeDescription(this);

		return mode;
	}

	public Mode removeMode(Mode mode) {
		getModes().remove(mode);
		mode.setModeDescription(null);

		return mode;
	}

	public List<Submode> getSubmodes() {
		return this.submodes;
	}

	public void setSubmodes(List<Submode> submodes) {
		this.submodes = submodes;
	}

	public Submode addSubmode(Submode submode) {
		getSubmodes().add(submode);
		submode.setModeDescription(this);

		return submode;
	}

	public Submode removeSubmode(Submode submode) {
		getSubmodes().remove(submode);
		submode.setModeDescription(null);

		return submode;
	}

}