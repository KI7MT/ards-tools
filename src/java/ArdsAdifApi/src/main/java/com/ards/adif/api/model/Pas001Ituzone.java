package com.ards.adif.api.model;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the pas_001_ituzone database table.
 * 
 */
@Entity
@Table(name="pas_001_ituzone")
@NamedQuery(name="Pas001Ituzone.findAll", query="SELECT p FROM Pas001Ituzone p")
public class Pas001Ituzone implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(unique=true, nullable=false)
	private Integer id;

	//bi-directional many-to-one association to ItuZone
	@ManyToOne
	@JoinColumn(name="itu_zone_id", nullable=false)
	private ItuZone ituZone;

	//bi-directional many-to-one association to Pas001
	@ManyToOne
	@JoinColumn(name="pas_001_id", nullable=false)
	private Pas001 pas001;

	public Pas001Ituzone() {
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

	public Pas001 getPas001() {
		return this.pas001;
	}

	public void setPas001(Pas001 pas001) {
		this.pas001 = pas001;
	}

}