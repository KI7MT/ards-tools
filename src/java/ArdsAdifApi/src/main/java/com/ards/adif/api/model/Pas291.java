package com.ards.adif.api.model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the pas_291 database table.
 * 
 */
@Entity
@Table(name="pas_291")
@NamedQuery(name="Pas291.findAll", query="SELECT p FROM Pas291 p")
public class Pas291 implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(unique=true, nullable=false)
	private Integer id;

	@Column(nullable=false, length=2)
	private String code;

	@Column(nullable=false, length=60)
	private String subdivision;

	//bi-directional many-to-one association to Dxcc
	@ManyToOne
	@JoinColumn(name="dxcc_id", nullable=false)
	private Dxcc dxcc;

	//bi-directional many-to-one association to Pas291Cqzone
	@OneToMany(mappedBy="pas291")
	private List<Pas291Cqzone> pas291Cqzones;

	//bi-directional many-to-one association to Pas291Ituzone
	@OneToMany(mappedBy="pas291")
	private List<Pas291Ituzone> pas291Ituzones;

	public Pas291() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getCode() {
		return this.code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getSubdivision() {
		return this.subdivision;
	}

	public void setSubdivision(String subdivision) {
		this.subdivision = subdivision;
	}

	public Dxcc getDxcc() {
		return this.dxcc;
	}

	public void setDxcc(Dxcc dxcc) {
		this.dxcc = dxcc;
	}

	public List<Pas291Cqzone> getPas291Cqzones() {
		return this.pas291Cqzones;
	}

	public void setPas291Cqzones(List<Pas291Cqzone> pas291Cqzones) {
		this.pas291Cqzones = pas291Cqzones;
	}

	public Pas291Cqzone addPas291Cqzone(Pas291Cqzone pas291Cqzone) {
		getPas291Cqzones().add(pas291Cqzone);
		pas291Cqzone.setPas291(this);

		return pas291Cqzone;
	}

	public Pas291Cqzone removePas291Cqzone(Pas291Cqzone pas291Cqzone) {
		getPas291Cqzones().remove(pas291Cqzone);
		pas291Cqzone.setPas291(null);

		return pas291Cqzone;
	}

	public List<Pas291Ituzone> getPas291Ituzones() {
		return this.pas291Ituzones;
	}

	public void setPas291Ituzones(List<Pas291Ituzone> pas291Ituzones) {
		this.pas291Ituzones = pas291Ituzones;
	}

	public Pas291Ituzone addPas291Ituzone(Pas291Ituzone pas291Ituzone) {
		getPas291Ituzones().add(pas291Ituzone);
		pas291Ituzone.setPas291(this);

		return pas291Ituzone;
	}

	public Pas291Ituzone removePas291Ituzone(Pas291Ituzone pas291Ituzone) {
		getPas291Ituzones().remove(pas291Ituzone);
		pas291Ituzone.setPas291(null);

		return pas291Ituzone;
	}

}