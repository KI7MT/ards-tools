package com.ards.adif.api.model;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the pas_291_ituzone database table.
 * 
 */
@Entity
@Table(name="pas_291_ituzone")
@NamedQuery(name="Pas291Ituzone.findAll", query="SELECT p FROM Pas291Ituzone p")
public class Pas291Ituzone implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(unique=true, nullable=false)
	private Integer id;

	//bi-directional many-to-one association to ItuZone
	@ManyToOne
	@JoinColumn(name="itu_zone_id", nullable=false)
	private ItuZone ituZone;

	//bi-directional many-to-one association to Pas291
	@ManyToOne
	@JoinColumn(name="pas_291_id", nullable=false)
	private Pas291 pas291;

	public Pas291Ituzone() {
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

	public Pas291 getPas291() {
		return this.pas291;
	}

	public void setPas291(Pas291 pas291) {
		this.pas291 = pas291;
	}

}