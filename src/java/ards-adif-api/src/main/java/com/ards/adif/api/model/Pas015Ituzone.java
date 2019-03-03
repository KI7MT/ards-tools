package com.ards.adif.api.model;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the pas_015_ituzone database table.
 * 
 */
@Entity
@Table(name="pas_015_ituzone")
@NamedQuery(name="Pas015Ituzone.findAll", query="SELECT p FROM Pas015Ituzone p")
public class Pas015Ituzone implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(unique=true, nullable=false)
	private Integer id;

	//bi-directional many-to-one association to ItuZone
	@ManyToOne
	@JoinColumn(name="itu_zone_id", nullable=false)
	private ItuZone ituZone;

	//bi-directional many-to-one association to Pas015
	@ManyToOne
	@JoinColumn(name="pas_015_id", nullable=false)
	private Pas015 pas015;

	public Pas015Ituzone() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public ItuZone getItuZone() {
		return this.ituZone;
	}

	public void setItuZone(ItuZone ituZone) {
		this.ituZone = ituZone;
	}

	public Pas015 getPas015() {
		return this.pas015;
	}

	public void setPas015(Pas015 pas015) {
		this.pas015 = pas015;
	}

}