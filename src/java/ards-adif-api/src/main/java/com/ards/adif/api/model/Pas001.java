package com.ards.adif.api.model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the pas_001 database table.
 * 
 */
@Entity
@Table(name="pas_001")
@NamedQuery(name="Pas001.findAll", query="SELECT p FROM Pas001 p")
public class Pas001 implements Serializable {
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

	//bi-directional many-to-one association to Pas001Cqzone
	@OneToMany(mappedBy="pas001")
	private List<Pas001Cqzone> pas001Cqzones;

	//bi-directional many-to-one association to Pas001Ituzone
	@OneToMany(mappedBy="pas001")
	private List<Pas001Ituzone> pas001Ituzones;

	public Pas001() {
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

	public List<Pas001Cqzone> getPas001Cqzones() {
		return this.pas001Cqzones;
	}

	public void setPas001Cqzones(List<Pas001Cqzone> pas001Cqzones) {
		this.pas001Cqzones = pas001Cqzones;
	}

	public Pas001Cqzone addPas001Cqzone(Pas001Cqzone pas001Cqzone) {
		getPas001Cqzones().add(pas001Cqzone);
		pas001Cqzone.setPas001(this);

		return pas001Cqzone;
	}

	public Pas001Cqzone removePas001Cqzone(Pas001Cqzone pas001Cqzone) {
		getPas001Cqzones().remove(pas001Cqzone);
		pas001Cqzone.setPas001(null);

		return pas001Cqzone;
	}

	public List<Pas001Ituzone> getPas001Ituzones() {
		return this.pas001Ituzones;
	}

	public void setPas001Ituzones(List<Pas001Ituzone> pas001Ituzones) {
		this.pas001Ituzones = pas001Ituzones;
	}

	public Pas001Ituzone addPas001Ituzone(Pas001Ituzone pas001Ituzone) {
		getPas001Ituzones().add(pas001Ituzone);
		pas001Ituzone.setPas001(this);

		return pas001Ituzone;
	}

	public Pas001Ituzone removePas001Ituzone(Pas001Ituzone pas001Ituzone) {
		getPas001Ituzones().remove(pas001Ituzone);
		pas001Ituzone.setPas001(null);

		return pas001Ituzone;
	}

}