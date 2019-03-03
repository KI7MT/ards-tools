package com.ards.adif.api.model;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the pas_291_cqzone database table.
 * 
 */
@Entity
@Table(name="pas_291_cqzone")
@NamedQuery(name="Pas291Cqzone.findAll", query="SELECT p FROM Pas291Cqzone p")
public class Pas291Cqzone implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(unique=true, nullable=false)
	private Integer id;

	//bi-directional many-to-one association to CqZone
	@ManyToOne
	@JoinColumn(name="cq_zone_id", nullable=false)
	private CqZone cqZone;

	//bi-directional many-to-one association to Pas291
	@ManyToOne
	@JoinColumn(name="pas_291_id", nullable=false)
	private Pas291 pas291;

	public Pas291Cqzone() {
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

	public Pas291 getPas291() {
		return this.pas291;
	}

	public void setPas291(Pas291 pas291) {
		this.pas291 = pas291;
	}

}