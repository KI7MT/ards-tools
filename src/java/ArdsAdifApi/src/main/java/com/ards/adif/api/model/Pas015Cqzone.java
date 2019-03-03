package com.ards.adif.api.model;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the pas_015_cqzone database table.
 * 
 */
@Entity
@Table(name="pas_015_cqzone")
@NamedQuery(name="Pas015Cqzone.findAll", query="SELECT p FROM Pas015Cqzone p")
public class Pas015Cqzone implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(unique=true, nullable=false)
	private Integer id;

	//bi-directional many-to-one association to CqZone
	@ManyToOne
	@JoinColumn(name="cq_zone_id", nullable=false)
	private CqZone cqZone;

	//bi-directional many-to-one association to Pas015
	@ManyToOne
	@JoinColumn(name="pas_015_id", nullable=false)
	private Pas015 pas015;

	public Pas015Cqzone() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public CqZone getCqZone() {
		return this.cqZone;
	}

	public void setCqZone(CqZone cqZone) {
		this.cqZone = cqZone;
	}

	public Pas015 getPas015() {
		return this.pas015;
	}

	public void setPas015(Pas015 pas015) {
		this.pas015 = pas015;
	}

}