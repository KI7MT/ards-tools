package com.ards.adif.api.model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.Date;
import java.util.List;


/**
 * The persistent class for the pas_015 database table.
 * 
 */
@Entity
@Table(name="pas_015")
@NamedQuery(name="Pas015.findAll", query="SELECT p FROM Pas015 p")
public class Pas015 implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(unique=true, nullable=false)
	private Integer id;

	@Temporal(TemporalType.DATE)
	@Column(name="before_date")
	private Date beforeDate;

	@Column(nullable=false, length=2)
	private String code;

	@Column(nullable=false, length=3)
	private String oblast;

	@Column(name="referred_to_as", length=80)
	private String referredToAs;

	@Column(nullable=false, length=80)
	private String subdivision;

	//bi-directional many-to-one association to Dxcc
	@ManyToOne
	@JoinColumn(name="dxcc_id", nullable=false)
	private Dxcc dxcc;

	//bi-directional many-to-one association to Pas015Cqzone
	@OneToMany(mappedBy="pas015")
	private List<Pas015Cqzone> pas015Cqzones;

	//bi-directional many-to-one association to Pas015Ituzone
	@OneToMany(mappedBy="pas015")
	private List<Pas015Ituzone> pas015Ituzones;

	public Pas015() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Date getBeforeDate() {
		return this.beforeDate;
	}

	public void setBeforeDate(Date beforeDate) {
		this.beforeDate = beforeDate;
	}

	public String getCode() {
		return this.code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getOblast() {
		return this.oblast;
	}

	public void setOblast(String oblast) {
		this.oblast = oblast;
	}

	public String getReferredToAs() {
		return this.referredToAs;
	}

	public void setReferredToAs(String referredToAs) {
		this.referredToAs = referredToAs;
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

	public List<Pas015Cqzone> getPas015Cqzones() {
		return this.pas015Cqzones;
	}

	public void setPas015Cqzones(List<Pas015Cqzone> pas015Cqzones) {
		this.pas015Cqzones = pas015Cqzones;
	}

	public Pas015Cqzone addPas015Cqzone(Pas015Cqzone pas015Cqzone) {
		getPas015Cqzones().add(pas015Cqzone);
		pas015Cqzone.setPas015(this);

		return pas015Cqzone;
	}

	public Pas015Cqzone removePas015Cqzone(Pas015Cqzone pas015Cqzone) {
		getPas015Cqzones().remove(pas015Cqzone);
		pas015Cqzone.setPas015(null);

		return pas015Cqzone;
	}

	public List<Pas015Ituzone> getPas015Ituzones() {
		return this.pas015Ituzones;
	}

	public void setPas015Ituzones(List<Pas015Ituzone> pas015Ituzones) {
		this.pas015Ituzones = pas015Ituzones;
	}

	public Pas015Ituzone addPas015Ituzone(Pas015Ituzone pas015Ituzone) {
		getPas015Ituzones().add(pas015Ituzone);
		pas015Ituzone.setPas015(this);

		return pas015Ituzone;
	}

	public Pas015Ituzone removePas015Ituzone(Pas015Ituzone pas015Ituzone) {
		getPas015Ituzones().remove(pas015Ituzone);
		pas015Ituzone.setPas015(null);

		return pas015Ituzone;
	}

}