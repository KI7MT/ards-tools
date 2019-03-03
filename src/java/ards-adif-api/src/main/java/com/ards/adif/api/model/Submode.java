package com.ards.adif.api.model;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the submode database table.
 * 
 */
@Entity
@Table(name="submode")
@NamedQuery(name="Submode.findAll", query="SELECT s FROM Submode s")
public class Submode implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(unique=true, nullable=false)
	private Integer id;

	@Column(nullable=false, length=20)
	private String name;

	//bi-directional many-to-one association to Mode
	@ManyToOne
	@JoinColumn(name="mode_id", nullable=false)
	private Mode mode;

	//bi-directional many-to-one association to ModeDescription
	@ManyToOne
	@JoinColumn(name="mode_description_id")
	private ModeDescription modeDescription;

	public Submode() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Mode getMode() {
		return this.mode;
	}

	public void setMode(Mode mode) {
		this.mode = mode;
	}

	public ModeDescription getModeDescription() {
		return this.modeDescription;
	}

	public void setModeDescription(ModeDescription modeDescription) {
		this.modeDescription = modeDescription;
	}

}